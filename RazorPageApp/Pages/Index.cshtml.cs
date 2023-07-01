using BusinessObject.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using RazorPageApp.ViewModel;
using Repositories.Service;

namespace RazorPageApp.Pages
{
    public class IndexModel : PageModel
    {
        [BindProperty]
        public LoginVM LoginVM { get; set; }

        private readonly ServiceBase<Customer> _serviceBase;
        public IndexModel()
        {
            _serviceBase = new ServiceBase<Customer>();
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            var customer = _serviceBase.GetAll().FirstOrDefault(c => c.Email == LoginVM.Username && c.Password == LoginVM.Password);
            if (customer == null)
            {
                ModelState.AddModelError("LoginVM.Password", "Invalid username or password");
                //ModelState.AddModelError(string.Empty, "Invalid username or password");
                return Page();
            }

            return RedirectToPage("/Flower/Index");
        }
    }
}