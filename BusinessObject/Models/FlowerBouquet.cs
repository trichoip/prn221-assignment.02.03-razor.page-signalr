using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace BusinessObject.Models
{

    public partial class FlowerBouquet
    {
        public FlowerBouquet()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }
        public int FlowerBouquetId { get; set; }
        public int CategoryId { get; set; }
        [MinLength(5)]
        public string FlowerBouquetName { get; set; } = null!;
        [StringLength(1000, MinimumLength = 5)]
        public string Description { get; set; } = null!;
        [Range(10, double.MaxValue)]
        public decimal UnitPrice { get; set; }
        [Range(0, 1000)]
        public int UnitsInStock { get; set; }
        [Range(0, 1)]
        public byte FlowerBouquetStatus { get; set; }
        public int SupplierId { get; set; }
        public virtual Category? Category { get; set; } = null!;
        public virtual Supplier? Supplier { get; set; }
        [JsonIgnore]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
