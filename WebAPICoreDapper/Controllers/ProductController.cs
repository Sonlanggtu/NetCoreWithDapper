using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
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
        public async Task<IEnumerable<Product>> Get()
        {
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

        // POST: api/Product
        [HttpPost]
        public async Task<int> Post([FromBody] Product product)
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
            return newID;
        }

        // PUT: api/Product/5
        [HttpPut("{id}")]
        public async Task Put (int id, [FromBody] Product product)
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

            }
          
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
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
