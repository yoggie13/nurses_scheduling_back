namespace nurses_scheduling.Models
{

    public enum DayType
    {
        Običan_slobodan_dan,
        Godišnji_odmor,
        Bolovanje,
        Trudničko,
        Poroiljsko,
        Osmi_mart
    }
    
    public class FreeDay
    {
        public Schedule BelongsToSchedule { get; set; }
        public int BelongsToScheduleID { get; set; }
        public DateTime Date_From { get; set; }
        public DateTime Date_Until { get; set; }
        public Nurse Nurse { get; set; }
        public int NurseID { get; set; }
        public bool isPaid { get; set; }
        public bool isVacation { get; set; }
    }
}
