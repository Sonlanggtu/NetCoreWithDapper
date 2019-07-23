using Dapper;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using WebAPICoreDapper.Data.Models;
using WebAPICoreDapper.Data.Repository.InterfaceRepository;
using WebAPICoreDapper.Utilities.DTO;

namespace WebAPICoreDapper.Data.Repository
{
    public class ProductRepository : IProductRepository
    {
        private readonly string _connectionString;

        public ProductRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        public async Task<Product> GetProduct_ById(int id, string culture)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("id", id);
                parameters.Add("@language", culture);
                var result = await conn.QueryAsync<Product>("Get_Product_By_Id", parameters, null, null, System.Data.CommandType.StoredProcedure);
                return result.Single();
            }
        }

        public async Task<IEnumerable<Product>> GetAllAsync(string language)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("@language", language);
                var result = await conn.QueryAsync<Product>("GetALL_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);
                return result;
            }
        }

        public async Task<PagedResult<Product>> GetPagingAsync(string culture, string keyword, int CategoryId, int pageIndex, int pageSize)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("@keyword", keyword);
                parameters.Add("@CategoryId", CategoryId);
                parameters.Add("@PageIndex", pageIndex);
                parameters.Add("@PageSize", pageSize);
                parameters.Add("@language", culture);
                parameters.Add("@TotalRow", dbType: System.Data.DbType.Int32, direction: System.Data.ParameterDirection.Output);
                var result = await conn.QueryAsync<Product>("Get_Product_AllPaging", parameters, null, null, System.Data.CommandType.StoredProcedure);
                int totalRow = parameters.Get<int>("TotalRow");
                return new PagedResult<Product>()
                {
                    Items = result.ToList(),
                    TotalRow = totalRow,
                    PageIndex = pageIndex,
                    PageSize = pageSize,
                };
            }
        }

        public async Task<int> PostProductAsync(Product product, string culture)
        {
            int newID = 0;
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("@language", culture);
                parameters.Add("sku", product.Sku);
                parameters.Add("price", product.Price);
                parameters.Add("DiscountPrice", product.DiscountPrice);
                parameters.Add("ViewCount", product.ViewCount);
                parameters.Add("IsActive", product.IsActive);
                parameters.Add("ImageUrl", product.ImageUrl);
                parameters.Add("id", dbType: System.Data.DbType.Int32, direction: System.Data.ParameterDirection.Output);
                parameters.Add("Name", product.Name);
                parameters.Add("Content", product.Content);
                parameters.Add("Description", product.Description);
                parameters.Add("SeoAlias", product.SeoAlias);
                parameters.Add("SeoAlias", product.SeoAlias);
                parameters.Add("SeoDescription", product.SeoDescription);
                parameters.Add("SeoKeyword", product.SeoKeyword);
                parameters.Add("SeoTitle", product.SeoTitle);
                parameters.Add("CategoryIds", product.CategoryIds);
                await conn.ExecuteAsync("Create_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);
                newID = parameters.Get<int>("id");
            }
            return newID;
        }

        public async Task UpdateAsync(int id, Product product, string culture)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("@language", culture);
                parameters.Add("id", id);
                parameters.Add("sku", product.Sku);
                parameters.Add("price", product.Price);
                parameters.Add("DiscountPrice", product.DiscountPrice);
                parameters.Add("ViewCount", product.ViewCount);
                parameters.Add("IsActive", product.IsActive);
                parameters.Add("ImageUrl", product.ImageUrl);
                parameters.Add("Name", product.Name);
                parameters.Add("Content", product.Content);
                parameters.Add("Description", product.Description);
                parameters.Add("SeoAlias", product.SeoAlias);
                parameters.Add("SeoDescription", product.SeoDescription);
                parameters.Add("SeoKeyword", product.SeoKeyword);
                parameters.Add("SeoTitle", product.SeoTitle);
                parameters.Add("CategoryIds", product.CategoryIds);
                await conn.ExecuteAsync("Update_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);
            }
        }

        public async Task DeleteProductAsync(int id)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                if (conn.State == System.Data.ConnectionState.Closed)
                    conn.Open();
                var parameters = new DynamicParameters();
                parameters.Add("id", id);
                await conn.ExecuteAsync("Delete_Product", parameters, null, null, System.Data.CommandType.StoredProcedure);
            }
        }
    }
}