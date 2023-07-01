using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Repositories.Service;

namespace RazorPageApp.Pages.Flower
{
    public class DetailsModel : PageModel
    {
        private readonly ServiceBase<FlowerBouquet> _context;

        public DetailsModel()
        {
            _context = new ServiceBase<FlowerBouquet>();

        }

        public FlowerBouquet FlowerBouquet { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var flowerbouquet = _context.GetAll()
                .Include(f => f.Category)
                .Include(f => f.Supplier)
                .FirstOrDefault(m => m.FlowerBouquetId == id);
            if (flowerbouquet == null)
            {
                return NotFound();
            }
            else
            {
                FlowerBouquet = flowerbouquet;
            }
            return Page();
        }
    }
}
