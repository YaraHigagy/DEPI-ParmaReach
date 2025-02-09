using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using PharmaReach.DataAccessLayer.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaReach.DataAccessLayer.Configurations
{
    internal class CustomerConfigurations : IEntityTypeConfiguration<Customer>
    {
        public void Configure(EntityTypeBuilder<Customer> builder)
        {
            builder.Property(c => c.CreatedBy).HasDefaultValueSql("GETDATE()"); // add current datetime when creating the record itself

            // Configure self-referential (unary) relationships
            builder.HasOne(c => c.CreatedBy)
                .WithMany()
                .HasForeignKey(c => c.CreatedById)
                .OnDelete(DeleteBehavior.Restrict); // Prevent cascade delete
            builder.HasOne(c => c.UpdatedBy)
                .WithMany()
                .HasForeignKey(c => c.UpdatedById)
                .OnDelete(DeleteBehavior.Restrict);
            builder.HasOne(c => c.DeletedBy)
                .WithMany()
                .HasForeignKey(c => c.DeletedById)
                .OnDelete(DeleteBehavior.Restrict);
        }
    }
}
