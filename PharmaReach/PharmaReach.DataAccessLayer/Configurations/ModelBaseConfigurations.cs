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
    internal class ModelBaseConfigurations : IEntityTypeConfiguration<ModelBase>
    {
        public void Configure(EntityTypeBuilder<ModelBase> builder)
        {
            #region Audit Fields

            builder.Property(u => u.CreatedAt).HasDefaultValueSql("GETDATE()"); // add current datetime when creating the record itself

            #endregion
        }
    }
}
