using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPICoreDapper.Models
{
    public class Product
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "SkuRequiredMessage")]
        [StringLength(8, MinimumLength = 2, ErrorMessage = "SKUStringLength")]
        public string Sku { get; set; }

        
        public float Price { get; set; }

        public bool IsActive { get; set; }

        public string ImageUrl { get; set; }

        public int ViewCount { get; set; }

        public DateTime CreateAt { get; set; }
    }
}
