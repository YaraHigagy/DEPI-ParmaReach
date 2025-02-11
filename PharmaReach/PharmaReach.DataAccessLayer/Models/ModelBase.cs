using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaReach.DataAccessLayer.Models
{
    /// <summary>
    /// Base model class providing common properties for entity management.
    /// </summary>
    internal class ModelBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        #region Audit Fields

        public DateTime CreatedAt { get; set; }
        public int? CreatedById { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int UpdatedById { get; set; }
        public bool IsDeleted { get; set; } = false;
        public int DeletedById { get; set; }
        public DateTime? DeletedAt { get; set; }
        [MaxLength(255)]
        public string DeletedReason { get; set; }

        #endregion
    }
}
