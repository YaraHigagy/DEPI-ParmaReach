using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaReach.DataAccessLayer.Models
{
    /// <summary>
    /// Represents recipients of charitable aid with special privileges.  
    /// Includes personal details and social status description.  
    /// Receives easier access to free charitable medications than regular customers.
    /// </summary>
    internal class CharitableOrganizationsRecipient : Customer
    {
        [RegularExpression(@"^\d{14}$", ErrorMessage = "National ID must be exactly 14 digits.")]
        [MaxLength(14)]
        public string NationalId { get; set; }

        [MaxLength(255)]
        public string? SocialStatusDescription { get; set; }

        [MaxLength(255)]
        public string SerialNumber { get; set; }

        public bool IsApproved { get; set; }  = false; // From the Charitable Organization



        #region Relationships - Navigational Propert

        [ForeignKey(nameof(Customer))]
        public int CustomerId { get; set; } // FK: ONE to ONE Relationship
        [ForeignKey(nameof(CustomerId))]
        public Customer Customer { get; set; } // Navigational Property => ONE

        #endregion



        #region Audit Fields
        // Reference to CharitableOrganizations

        [ForeignKey(nameof(CreatedById))]
        public new CharitableOrganization? CreatedBy { get; set; }
        [ForeignKey(nameof(UpdatedById))]
        public new CharitableOrganization? UpdatedBy { get; set; }
        [ForeignKey(nameof(DeletedById))]
        public new CharitableOrganization? DeletedBy { get; set; }

        #endregion
    }
}
