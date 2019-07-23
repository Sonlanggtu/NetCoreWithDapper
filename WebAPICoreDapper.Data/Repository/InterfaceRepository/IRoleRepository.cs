using System.Threading.Tasks;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IRoleRepository
    {
        Task<object> GetRoleAsync();

        Task<object> GetPagingRoleAsync(string keyword, int pageIndex, int pageSize);
    }
}