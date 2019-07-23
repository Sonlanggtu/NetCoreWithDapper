using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IPermissionRepository
    {
        Task<object> GetAllWithPermissionAsync();

        Task<object> GetAllRolePermissionsAsync(string UserName);

        Task SavePermissionsAsync(Guid role, List<PermissionViewModel> permissions);

        Task<object> Del_FunctionPermissionUserAsync(string UserName, string ActionId);

        Task<object> GetAllFunctionByPermissionAsync();

        Task<object> GetUserFunctionByPermissionIdAsync(string UserName);

        Task<object> GetUserFunctionByPermission_CRUD_EIUAsync();
    }
}