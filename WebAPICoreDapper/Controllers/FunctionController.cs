using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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
    public class FunctionController : ControllerBase
    {
        private readonly string _connectionString;

        public FunctionController(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        // GET: api/Role
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                var result = await conn.QueryAsync<Function>("Get_Function_All", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // GET: api/Role/5
        [HttpGet("{id}")]
        public async Task<IActionResult> Get(string id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                paramaters.Add("@id", id);
                var result = await conn.QueryAsync<Function>("Get_Function_By_Id", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }

        }

        [HttpGet("paging")]
        public async Task<IActionResult> GetPaging(string keyword, int pageIndex, int pageSize)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                paramaters.Add("@keyword", keyword);
                paramaters.Add("@pageIndex", pageIndex);
                paramaters.Add("@pageSize", pageSize);
                paramaters.Add("@totalRow", dbType: System.Data.DbType.Int32, direction: System.Data.ParameterDirection.Output);

                var result = await conn.QueryAsync<Function>("Get_Funtion_AllPaging", paramaters, null, null, System.Data.CommandType.StoredProcedure);

                int totalRow = paramaters.Get<int>("@totalRow");

                var pagedResult = new PagedResult<Function>()
                {
                    Items = result.ToList(),
                    TotalRow = totalRow,
                    PageIndex = pageIndex,
                    PageSize = pageSize
                };
                return Ok(pagedResult);
            }

        }

        // POST: api/Role
        [HttpPost]
        [ValidateModel]
        public async Task<IActionResult> Post([FromBody] Function function)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();
                var paramaters = new DynamicParameters();
                paramaters.Add("@id", Guid.NewGuid());
                paramaters.Add("@Name", function.Name);
                paramaters.Add("@url", function.Url);
                paramaters.Add("@ParentId", function.ParentId);
                paramaters.Add("@SortOrder", function.SortOrder);
                paramaters.Add("@CssClass", function.CssClass);
                paramaters.Add("@IsActive", function.IsActive);
                var result = await conn.QueryAsync<AppUser>("Create_Function", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // PUT: api/Role/5
        [HttpPut("{id}")]
        public async Task<IActionResult> Put([Required]string id, [FromBody] Function function)
        {
            function.Id = id;
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                paramaters.Add("@id", function.Id);
                paramaters.Add("@Name", function.Name);
                paramaters.Add("@url", function.Url);
                paramaters.Add("@ParentId", function.ParentId);
                paramaters.Add("@SortOrder", function.SortOrder);
                paramaters.Add("@CssClass", function.CssClass);
                paramaters.Add("@IsActive", function.IsActive);
                var result = await conn.QueryAsync<Function>("Update_Function", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete([Required]string id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                paramaters.Add("@id", id);
                var result = await conn.QueryAsync<Function>("Delete_Function", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
            
        }
    }
}