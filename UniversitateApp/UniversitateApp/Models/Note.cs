namespace UniversitateApp.Models
{
    public class Note
    {
        public required int Id { get; set; }

        public required int Nota { get; set; }

        public required int StudentId { get; set; }

        public required int MaterieId { get; set; }
    }
}
