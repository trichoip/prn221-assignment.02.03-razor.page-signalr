using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using RazorPageApp.Paging;
using Repositories.Service;

namespace RazorPageApp.RestApi
{
    [Route("api/[controller]/[action]")]
    [ApiController]
    public class FlowerController : Controller
    {
        private readonly ServiceBase<BusinessObject.Models.FlowerBouquet> _context;

        public FlowerController()
        {
            _context = new ServiceBase<FlowerBouquet>();
        }

        [HttpGet]
        public ActionResult CountProduct()
        {
            return Ok(_context.GetAll().Count());
        }

        [HttpGet]
        public async Task<ActionResult> GetAllProduct(string? SearchField, string? SearchString, int? pageIndex)
        {
            IQueryable<FlowerBouquet> FlowerBouquets = _context.GetAll().Include(f => f.Category).Include(f => f.Supplier);
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
            var FlowerBouquet = await PaginatedList<FlowerBouquet>.CreateAsync(FlowerBouquets.AsNoTracking(), pageIndex ?? 1, pageSize);

            return Ok(FlowerBouquet);
        }
    }
}
