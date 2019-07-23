using Dapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using WebAPICoreDapper.Constants;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Data.ViewModels;

namespace WebAPICoreDapper.Data.Repository
{
    public class AccountRepository : IAccountRepository
    {
        private readonly string _connectionString;
        private readonly IConfiguration _configuration;
        private readonly UserManager<AppUser> _userManager;

        public AccountRepository(IConfiguration configuration,
            UserManager<AppUser> userManager)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
            _configuration = configuration;
            _userManager = userManager;
        }

        
        public async Task<object> Loginsync(AppUser user)
        { 
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
                return (new { token = new JwtSecurityTokenHandler().WriteToken(token) });            
        }


        public async Task<object> RegisterAsync(RegisterViewModel model, AppUser user)
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
                return model;
            }
        }


        #region GetPermissionByUserId
        public async Task<List<string>> GetPermissionByUserId(string userId)
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
        #endregion
    }
}