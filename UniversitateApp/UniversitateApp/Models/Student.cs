namespace UniversitateApp.Models
{
    public class Student
    {
        public required int Id { get; set; }

        public required string Nume { get; set; }

        public required string Prenume { get; set; }

        public required int GrupaId { get; set; }

        public required int OrasId { get; set; }
    }
}
