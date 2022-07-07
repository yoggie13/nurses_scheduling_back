using System.Text.Json.Serialization;

namespace nurses_scheduling.Models
{
    public class Nurse
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }
        public bool Experienced { get; set; }

        [JsonIgnore]
        public List<Schedule>? Schedules { get; set; }

        [JsonIgnore]
        public List<Assignement>? Assignements { get; set; }
        [JsonIgnore]
        public List<FreeDay>? FreeDays { get; set; }
    }
}
