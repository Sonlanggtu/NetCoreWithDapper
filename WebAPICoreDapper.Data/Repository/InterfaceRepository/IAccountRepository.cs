using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.ViewModels;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IAccountRepository
    {
        Task<object> Loginsync(AppUser user);

        Task<object> RegisterAsync(RegisterViewModel model, AppUser user);

        Task<List<string>> GetPermissionByUserId(string userId);
    }
}