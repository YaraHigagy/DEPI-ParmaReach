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
    /// Represents pharmacies that verify the availability of listed medicines.  
    /// Responsible for accepting donated medicines, managing stock levels,  
    /// and fulfilling patient requests for medications.
    /// </summary>
    internal class Pharmacy : Provider
    {
    }
}
