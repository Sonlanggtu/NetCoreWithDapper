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
    public class RoleController : ControllerBase
    {
        private readonly RoleManager<AppRole> _roleManager;
        private readonly IRoleRepository _roleRepository;

        public RoleController(RoleManager<AppRole> roleManager,
            IRoleRepository roleRepository)
        {
            _roleManager = roleManager;
            _roleRepository = roleRepository;
        }

        // GET: api/Role
        [HttpGet]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get()
        {
            return Ok(await _roleRepository.GetRoleAsync());
        }

        // GET: api/Role/5
        [HttpGet("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get(string id)
        {
            return Ok(await _roleManager.FindByIdAsync(id));
        }

        [HttpGet("paging")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetPaging(string keyword, int pageIndex, int pageSize)
        {
            return Ok(await _roleRepository.GetPagingRoleAsync(keyword, pageIndex, pageSize));
        }

        // POST: api/Role
        [HttpPost]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> Post([FromBody] AppRole role)
        {
            var result = await _roleManager.CreateAsync(role);
            if (result.Succeeded)
                return Ok();
            return BadRequest();
        }

        // PUT: api/Role/5
        [HttpPut("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.UPDATE)]
        public async Task<IActionResult> Put([Required]Guid id, [FromBody] AppRole role)
        {
            role.Id = id;
            var result = await _roleManager.UpdateAsync(role);
            if (result.Succeeded)
                return Ok();
            return BadRequest();
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.DELETE)]
        public async Task<IActionResult> Delete(string id)
        {
            var role = await _roleManager.FindByIdAsync(id);
            var result = await _roleManager.DeleteAsync(role);
            if (result.Succeeded)
                return Ok();
            return BadRequest();
        }
    }
}