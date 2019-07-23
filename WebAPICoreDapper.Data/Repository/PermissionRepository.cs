using Dapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;

namespace WebAPICoreDapper.Data.Repository
{
    public class PermissionRepository : IPermissionRepository
    {
        private readonly string _connectionString;
        private readonly UserManager<AppUser> _userManager;

        public PermissionRepository(IConfiguration configuration, UserManager<AppUser> userManager)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
            _userManager = userManager;
        }

        public async Task<object> GetAllWithPermissionAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    await conn.OpenAsync();
                var result = await conn.QueryAsync<FunctionActionViewModel>("Get_Function_WithActions",
                    null, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetAllRolePermissionsAsync(string UserName)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var paramaters = new DynamicParameters();
                paramaters.Add("@UserName", UserName);
                var result = await conn.QueryAsync<PermissionViewModel>("Get_Permission_ByUserName", paramaters,
                    null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task SavePermissionsAsync(Guid role, List<PermissionViewModel> permissions)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();

                var dt = new DataTable();
                dt.Columns.Add("RoleId", typeof(Guid));
                dt.Columns.Add("FunctionId", typeof(string));
                dt.Columns.Add("ActionId", typeof(string));
                foreach (var item in permissions)
                {
                    dt.Rows.Add(role, item.FunctionId, item.ActionId);
                }
                var paramaters = new DynamicParameters();
                paramaters.Add("@roleId", role);
                paramaters.Add("@permissions", dt.AsTableValuedParameter("dbo.Permission"));
                await conn.ExecuteAsync("Create_Permission", paramaters, null, null,
                    System.Data.CommandType.StoredProcedure);
            }
        }

        public async Task<object> Del_FunctionPermissionUserAsync(string UserName, string ActionId)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var paramaters = new DynamicParameters();
                paramaters.Add("@UserName", UserName);
                paramaters.Add("@ActionId", ActionId);
                var result = await conn.QueryAsync<FunctionViewModel>("Del_Permission_User",
                    paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<object> GetAllFunctionByPermissionAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                return await conn.QueryAsync<FunctionViewModel>("Get_Function_ByPermission_view_all",
                    null, null, null, System.Data.CommandType.StoredProcedure);
            }
        }

        public async Task<object> GetUserFunctionByPermissionIdAsync(string UserName)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var resultUserID = await _userManager.FindByNameAsync(UserName);
                var paramaters = new DynamicParameters();
                paramaters.Add("@userId", resultUserID.Id);
                return await conn.QueryAsync<FunctionViewModel>("Get_Function_ByPermission",
                    paramaters, null, null, System.Data.CommandType.StoredProcedure);
            }
        }

        public async Task<object> GetUserFunctionByPermission_CRUD_EIUAsync()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                return await conn.QueryAsync<FunctionViewModel>
                    ("Get_Function_ByPermission_APPROVE_CREATE_DELETE_EXPORT_IMPORT_UPDATE",
                     null, null, null, System.Data.CommandType.StoredProcedure);
            }
        }
    }
}