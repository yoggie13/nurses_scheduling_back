﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using nurses_scheduling.Data;

#nullable disable

namespace nurses_scheduling.Migrations
{
    [DbContext(typeof(ISContext))]
    [Migration("20220707133237_added-nullable")]
    partial class addednullable
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.6")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("nurses_scheduling.Models.Assignement", b =>
                {
                    b.Property<int>("BelongsToScheduleID")
                        .HasColumnType("int");

                    b.Property<int>("NurseAssignedID")
                        .HasColumnType("int");

                    b.Property<DateTime>("Day")
                        .HasColumnType("datetime2");

                    b.Property<int>("Shift")
                        .HasColumnType("int");

                    b.HasKey("BelongsToScheduleID", "NurseAssignedID", "Day");

                    b.HasIndex("NurseAssignedID");

                    b.ToTable("Assignements");
                });

            modelBuilder.Entity("nurses_scheduling.Models.FreeDay", b =>
                {
                    b.Property<int>("BelongsToScheduleID")
                        .HasColumnType("int");

                    b.Property<int>("NurseID")
                        .HasColumnType("int");

                    b.Property<DateTime>("Date_From")
                        .HasColumnType("datetime2");

                    b.Property<DateTime>("Date_Until")
                        .HasColumnType("datetime2");

                    b.Property<bool>("isPaid")
                        .HasColumnType("bit");

                    b.Property<bool>("isVacation")
                        .HasColumnType("bit");

                    b.HasKey("BelongsToScheduleID", "NurseID");

                    b.HasIndex("NurseID");

                    b.ToTable("FreeDays");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Nurse", b =>
                {
                    b.Property<int>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ID"), 1L, 1);

                    b.Property<bool>("Experienced")
                        .HasColumnType("bit");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Surname")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("ID");

                    b.ToTable("Nurses");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Schedule", b =>
                {
                    b.Property<int>("ID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ID"), 1L, 1);

                    b.Property<DateTime>("GeneratedOn")
                        .HasColumnType("datetime2");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("NurseID")
                        .HasColumnType("int");

                    b.Property<double>("Percentage")
                        .HasColumnType("float");

                    b.HasKey("ID");

                    b.HasIndex("NurseID");

                    b.ToTable("Schedules");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Assignement", b =>
                {
                    b.HasOne("nurses_scheduling.Models.Schedule", "BelongsToSchedule")
                        .WithMany("Assignements")
                        .HasForeignKey("BelongsToScheduleID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("nurses_scheduling.Models.Nurse", "NurseAssigned")
                        .WithMany("Assignements")
                        .HasForeignKey("NurseAssignedID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("BelongsToSchedule");

                    b.Navigation("NurseAssigned");
                });

            modelBuilder.Entity("nurses_scheduling.Models.FreeDay", b =>
                {
                    b.HasOne("nurses_scheduling.Models.Schedule", "BelongsToSchedule")
                        .WithMany("FreeDays")
                        .HasForeignKey("BelongsToScheduleID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("nurses_scheduling.Models.Nurse", "Nurse")
                        .WithMany("FreeDays")
                        .HasForeignKey("NurseID")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("BelongsToSchedule");

                    b.Navigation("Nurse");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Schedule", b =>
                {
                    b.HasOne("nurses_scheduling.Models.Nurse", null)
                        .WithMany("Schedules")
                        .HasForeignKey("NurseID");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Nurse", b =>
                {
                    b.Navigation("Assignements");

                    b.Navigation("FreeDays");

                    b.Navigation("Schedules");
                });

            modelBuilder.Entity("nurses_scheduling.Models.Schedule", b =>
                {
                    b.Navigation("Assignements");

                    b.Navigation("FreeDays");
                });
#pragma warning restore 612, 618
        }
    }
}
