using Microsoft.EntityFrameworkCore;
using PharmaReach.DataAccessLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace PharmaReach.DataAccessLayer
{
    internal class PharmaReachDbContext : DbContext
    {
        //Constructor
        public PharmaReachDbContext(DbContextOptions<PharmaReachDbContext> Options) : base(Options)
        { 

        }

        #region Tables to DbSet

        #endregion

        //Override
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            //base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlServer("Data Source=.; Initial Catalog=PharmaReachDB;Integrated Security=True;Encrypt=True;Trust Server Certificate=True");
        }

        //Creating Database
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            base.OnModelCreating(modelBuilder);
        }

        #region DbSets - Database Tables

        public DbSet<Customer> Customers { get; set; }
        public DbSet<CharitableOrganization> charitableOrganizations { get; set; }
        public DbSet<CharitableOrganizationsRecipient> CharitableOrganizationsRecipients { get; set; }
        public DbSet<Pharmacy> Pharmacies { get; set; }
        public DbSet<ProductType> ProductTypes { get; set; }
        public DbSet<MedicineCategory> MedicineCategories { get; set; }
        public DbSet<HealthcareSupplyCategory> HealthcareSupplyCategories { get; set; }
        public DbSet<Medicine> Medicines { get; set; }
        public DbSet<HealthcareSupply> HealthcareSupplies { get; set; }
        public DbSet<CharitableMedicine> CharitableMedicines { get; set; }
        public DbSet<PrePaidMedicine> PrePaidMedicines { get; set; }
        public DbSet<RareMedicine> RareMedicines { get; set; }
        public DbSet<SurplusMedicine> SurplusMedicines { get; set; }
        public DbSet<CharitableHealthcareSupply> CharitableHealthcareSupplies { get; set; }
        public DbSet<PrePaidHealthcareSupply> PrePaidHealthcareSupplies { get; set; }
        public DbSet<PharmacyMedicine> PharmacyMedicines { get; set; }
        public DbSet<PharmacyHealthcareSupply> PharmacyHealthcareSupplies { get; set; }
        public DbSet<CharitableOrganizationMedicine> CharityOrganizationMedicines { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        public DbSet<Ticket> Tickets { get; set; }

        #endregion
    }
}
