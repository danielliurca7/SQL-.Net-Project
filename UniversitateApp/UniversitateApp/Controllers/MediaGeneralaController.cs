using Microsoft.AspNetCore.Mvc;
using System.Collections;
using UniversitateApp.Authentication.Attributes;
using UniversitateApp.Data;
using UniversitateApp.Models;

namespace UniversitateApp.Controllers
{
    [Route("/api/[controller]")]
    [ApiController]
    public class MediaGeneralaController : Controller
    {
        private readonly DataContext context;
        private readonly Hashtable materii = new Hashtable();

        public MediaGeneralaController(DataContext dataContext)
        {
            this.context = dataContext;
        }

        [HttpGet("id")]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Orase>))]
        [ProducesResponseType(400)]
        [BasicAuthorization]
        public IActionResult GetOrase(int id)
        {
            var note = this.context.Note.Where(p => p.StudentId == id).ToList();
            if (note == null || note.Count() == 0)
            {
                return NotFound("Niciun student cu id-ul " + id);
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Hashtable situatiaCurenta = new Hashtable();

            foreach (var item in note)
            {
                var materieId = item.MaterieId;

                if (!situatiaCurenta.ContainsKey(materieId))
                {
                    situatiaCurenta.Add(materieId, item.Nota);
                }
                else
                {
                    situatiaCurenta[materieId] = item.Nota;
                }
            }

            return Ok(Math.Round(situatiaCurenta.Values.Cast<int>().Average(), 2));
        }
    }
}
