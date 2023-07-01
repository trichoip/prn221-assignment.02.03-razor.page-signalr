using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using RazorPageApp.SignalR;
using Repositories.Service;

namespace RazorPageApp.Pages.Flower
{
    public class EditModel : PageModel
    {
        private readonly ServiceBase<FlowerBouquet> _context;
        private readonly ServiceBase<Category> _contextCategory;
        private readonly ServiceBase<Supplier> _contextSupplier;
        private readonly IHubContext<SignalrServer> hubContext;

        public EditModel(IHubContext<SignalrServer> _hubContext)
        {
            _context = new ServiceBase<FlowerBouquet>();
            _contextCategory = new ServiceBase<Category>();
            _contextSupplier = new ServiceBase<Supplier>();
            hubContext = _hubContext;
        }

        [BindProperty]
        public FlowerBouquet FlowerBouquet { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var flowerbouquet = _context.GetAll().FirstOrDefault(m => m.FlowerBouquetId == id);
            if (flowerbouquet == null)
            {
                return NotFound();
            }
            FlowerBouquet = flowerbouquet;
            ViewData["CategoryId"] = new SelectList(_contextCategory.GetAll(), "CategoryId", "CategoryName");
            ViewData["SupplierId"] = new SelectList(_contextSupplier.GetAll(), "SupplierId", "SupplierName");
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            try
            {
                _context.Update(FlowerBouquet);
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!FlowerBouquetExists(FlowerBouquet.FlowerBouquetId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            TempData["Message"] = "Flower Bouquet Updated Successfully!";
            await hubContext.Clients.All.SendAsync("Messages", $"Flower id {FlowerBouquet.FlowerBouquetId} is edited");
            await hubContext.Clients.All.SendAsync("GetProducts");
            return RedirectToPage("./Index");
        }

        private bool FlowerBouquetExists(int id)
        {
            return (_context.GetAll()?.Any(e => e.FlowerBouquetId == id)).GetValueOrDefault();
        }
    }
}
