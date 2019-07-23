using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Fillter;
using WebAPICoreDapper.Filter;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    [AllowAnonymous]
    public class UserController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly IUserRepository _userRepository;

        public UserController(UserManager<AppUser> userManager,
            IUserRepository userRepository)
        {
            _userManager = userManager;
            _userRepository = userRepository;
        }

        [HttpGet]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get()
        {
            return Ok(await _userRepository.GetUserAsync());
        }

        [HttpGet("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get(string id)
        {
            return Ok(await _userRepository.GetUserByIdAsync(id));
        }

        [HttpGet("paging")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetPaging(string keyword, int pageIndex, int pageSize)
        {
            return Ok(await _userRepository.GetPagingUserAsync(keyword, pageIndex, pageSize));
        }

        [HttpPost]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> Post([FromBody] AppUser user)
        {
            var result = await _userManager.CreateAsync(user, user.PasswordHash);
            if (result.Succeeded)
                return Ok();
            return BadRequest(result);
        }

        [HttpPut("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.UPDATE)]
        public async Task<IActionResult> Put([Required]Guid id, [FromBody] AppUser user)
        {
            user.Id = id;
            var result = await _userManager.UpdateAsync(user);
            if (result.Succeeded)
                return Ok();
            return BadRequest();
        }

        [HttpDelete("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.DELETE)]
        public async Task<IActionResult> Delete(string id)
        {
            var role = await _userManager.FindByIdAsync(id);
            var result = await _userManager.DeleteAsync(role);
            if (result.Succeeded)
                return Ok();
            return BadRequest();
        }

        [HttpGet("{id}/roles")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetUserRoles(string id)
        {
            var user = await _userManager.FindByIdAsync(id.ToString());
            var model = await _userManager.GetRolesAsync(user);
            return Ok(model);
        }
    }
}