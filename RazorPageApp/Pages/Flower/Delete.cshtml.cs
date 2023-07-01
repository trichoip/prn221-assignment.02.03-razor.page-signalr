using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using RazorPageApp.SignalR;
using Repositories.Service;

namespace RazorPageApp.Pages.Flower
{
    public class DeleteModel : PageModel
    {
        private readonly ServiceBase<FlowerBouquet> _context;

        private readonly IHubContext<SignalrServer> hubContext;

        public DeleteModel(IHubContext<SignalrServer> _hubContext)
        {
            _context = new ServiceBase<FlowerBouquet>();
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

            var flowerbouquet = _context.GetAll().Include(f => f.Category)
                .Include(f => f.Supplier).FirstOrDefault(m => m.FlowerBouquetId == id);

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

        public async Task<IActionResult> OnPostAsync(int id)
        {
            if (id == null)
            {
                return NotFound();
            }
            var flowerbouquet = _context.Find(id);

            if (flowerbouquet != null)
            {
                FlowerBouquet = flowerbouquet;
                _context.Remove(FlowerBouquet);

            }
            TempData["Message"] = "Flower Bouquet Deleted Successfully!";
            await hubContext.Clients.All.SendAsync("Messages", $"Flower id {id} is deleted");
            await hubContext.Clients.All.SendAsync("TotalProducts");
            await hubContext.Clients.All.SendAsync("GetProducts");
            return RedirectToPage("./Index");
        }
    }
}
