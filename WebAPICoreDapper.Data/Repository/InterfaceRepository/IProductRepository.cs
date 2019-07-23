using System.Collections.Generic;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Utilities.DTO;

namespace WebAPICoreDapper.Data.Repository.InterfaceRepository
{
    public interface IProductRepository
    {
        Task<Product> GetProduct_ById(int id, string culture);

        Task<IEnumerable<Product>> GetAllAsync(string language);

        Task<PagedResult<Product>> GetPagingAsync(string culture, string keyword,
            int CategoryId, int pageIndex, int pageSize);

        Task<int> PostProductAsync(Product product, string culture);

        Task UpdateAsync(int id, Product product, string culture);

        Task DeleteProductAsync(int id);
    }
}