using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using RazorPageApp.Paging;
using Repositories.Service;

namespace RazorPageApp.Pages.Flower
{
    public class IndexModel : PageModel
    {
        private readonly ServiceBase<FlowerBouquet> _context;

        public PaginatedList<FlowerBouquet> FlowerBouquet { get; set; }
        public string CurrentFilterSearchString { get; set; }

        public IndexModel()
        {
            _context = new ServiceBase<FlowerBouquet>();

        }

        public async Task OnGetAsync(string SearchField, string SearchString, int? pageIndex)
        {
            IQueryable<FlowerBouquet> FlowerBouquets = _context.GetAll().Include(f => f.Category).Include(f => f.Supplier);

            ViewData["SearchField"] = new SelectList(new List<string> { "FlowerBouquetName", "Description" }, SearchField);

            CurrentFilterSearchString = SearchString;
            ViewData["CurrentSearchField"] = SearchField;
            if (!String.IsNullOrEmpty(SearchString) && !String.IsNullOrEmpty(SearchField))
            {
                switch (SearchField)
                {
                    case "FlowerBouquetName":
                        FlowerBouquets = FlowerBouquets.Where(s => s.FlowerBouquetName.Contains(SearchString));
                        break;
                    case "Description":
                        FlowerBouquets = FlowerBouquets.Where(s => s.Description.Contains(SearchString));
                        break;
                }
            }
            var pageSize = 3;
            FlowerBouquet = await PaginatedList<FlowerBouquet>.CreateAsync(FlowerBouquets.AsNoTracking(), pageIndex ?? 1, pageSize);

        }
    }
}
