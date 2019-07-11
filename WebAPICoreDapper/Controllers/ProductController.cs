using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using WebAPICoreDapper.DTO;
using WebAPICoreDapper.Fillter;
using WebAPICoreDapper.Models;

namespace WebAPICoreDapper.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly string _connectionString;
        public ProductController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }
        // GET: api/Product
        [HttpGet]
        [ValidateModel]
        public async Task<IEnumerable<Product>> Get()
        {
            throw new Exception("Test Handle Exception");
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();            
                    var result = await conn.QueryAsync<Product>("GetALL_Product", null, null, null, System.Data.CommandType.StoredProcedure);
                    return result;
            }
        }

        // GET: api/Product/5
        [HttpGet("{id}", Name = "Get")]
        [ValidateModel]
        public async Task<Product> Get(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("id",id);
                var result = await conn.QueryAsync<Product>("Get_Product_By_Id", parameters, null, null, System.Data.CommandType.StoredProcedure);
                return result.Single();
            }
            
        }
        
        [HttpGet("paging", Name = "GetPaging")]
        [ValidateModel]
        public async Task<PagedResult<Product>> GetPaging(string keyword, int CategoryId, int pageIndex,  int pageSize)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("@keyword", keyword);
                parameters.Add("@CategoryId", CategoryId);
                parameters.Add("@PageIndex", pageIndex);
                parameters.Add("@PageSize", pageSize);
                parameters.Add("@TotalRow", dbType: System.Data.DbType.Int32, direction:System.Data.ParameterDirection.Output);
                var result = await conn.QueryAsync<Product>("Get_Product_AllPaging", parameters, null, null, System.Data.CommandType.StoredProcedure);
                

                int totalRow = parameters.Get<int>("TotalRow");

                return new PagedResult<Product>()
                {
                    Items = result.ToList(),
                    TotalRow = totalRow,
                    PageIndex = pageIndex,
                    PageSize = pageSize,
                };
            }

        }

        // POST: api/Product
        [HttpPost]
        [ValidateModel]
        public async Task<IActionResult> Post([FromBody] Product product)
        {
            int newID = 0;
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("sku", product.Sku);
                parameters.Add("price", product.Price);
                parameters.Add("IsActive", product.IsActive);
                parameters.Add("ImageUrl", product.ImageUrl);
                parameters.Add("id", dbType:System.Data.DbType.Int32,direction:System.Data.ParameterDirection.Output);
                await conn.ExecuteAsync("Create_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);

                newID = parameters.Get<int>("id");
                
            }
            return Ok(newID);
        }

        // PUT: api/Product/5
        [HttpPut("{id}")]
        [ValidateModel]
        public async Task<IActionResult> Put (int id, [FromBody] Product product)
        {
            
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("id", id);
                parameters.Add("sku", product.Sku);
                parameters.Add("price", product.Price);
                parameters.Add("IsActive", product.IsActive);
                parameters.Add("ImageUrl", product.ImageUrl);
                
                await conn.ExecuteAsync("Update_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);

                return Ok();
            }
          
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        [ValidateModel]
        public async Task Delete(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("id", id);
                await conn.ExecuteAsync("Delete_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);

            }
        }
    }
}
