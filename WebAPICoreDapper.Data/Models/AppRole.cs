using System;

namespace WebAPICoreDapper.Data.Models
{
    public class AppRole
    {
        public Guid? Id { get; set; }

        public string UserName { get; set; }

        public string NormalizedName { get; set; }
    }
}