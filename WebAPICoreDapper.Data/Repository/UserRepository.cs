using Dapper;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Utilities.DTO;

namespace WebAPICoreDapper.Data.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly string _connectionString;

        public UserRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        public async Task<object> GetUserAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                var result = await conn.QueryAsync<AppUser>("Get_User_All", paramaters,
                    null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetUserByIdAsync(string id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    await conn.OpenAsync();

                var paramaters = new DynamicParameters();
                paramaters.Add("@id", id);
                var result = await conn.QueryAsync<AppUser>("Get_User_By_Id", paramaters,
                    null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetPagingUserAsync(string keyword, int pageIndex, int pageSize)
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
                var result = await conn.QueryAsync<AppUser>("Get_User_AllPaging",
                    paramaters, null, null, System.Data.CommandType.StoredProcedure);
                int totalRow = paramaters.Get<int>("@totalRow");
                var pagedResult = new PagedResult<AppUser>()
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