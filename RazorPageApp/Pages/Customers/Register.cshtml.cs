using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Repositories.Service;

namespace RazorPageApp.Pages.Customers
{
    public class CreateModel : PageModel
    {
        private readonly ServiceBase<Customer> _context;

        public CreateModel()
        {
            _context = new ServiceBase<Customer>();
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty]
        public Customer Customer { get; set; } = default!;

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Add(Customer);

            TempData["Register"] = "The customer has been created successfully!";

            return RedirectToPage("/Index");
        }
    }
}
