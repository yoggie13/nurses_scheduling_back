using System.Text.Json.Serialization;

namespace nurses_scheduling.Models
{
    public class Schedule
    {
        public int ID { get; set; }
        public DateTime GeneratedOn { get; set; }
        public string Name { get; set; }
        public double Percentage { get; set; }
        public List<Assignement> Assignements { get; set; }
        [JsonIgnore]
        public List<FreeDay>? FreeDays { get; set; }
    }
}
