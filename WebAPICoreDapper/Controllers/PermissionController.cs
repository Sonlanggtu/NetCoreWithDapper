using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Filter;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PermissionController : ControllerBase
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly IPermissionRepository _permissionRepository;

        public PermissionController(IConfiguration configuration, UserManager<AppUser> userManager,
            IPermissionRepository permissionRepository)
        {
            _userManager = userManager;
            _permissionRepository = permissionRepository;
        }

        [HttpGet("function-actions")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetAllWithPermission()
        {
            return Ok(await _permissionRepository.GetAllWithPermissionAsync());
        }

        [HttpGet("role-permissions-user")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetAllRolePermissions([Required]string UserName)
        {
            return Ok(await _permissionRepository.GetAllRolePermissionsAsync(UserName));
        }

        [HttpPost("{role}/save-permissions")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> SavePermissions([Required]Guid role,
            [FromBody]List<PermissionViewModel> permissions)
        {
            await _permissionRepository.SavePermissionsAsync(role, permissions);
            return Ok();
        }

        // xoa quyen
        [HttpDelete("functions-delete-permission-user")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.DELETE)]
        public async Task<IActionResult> Del_FunctionPermissionUser([Required]string UserName,
            [Required]string ActionId)
        {
            var TestUser = await _userManager.FindByNameAsync(UserName);
            if (TestUser != null)
            {
                return Ok(await _permissionRepository.Del_FunctionPermissionUserAsync(UserName, ActionId));
            }
            return BadRequest();
        }

        // nhung user co quyen xem
        [HttpGet("functions-view-all")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetAllFunctionByPermission()
        {
            return Ok(await _permissionRepository.GetAllFunctionByPermissionAsync());
        }

        // nhap user co quyen xem hay khong
        [HttpGet("functions-user-view")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetUserFunctionByPermissionId(string UserName)
        {
            return Ok(await _permissionRepository.GetUserFunctionByPermissionIdAsync(UserName));
        }

        // user co 1 trong cac quyen CRUD EIU
        [HttpGet("functions-user-CRUD_EIU")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> GetUserFunctionByPermission_CRUD_EIU()
        {
            return Ok(await _permissionRepository.GetUserFunctionByPermission_CRUD_EIUAsync());
        }
    }
}