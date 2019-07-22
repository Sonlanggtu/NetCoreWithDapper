using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using WebAPICoreDapper.Constants;
using WebAPICoreDapper.Extensions;
using WebAPICoreDapper.Fillter;
using WebAPICoreDapper.Models;
using WebAPICoreDapper.ViewModels;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/{culture}[controller]")]
    [ApiController]
    [MiddlewareFilter(typeof(LocalizationPipeline))]
    [Authorize]
    public class AccountController : ControllerBase
    {
        private readonly string _connectionString;
        private readonly IConfiguration _configuration;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly UserManager<AppUser> _userManager;

        public AccountController(IConfiguration configuration, SignInManager<AppUser> signInManager,
            UserManager<AppUser> userManager)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
            _configuration = configuration;
            _signInManager = signInManager;
            _userManager = userManager;
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("login")]
        [ValidateModel]
        public async Task<IActionResult> Login([FromBody] LoginViewModel model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user != null)
            {
                var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, false, true);
                if (!result.Succeeded)
                    return BadRequest("Mật khẩu không đúng");
                var roles = await _userManager.GetRolesAsync(user);
                var permissions = await GetPermissionByUserId(user.Id.ToString());
                var claims = new[]
                {
                    new Claim("Email", user.Email),
                    new Claim(SystemConstants.UserClaim.Id, user.Id.ToString()),
                    new Claim(ClaimTypes.Name, user.UserName),
                    new Claim(SystemConstants.UserClaim.FullName, user.FullName??string.Empty),
                    new Claim(SystemConstants.UserClaim.Roles, string.Join(";", roles)),
                    new Claim(SystemConstants.UserClaim.Permissions, JsonConvert.SerializeObject(permissions)),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                };
                var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Tokens:Key"]));
                var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                var token = new JwtSecurityToken(_configuration["Tokens:Issuer"],
                    _configuration["Tokens:Issuer"],
                     claims,
                    expires: DateTime.Now.AddHours(2),
                    signingCredentials: creds);

                return Ok(new { token = new JwtSecurityTokenHandler().WriteToken(token) });
            }
            return NotFound($"Không tìm thấy tài khoản {model.UserName}");
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("register")]
        [ValidateModel]
        public async Task<IActionResult> Register(RegisterViewModel model)
        {
            var user = new AppUser { FullName = model.FullName, UserName = model.UserName, Email = model.Email };

            var result = await _userManager.CreateAsync(user, model.Password);

            if (result.Succeeded)
            {
                using (var conn = new SqlConnection(_connectionString))
                {
                    if (conn.State == System.Data.ConnectionState.Closed)
                        conn.Open();

                    Guid RolesId = Guid.NewGuid();
                    var paramaters = new DynamicParameters();
                    paramaters.Add("@RoleId", RolesId);
                    paramaters.Add("@UserName", model.UserName);
                    paramaters.Add("@UserId", user.Id);
                    var results = await conn.QueryAsync<string>("Create_Role_UserRole", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                    return Ok(model);
                }


                
            }

            return BadRequest();
        }


        private async Task<List<string>> GetPermissionByUserId(string userId)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();

                var paramaters = new DynamicParameters();
                paramaters.Add("@userId", userId);

                var result = await conn.QueryAsync<string>("Get_Permission_ByUserId", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return result.ToList();
            }
        }

    }
}