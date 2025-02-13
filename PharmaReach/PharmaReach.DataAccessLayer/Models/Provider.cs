using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaReach.DataAccessLayer.Models
{
    /// <summary>
    /// Represents an entity that provides goods or services, such as pharmacies and charitable organizations.
    /// Inherits from the User class and includes additional attributes related to business verification.
    /// </summary>
    internal class Provider : User
    {
        /// <summary>
        /// The legal license document (stored as a URL or file path).
        /// </summary>
        [Required] // Assuming it's mandatory for verification
        [Url] // Ensures the string follows a valid URL format
        [MaxLength(255)]
        public string LegalLicense { get; set; } //URL Location in server



        #region Relationships for Audit Fields

        public ICollection<CategoryBase> Categories { get; set; } = new HashSet<CategoryBase>(); // Navigational Property => MANY

        #endregion
    }
}
