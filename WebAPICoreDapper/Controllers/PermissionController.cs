﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using WebAPICoreDapper.Models;
using WebAPICoreDapper.Extensions;
using Microsoft.AspNetCore.Identity;

namespace WebAPICoreDapper.Controllers
{

    [Route("api/[controller]")]
    [ApiController]
    public class PermissionController : ControllerBase
    {
        private readonly string _connectionString;
        private readonly UserManager<AppUser> _userManager;
        public PermissionController(IConfiguration configuration, UserManager<AppUser> userManager)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
            _userManager = userManager;
        }

        [HttpGet("function-actions")]
        public async Task<IActionResult> GetAllWithPermission()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    await conn.OpenAsync();

                var result = await conn.QueryAsync<FunctionActionViewModel>("Get_Function_WithActions", null, null, null, System.Data.CommandType.StoredProcedure);

                return Ok(result);
            }
        }

        [HttpGet("{role}/role-permissions")]
        public async Task<IActionResult> GetAllRolePermissions(Guid? role)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();

                var paramaters = new DynamicParameters();
                paramaters.Add("@roleId", role);

                var result = await conn.QueryAsync<PermissionViewModel>("Get_Permission_ByRoleId", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        [HttpPost("{role}/save-permissions")]
        public async Task<IActionResult> SavePermissions(Guid role, [FromBody]List<PermissionViewModel> permissions)
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
                await conn.ExecuteAsync("Create_Permission", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok();
            }
        }

        // xoa quyen
        [HttpGet("functions-delete-permission-user")]
        public async Task<IActionResult> Del_FunctionPermissionUser(string roleId, string ActionId)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var paramaters = new DynamicParameters();
                paramaters.Add("@roleId", roleId);
                paramaters.Add("@ActionId", ActionId);
                var result = await conn.QueryAsync<FunctionViewModel>("Del_Permission_User", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // nhung user co quyen xem
        [HttpGet("functions-view-all")]
        public async Task<IActionResult> GetAllFunctionByPermission()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();

                var result = await conn.QueryAsync<FunctionViewModel>("Get_Function_ByPermission_view_all", null, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // nhap user co quyen xem hay khong
        [HttpGet("functions-user-view")]
        public async Task<IActionResult> GetUserFunctionByPermissionId(string UserName)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var resultUserID = await _userManager.FindByNameAsync(UserName);
                var paramaters = new DynamicParameters();
                paramaters.Add("@userId", resultUserID.Id);

                var result = await conn.QueryAsync<FunctionViewModel>("Get_Function_ByPermission", paramaters, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }

        // user co 1 trong cac quyen CRUD EIU
        [HttpGet("functions-user-CRUD_EIU")]
        public async Task<IActionResult> GetUserFunctionByPermission_CRUD_EIU()
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == ConnectionState.Closed)
                    conn.Open();
                var result = await conn.QueryAsync<FunctionViewModel>
                    ("Get_Function_ByPermission_APPROVE_CREATE_DELETE_EXPORT_IMPORT_UPDATE",
                     null, null, null, System.Data.CommandType.StoredProcedure);
                return Ok(result);
            }
        }
    }
}
