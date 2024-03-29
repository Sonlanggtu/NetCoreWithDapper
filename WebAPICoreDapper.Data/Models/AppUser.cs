﻿using System;

namespace WebAPICoreDapper.Data.Models
{
    public class AppUser
    {
        public Guid Id { get; set; }

        public string UserName { get; set; }

        public string NormalizedUserName { get; set; }

        public string Email { get; set; }

        public string NormalizedEmail { get; set; }

        public bool EmailConfirmed { get; set; }

        public string PasswordHash { get; set; }

        public string PhoneNumber { get; set; }

        public bool PhoneNumberConfirmed { get; set; }

        public bool TwoFactorEnabled { get; set; }

        public string FullName { get; set; }

        public int AccessFailedCount { get; set; }

        public int LockoutEnabled { get; set; }

        public string Adress { get; set; }
    }
}