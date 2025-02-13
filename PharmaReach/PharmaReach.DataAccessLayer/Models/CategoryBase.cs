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
    /// Serves as the base class for product categorization, 
    /// providing common properties and structure for different category types, 
    /// including product types, medicine categories, and healthcare supply categories.
    /// </summary>
    internal class CategoryBase : ModelBase
    {
        [MaxLength(255)]
        public string Name { get; set; }

        [MaxLength(1000)]
        public string? Description { get; set; }



        #region Audit Fields
        // Binary relationship, where the admin can create, update, or delete a category.
        // Audity Fields are inherited from ModelBase Class

        // Navigation Properties
        [ForeignKey(nameof(CreatedById))]
        public Provider? CreatedBy { get; set; }
        [ForeignKey(nameof(UpdatedById))]
        public Provider? UpdatedBy { get; set; }
        [ForeignKey(nameof(DeletedById))]
        public Provider? DeletedBy { get; set; }

        #endregion
    }
}
