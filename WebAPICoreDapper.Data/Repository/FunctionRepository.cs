using Dapper;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Utilities.DTO;

namespace WebAPICoreDapper.Data.Repository
{

    public class FunctionRepository : IFunctionRepository
    {
        private readonly string _connectionString;
        public FunctionRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        public async Task<object> GetFunctionAllAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                var result = await conn.QueryAsync<Function>("Get_Function_All", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetFunctionById(string id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();
                var paramaters = new DynamicParameters();
                paramaters.Add("@id", id);
                var result = await conn.QueryAsync<Function>("Get_Function_By_Id", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetPagingAsync(string keyword, int pageIndex, int pageSize)
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
                return pagedResult;
            }
        }

        public async Task<object> CreateFunctionAsync(Function function)
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
                return result;
            }
        }


        public async Task<object> UpdateFunctionAsync(string id, Function function)
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
                return await conn.QueryAsync<Function>("Update_Function", paramaters, null, null, System.Data.CommandType.StoredProcedure);

            }
        }

        public async Task<object> DeleteFunctionAsync(string id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();
                var paramaters = new DynamicParameters();
                paramaters.Add("@id", id);
                var result = await conn.QueryAsync<Function>("Delete_Function", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }
    }
}
