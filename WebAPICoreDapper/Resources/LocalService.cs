using Microsoft.Extensions.Localization;
using System.Reflection;

namespace WebAPICoreDapper.Resources
{
    public class LocalService
    {
        private readonly IStringLocalizer _localizer;

        public LocalService(IStringLocalizerFactory factory)
        {
            var type = typeof(SharedResource);
            var assemblyName = new AssemblyName(type.GetTypeInfo().Assembly.FullName);
            _localizer = factory.Create("SharedResource", assemblyName.Name);
        }

        public LocalizedString GetLocalizedHtmlString(string key)
        {
            return _localizer[key];
        }
    }
}