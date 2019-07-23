using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Globalization;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Extensions;
using WebAPICoreDapper.Fillter;
using WebAPICoreDapper.Filter;
using WebAPICoreDapper.Utilities.DTO;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/{culture}[controller]")]
    [ApiController]
    [MiddlewareFilter(typeof(LocalizationPipeline))]
    public class ProductController : ControllerBase
    {
        private readonly IProductRepository _productRepository;

        public ProductController(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        // GET: api/Product
        [HttpGet]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<IEnumerable<Product>> Get()
        {
            return await _productRepository.GetAllAsync(CultureInfo.CurrentCulture.Name);
        }

        // GET: api/Product/5
        [HttpGet("{id}", Name = "Get")]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<Product> Get(int id)
        {
            return await _productRepository.GetProduct_ById(id, CultureInfo.CurrentCulture.Name);
        }

        [HttpGet("paging", Name = "GetPaging")]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.VIEW)]
        public async Task<PagedResult<Product>> GetPaging(string keyword, int CategoryId, int pageIndex, int pageSize)
        {
            string culture = CultureInfo.CurrentCulture.Name;
            return await _productRepository.GetPagingAsync(culture, keyword, CategoryId, pageIndex, pageSize);
        }

        // POST: api/Product
        [HttpPost]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.CREATE)]
        public async Task<IActionResult> Post([FromBody] Product product)
        {
            var result = await _productRepository.PostProductAsync(product, CultureInfo.CurrentCulture.Name);
            return Ok(result);
        }

        // PUT: api/Product/5
        [HttpPut("{id}")]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.UPDATE)]
        public async Task<IActionResult> Put(int id, [FromBody] Product product)
        {
            await _productRepository.UpdateAsync(id, product, CultureInfo.CurrentCulture.Name);
            return Ok();
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        [ValidateModel]
        [ClaimRequirement(FunctionCode.SYSTEM_USER, ActionCode.DELETE)]
        public async Task Delete(int id)
        {
            await _productRepository.DeleteProductAsync(id);
        }
    }
}