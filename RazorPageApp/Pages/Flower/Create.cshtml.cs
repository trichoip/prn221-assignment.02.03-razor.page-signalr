using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.SignalR;
using RazorPageApp.SignalR;
using Repositories.Service;

namespace RazorPageApp.Pages.Flower
{
    public class CreateModel : PageModel
    {
        private readonly ServiceBase<FlowerBouquet> _context;
        private readonly ServiceBase<Category> _contextCategory;
        private readonly ServiceBase<Supplier> _contextSupplier;
        private readonly IHubContext<SignalrServer> hubContext;

        public CreateModel(IHubContext<SignalrServer> _hubContext)
        {
            _context = new ServiceBase<FlowerBouquet>();
            _contextCategory = new ServiceBase<Category>();
            _contextSupplier = new ServiceBase<Supplier>();
            hubContext = _hubContext;
        }

        public IActionResult OnGet()
        {
            ViewData["CategoryId"] = new SelectList(_contextCategory.GetAll(), "CategoryId", "CategoryName");
            ViewData["SupplierId"] = new SelectList(_contextSupplier.GetAll(), "SupplierId", "SupplierName");
            return Page();
        }

        [BindProperty]
        public FlowerBouquet FlowerBouquet { get; set; } = default!;

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid || FlowerBouquet == null)
            {
                return Page();
            }

            _context.Add(FlowerBouquet);

            TempData["Message"] = "Flower Bouquet Added Successfully!";
            await hubContext.Clients.All.SendAsync("Messages", $"Flower name {FlowerBouquet.FlowerBouquetName} is added");
            await hubContext.Clients.All.SendAsync("TotalProducts");
            await hubContext.Clients.All.SendAsync("GetProducts");
            return RedirectToPage("./Index");
        }
    }
}
