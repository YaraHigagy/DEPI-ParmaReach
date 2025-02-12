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
    /// Represents a general user in the system, including customers, providers, and administrators.
    /// Users can have authentication details, personal information, and audit tracking fields.
    /// This class serves as the base for all user-related roles.
    /// </summary>
    internal class User : ModelBase
    {
        [MaxLength(255)]
        public string Name { get; set; }

        [EmailAddress] // Frontend Validation
        [MaxLength(255)]
        public string Email { get; set; }

        [DataType(DataType.Password)] // Frontend Validation ***
        [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$", ErrorMessage = "Password must be 8-16 characters long, include at least one uppercase letter, one lowercase letter, one number, and one special character.")]
        [StringLength(16, MinimumLength = 8)] // Will be changed to 255 when using hashing
        public string Password { get; set; } // Should be stored in the db hashed

        [Phone] // Frontend Validation
        [MaxLength(15)]
        public string PhoneNumber { get; set; }

        [MaxLength(255)]
        public string? Address { get; set; }

        public bool IsVerified { get; set; } = false;



        #region Audit Fields
        // Self-referential (unary) relationship, where a Customer can be created, updated, or deleted by another Customer (likely an admin).
        // Audity Fields are inherited from ModelBase Class

        // Navigation Properties
        [ForeignKey(nameof(CreatedById))]
        public User? CreatedBy { get; set; }
        [ForeignKey(nameof(UpdatedById))]
        public User? UpdatedBy { get; set; }
        [ForeignKey(nameof(DeletedById))]
        public User? DeletedBy { get; set; }

        #endregion
    }
}
