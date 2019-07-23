using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IFunctionRepository
    {
        Task<object> GetFunctionAllAsync();

        Task<object> GetFunctionById(string id);

        Task<object> GetPagingAsync(string keyword, int pageIndex, int pageSize);

        Task<object> CreateFunctionAsync(Function function);

        Task<object> UpdateFunctionAsync(string id, Function function);

        Task<object> DeleteFunctionAsync(string id);
    }
}