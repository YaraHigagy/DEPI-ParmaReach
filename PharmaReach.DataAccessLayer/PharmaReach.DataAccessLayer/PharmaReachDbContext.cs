using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
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
            #region Configuration Relationships for Entities

            #endregion

            base.OnModelCreating(modelBuilder);
        }
    }
}
