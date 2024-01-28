using Microsoft.EntityFrameworkCore;
using UniversitateApp.Models;

namespace UniversitateApp.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options) { 
            
        }

        public DbSet<Student> Student { get; set; }

        public DbSet<Grupa> Grupa { get; set; }

        public DbSet<Orase> Orase { get; set; }

        public DbSet<Materie> Materie { get; set; }

        public DbSet<Note> Note { get; set; }
    }
}
