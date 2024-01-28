using Microsoft.AspNetCore.Mvc;
using System.Collections;
using UniversitateApp.Authentication.Attributes;
using UniversitateApp.Data;
using UniversitateApp.Models;

namespace UniversitateApp.Controllers
{
    [Route("/api/[controller]")]
    [ApiController]
    public class MateriiNoteController : Controller
    {
        private readonly DataContext context;
        private readonly Hashtable materii = new Hashtable();

        public MateriiNoteController(DataContext dataContext)
        {
            this.context = dataContext;

            var materie_result = this.context.Materie.ToList();

            foreach (var item in materie_result)
            {
                this.materii.Add(item.Id, item.Nume);
            }
        }

        [HttpGet("id")]
        [ProducesResponseType(200, Type = typeof(IEnumerable<Orase>))]
        [ProducesResponseType(400)]
        [BasicAuthorization]
        public IActionResult GetOrase(int id)
        {
            var note = this.context.Note.Where(p => p.StudentId == id).ToList();
            if (note == null)
            {
                return NotFound("Niciun student cu id-ul " + id);
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            Hashtable result = new Hashtable();

            foreach (var item in note)
            {
                var materieId = item.MaterieId;

                if (!this.materii.ContainsKey(materieId))
                {
                    result.Add(this.materii[materieId], item.Nota);
                } else
                {
                    result[this.materii[materieId]] = item.Nota;
                }
            }

            return Ok(result);
        }
    }
}
