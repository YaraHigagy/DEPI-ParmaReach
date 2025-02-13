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
    internal class CategoryBaseConfigurations : IEntityTypeConfiguration<CategoryBase>
    {
        public void Configure(EntityTypeBuilder<CategoryBase> builder)
        {
            #region Audit Fields

            // Configure binary relationships
            builder.HasOne(c => c.CreatedBy)
                .WithMany(p => p.Categories)
                .HasForeignKey(c => c.CreatedById)
                .OnDelete(DeleteBehavior.Restrict); // Prevent cascade delete
            builder.HasOne(c => c.UpdatedBy)
                .WithMany(p => p.Categories)
                .HasForeignKey(c => c.UpdatedById)
                .OnDelete(DeleteBehavior.Restrict);
            builder.HasOne(c => c.DeletedBy)
                .WithMany(p => p.Categories)
                .HasForeignKey(c => c.DeletedById)
                .OnDelete(DeleteBehavior.Restrict);

            #endregion
        }
    }
}
