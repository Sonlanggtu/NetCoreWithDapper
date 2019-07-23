using Dapper;
using Microsoft.AspNetCore.Identity;
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
    public class RoleRepository : IRoleRepository
    {
        private readonly RoleManager<AppRole> _roleManager;
        private readonly string _connectionString;
        public RoleRepository(RoleManager<AppRole> roleManager, IConfiguration configuration)
        {
            _roleManager = roleManager;
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        public async Task<object> GetRoleAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();
                var paramaters = new DynamicParameters();
                var result = await conn.QueryAsync<AppRole>("Get_Role_All", paramaters,
                    null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }


        public async Task<object> GetPagingRoleAsync(string keyword, int pageIndex, int pageSize)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();
                var paramaters = new DynamicParameters();
                paramaters.Add("@keyword", keyword);
                paramaters.Add("@pageIndex", pageIndex);
                paramaters.Add("@pageSize", pageSize);
                paramaters.Add("@totalRow", dbType: System.Data.DbType.Int32,
                    direction: System.Data.ParameterDirection.Output);
                var result = await conn.QueryAsync<AppRole>("Get_Role_AllPaging", paramaters,
                    null, null, System.Data.CommandType.StoredProcedure);
                int totalRow = paramaters.Get<int>("@totalRow");
                var pagedResult = new PagedResult<AppRole>()
                {
                    Items = result.ToList(),
                    TotalRow = totalRow,
                    PageIndex = pageIndex,
                    PageSize = pageSize
                };
                return pagedResult;
            }
        }
    }
}
