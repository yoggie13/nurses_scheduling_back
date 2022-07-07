using Microsoft.EntityFrameworkCore;
using nurses_scheduling.Models;

namespace nurses_scheduling.Data
{
    public class ISContext : DbContext
    {
        private ISContext(DbContextOptions
       <ISContext> options) : base(options)
        {

        }
        public ISContext() { }
        public DbSet<Nurse> Nurses { get; set; }
        public DbSet<Assignement> Assignements { get; set; }
        public DbSet<Schedule> Schedules { get; set; }
        public DbSet<FreeDay> FreeDays { get; set; }

        internal static string db_string = "Data Source=(localdb)\\MSSQLLocalDB;Initial Catalog=Nurses_Scheduling_db;Integrated Security=True;" +
            "Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(db_string);
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Nurse>()
                .HasKey(n => n.ID);

            modelBuilder.Entity<Schedule>()
                .HasKey(s => s.ID);

            modelBuilder.Entity<Assignement>()
                .HasKey(a => new
                {
                    a.BelongsToScheduleID,
                    a.NurseAssignedID,
                    a.Day
                });

            modelBuilder.Entity<Assignement>()
                .HasOne(a => a.NurseAssigned)
                .WithMany(n => n.Assignements);

            modelBuilder.Entity<Assignement>()
                .HasOne(a => a.BelongsToSchedule)
                .WithMany(s => s.Assignements);

            modelBuilder.Entity<FreeDay>()
                .HasKey(f => new
                {
                    f.BelongsToScheduleID,
                    f.NurseID
                });

            modelBuilder.Entity<FreeDay>()
                .HasOne(f => f.Nurse)
                .WithMany(n => n.FreeDays);

            modelBuilder.Entity<FreeDay>()
                .HasOne(f => f.BelongsToSchedule)
                .WithMany(s => s.FreeDays);
        }
    }
}
