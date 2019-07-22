using Dapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using WebAPICoreDapper.Models;

namespace WebAPICoreDapper.Data
{
    public class RoleStore : IRoleStore<AppRole>
    {
        private readonly string _connectionString;

        public RoleStore(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DbConnectionString");
        }

        public async Task<IdentityResult> CreateAsync(AppRole role, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync(cancellationToken);
                role.Id = Guid.NewGuid();
                await connection.ExecuteAsync($@"INSERT INTO [AspNetRoles] ([Id], [UserName], [NormalizedName])
                    VALUES (@{nameof(AppRole.Id)},@{nameof(AppRole.UserName)}, @{nameof(AppRole.NormalizedName)});", role);
            }

            return IdentityResult.Success;
        }

        public async Task<IdentityResult> UpdateAsync(AppRole role, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync(cancellationToken);
                await connection.ExecuteAsync($@"UPDATE [AspNetRoles] SET
                    [UserName] = @{nameof(AppRole.UserName)},
                    [NormalizedName] = @{nameof(AppRole.NormalizedName)}
                    WHERE [Id] = @{nameof(AppRole.Id)}", role);
            }

            return IdentityResult.Success;
        }

        public async Task<IdentityResult> DeleteAsync(AppRole role, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync(cancellationToken);
                await connection.ExecuteAsync($"DELETE FROM [AspNetRoles] WHERE [Id] = @{nameof(AppRole.Id)}", role);
            }

            return IdentityResult.Success;
        }

        public Task<string> GetRoleIdAsync(AppRole role, CancellationToken cancellationToken)
        {
            return Task.FromResult(role.Id.ToString());
        }

        public Task<string> GetRoleNameAsync(AppRole role, CancellationToken cancellationToken)
        {
            return Task.FromResult(role.UserName);
        }

        public Task SetRoleNameAsync(AppRole role, string roleName, CancellationToken cancellationToken)
        {
            role.UserName = roleName;
            return Task.FromResult(0);
        }

        public Task<string> GetNormalizedRoleNameAsync(AppRole role, CancellationToken cancellationToken)
        {
            return Task.FromResult(role.NormalizedName);
        }

        public Task SetNormalizedRoleNameAsync(AppRole role, string normalizedName, CancellationToken cancellationToken)
        {
           // role.NormalizedName = normalizedName;
            return Task.FromResult(role.NormalizedName);
        }

        public async Task<AppRole> FindByIdAsync(string roleId, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync(cancellationToken);
                return await connection.QuerySingleOrDefaultAsync<AppRole>($@"SELECT * FROM [AspNetRoles]
                    WHERE [Id] = @{nameof(roleId)}", new { roleId });
            }
        }

        public async Task<AppRole> FindByNameAsync(string UserName, CancellationToken cancellationToken)
        {
            cancellationToken.ThrowIfCancellationRequested();

            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.OpenAsync(cancellationToken);
                return await connection.QuerySingleOrDefaultAsync<AppRole>($@"SELECT * FROM [AspNetRoles]
                    WHERE [UserName] = @{nameof(UserName)}", new { UserName });
            }
        }

        public void Dispose()
        {
            // Nothing to dispose.
        }
    }
}
