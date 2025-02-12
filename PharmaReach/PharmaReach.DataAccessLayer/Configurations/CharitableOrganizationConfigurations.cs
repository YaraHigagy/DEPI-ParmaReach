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
    internal class CharitableOrganizationConfigurations : IEntityTypeConfiguration<CharitableOrganization>
    {
        public void Configure(EntityTypeBuilder<CharitableOrganization> builder)
        {
            throw new NotImplementedException();
        }
    }
}
