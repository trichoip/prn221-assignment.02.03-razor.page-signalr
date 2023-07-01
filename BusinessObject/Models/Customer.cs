using System.ComponentModel.DataAnnotations;

namespace BusinessObject.Models
{
    public partial class Customer
    {
        public Customer()
        {
            Orders = new HashSet<Order>();
        }

        public int CustomerId { get; set; }
        [EmailAddress]
        public string Email { get; set; } = null!;
        public string CustomerName { get; set; } = null!;
        public string City { get; set; } = null!;
        public string Country { get; set; } = null!;
        public DateTime Birthday { get; set; }
        [DataType(DataType.Password)]
        public string Password { get; set; } = null!;
        public virtual ICollection<Order> Orders { get; set; }
    }
}
