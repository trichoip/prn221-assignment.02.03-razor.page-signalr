using System.Text.Json.Serialization;

namespace BusinessObject.Models
{
    public partial class Category
    {
        public Category()
        {
            FlowerBouquets = new HashSet<FlowerBouquet>();
        }

        public int CategoryId { get; set; }
        public string CategoryName { get; set; } = null!;
        public string? CategoryDescription { get; set; }

        [JsonIgnore]
        public virtual ICollection<FlowerBouquet> FlowerBouquets { get; set; }
    }
}
