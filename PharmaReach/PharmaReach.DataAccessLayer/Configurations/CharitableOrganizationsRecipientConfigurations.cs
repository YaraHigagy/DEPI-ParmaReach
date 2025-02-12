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
    internal class CharitableOrganizationsRecipientConfigurations : IEntityTypeConfiguration<CharitableOrganizationsRecipient>
    {
        public void Configure(EntityTypeBuilder<CharitableOrganizationsRecipient> builder)
        {
            builder.HasIndex(r => r.NationalId).IsUnique();



            #region Relationships - Navigational Properties

            // FK: Navigation Property - ONE to ONE Relationship
            builder.HasOne(r => r.Customer)
                .WithOne()
                .HasForeignKey<CharitableOrganizationsRecipient>(r => r.CustomerId)
                .OnDelete(DeleteBehavior.Restrict);

            #endregion



            #region Audit Fields

            // Ignore inherited Customer audit fields
            builder.Ignore(r => r.CreatedBy);
            builder.Ignore(r => r.UpdatedBy);
            builder.Ignore(r => r.DeletedBy);

            // Configure Recipient audit fields for CharitableOrganization
            builder.HasOne(r => r.CreatedBy)
                .WithMany()
                .HasForeignKey(r => r.CreatedById) // Ensures correct FK column
                .OnDelete(DeleteBehavior.Restrict);

            builder.HasOne(r => r.UpdatedBy)
                .WithMany()
                .HasForeignKey(r => r.UpdatedById)
                .OnDelete(DeleteBehavior.Restrict);

            builder.HasOne(r => r.DeletedBy)
                .WithMany()
                .HasForeignKey(r => r.DeletedById)
                .OnDelete(DeleteBehavior.Restrict);

            #endregion
        }
    }
}
