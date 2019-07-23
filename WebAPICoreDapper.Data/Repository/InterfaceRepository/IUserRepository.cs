using System.Threading.Tasks;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IUserRepository
    {
        Task<object> GetUserAsync();

        Task<object> GetUserByIdAsync(string id);

        Task<object> GetPagingUserAsync(string keyword, int pageIndex, int pageSize);
    }
}