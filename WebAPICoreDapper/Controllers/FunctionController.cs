using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Fillter;
using WebAPICoreDapper.Filter;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FunctionController : ControllerBase
    {
        private readonly IFunctionRepository _functionRepository;

        public FunctionController(IConfiguration configuration, IFunctionRepository functionRepository)
        {
            _functionRepository = functionRepository;
        }

        [HttpGet]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get()
        {
            return Ok(await _functionRepository.GetFunctionAllAsync());
        }

        // GET: api/Role/5
        [HttpGet("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> Get(string id)
        {
            return Ok(await _functionRepository.GetFunctionById(id));
        }

        [HttpGet("paging")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IActionResult> GetPaging(string keyword, int pageIndex, int pageSize)
        {
            return Ok(await _functionRepository.GetPagingAsync(keyword, pageIndex, pageSize));
        }

        [HttpPost]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> Post([FromBody] Function function)
        {
            return Ok(await _functionRepository.CreateFunctionAsync(function));
        }

        [HttpPut("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.UPDATE)]
        public async Task<IActionResult> Put([Required]string id, [FromBody] Function function)
        {
            return Ok(await _functionRepository.UpdateFunctionAsync(id, function));
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.DELETE)]
        public async Task<IActionResult> Delete([Required]string id)
        {
            return Ok(await _functionRepository.DeleteFunctionAsync(id));
        }
    }
}