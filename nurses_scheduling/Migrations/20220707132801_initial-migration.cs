using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace nurses_scheduling.Migrations
{
    public partial class initialmigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Nurses",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Surname = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Experienced = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Nurses", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Schedules",
                columns: table => new
                {
                    ID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GeneratedOn = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    NurseID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Schedules", x => x.ID);
                    table.ForeignKey(
                        name: "FK_Schedules_Nurses_NurseID",
                        column: x => x.NurseID,
                        principalTable: "Nurses",
                        principalColumn: "ID");
                });

            migrationBuilder.CreateTable(
                name: "Assignements",
                columns: table => new
                {
                    BelongsToScheduleID = table.Column<int>(type: "int", nullable: false),
                    NurseAssignedID = table.Column<int>(type: "int", nullable: false),
                    Day = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Shift = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Assignements", x => new { x.BelongsToScheduleID, x.NurseAssignedID, x.Day });
                    table.ForeignKey(
                        name: "FK_Assignements_Nurses_NurseAssignedID",
                        column: x => x.NurseAssignedID,
                        principalTable: "Nurses",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Assignements_Schedules_BelongsToScheduleID",
                        column: x => x.BelongsToScheduleID,
                        principalTable: "Schedules",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "FreeDays",
                columns: table => new
                {
                    BelongsToScheduleID = table.Column<int>(type: "int", nullable: false),
                    NurseID = table.Column<int>(type: "int", nullable: false),
                    Date_From = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Date_Until = table.Column<DateTime>(type: "datetime2", nullable: false),
                    isPaid = table.Column<bool>(type: "bit", nullable: false),
                    isVacation = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FreeDays", x => new { x.BelongsToScheduleID, x.NurseID });
                    table.ForeignKey(
                        name: "FK_FreeDays_Nurses_NurseID",
                        column: x => x.NurseID,
                        principalTable: "Nurses",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_FreeDays_Schedules_BelongsToScheduleID",
                        column: x => x.BelongsToScheduleID,
                        principalTable: "Schedules",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Assignements_NurseAssignedID",
                table: "Assignements",
                column: "NurseAssignedID");

            migrationBuilder.CreateIndex(
                name: "IX_FreeDays_NurseID",
                table: "FreeDays",
                column: "NurseID");

            migrationBuilder.CreateIndex(
                name: "IX_Schedules_NurseID",
                table: "Schedules",
                column: "NurseID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Assignements");

            migrationBuilder.DropTable(
                name: "FreeDays");

            migrationBuilder.DropTable(
                name: "Schedules");

            migrationBuilder.DropTable(
                name: "Nurses");
        }
    }
}
