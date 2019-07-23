using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Data.ViewModels;
using WebAPICoreDapper.Extensions;
using WebAPICoreDapper.Fillter;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/{culture}[controller]")]
    [ApiController]
    [MiddlewareFilter(typeof(LocalizationPipeline))]
    [Authorize]
    public class AccountController : ControllerBase
    {
        private readonly SignInManager<AppUser> _signInManager;
        private readonly UserManager<AppUser> _userManager;
        private readonly IAccountRepository _accountRepository;
        public AccountController( SignInManager<AppUser> signInManager,
            UserManager<AppUser> userManager, IAccountRepository accountRepository)
        {
            _signInManager = signInManager;
            _userManager = userManager;
            _accountRepository = accountRepository;
        }

        [HttpPost]
        [AllowAnonymous]
        [Route("login")]
        [ValidateModel]
        public async Task<object> Login([FromBody] LoginViewModel model)
        {
            var user = await _userManager.FindByNameAsync(model.UserName);
            if (user != null)
            {
                var result = await _signInManager.PasswordSignInAsync(model.UserName, model.Password, false, true);
                if (!result.Succeeded)
                    return BadRequest("Mật khẩu không đúng");
                return Ok(await _accountRepository.Loginsync(user));
            }
            else
            {
                return NotFound($"Không tìm thấy tài khoản {model.UserName}");
            }
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
                return Ok(await _accountRepository.RegisterAsync(model, user));
            }
            return BadRequest();
        }
    }
}