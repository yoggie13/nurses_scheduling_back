using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace nurses_scheduling.Migrations
{
    public partial class addedpercentagetoschedule : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<double>(
                name: "Percentage",
                table: "Schedules",
                type: "float",
                nullable: false,
                defaultValue: 0.0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Percentage",
                table: "Schedules");
        }
    }
}
