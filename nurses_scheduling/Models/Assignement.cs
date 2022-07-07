namespace nurses_scheduling.Models
{
    public enum ShiftType
    {
        Morning,
        Afternoon,
        Whole_Day,
        Night
    }
    public class Assignement
    {
        public Schedule BelongsToSchedule { get; set; }
        public int BelongsToScheduleID { get; set; }
        public Nurse NurseAssigned { get; set; }
        public int NurseAssignedID { get; set; }
        public DateTime Day { get; set; }
        public ShiftType Shift { get; set; }
    }
}
