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
    /// Represents customers, including patients and donors.  
    /// Patients can buy medicines, healthcare supplies, and request aid.  
    /// Donors can sponsor requests or donate surplus medicines.
    /// </summary>
    internal class Customer : ModelBase
    {
        // Id property is inherited from ModelBase Class
        
        [MaxLength(255)]
        public string Name { get; set; }
        
        [EmailAddress] // Frontend Validation
        [MaxLength(255)]
        public string Email { get; set; }
        
        [DataType(DataType.Password)] // Frontend Validation ***
        [MaxLength(16)] // Will be changed to 255 when using hashing
        public string Password { get; set; } // Should be stored in the db hashed

        [Phone] // Frontend Validation
        [MaxLength(15)]
        public string PhoneNumber { get; set; }

        [MaxLength(255)]
        public string? Address { get; set; }
        
        public DateOnly? DateOfBirth { get; set; }
        
        public bool IsVerified { get; set; } = false;



        #region Audit Fields
        // Self-referential (unary) relationship, where a Customer can be created, updated, or deleted by another Customer (likely an admin).
        // Audity Fields are inherited from ModelBase Class

        // Navigation Properties
        [ForeignKey(nameof(CreatedById))]
        public Customer? CreatedBy { get; set; }
        [ForeignKey(nameof(UpdatedById))]
        public Customer? UpdatedBy { get; set; }
        [ForeignKey(nameof(DeletedById))]
        public Customer? DeletedBy { get; set; }

        #endregion
    }
}
