﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebAPICoreDapper.Data.Models
{
    public class PermissionViewModel
    {
        public Guid RoleId { get; set; }

        public string FunctionId { get; set; }

        public string ActionId { get; set; }
    }
}
