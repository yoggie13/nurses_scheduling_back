using Microsoft.AspNetCore.Mvc;
using nurses_scheduling.Data;
using nurses_scheduling.Models;
using System.Text;
using System.Text.Json;

namespace nurses_scheduling.Controllers
{
    [ApiController]
    [Route("api")]
    public class NursesController : ControllerBase
    {

        private readonly ILogger<NursesController> _logger;
        private ISContext _context;

        public NursesController(ILogger<NursesController> logger)
        {
            _logger = logger;
            _context = new ISContext();
        }

        [HttpGet("nurses")]
        public ActionResult<object> GetNurses()
        {
            try
            {
                var nurses = _context.Nurses;

                using (var stream = new MemoryStream())
                {
                    var options = new JsonWriterOptions
                    {
                        Indented = true
                    };

                    using (var writer = new Utf8JsonWriter(stream, options))
                    {
                        writer.WriteStartArray();

                        foreach (Nurse nurse in nurses)
                        {
                            writer.WriteStartObject();
                            writer.WriteNumber("id", nurse.ID);
                            writer.WriteString("label", $"{nurse.Name} {nurse.Surname}");
                            writer.WriteEndObject();
                        }

                        writer.WriteEndArray();

                    }
                    string json = Encoding.UTF8.GetString(stream.ToArray());
                    return Ok(json);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("days")]
        public ActionResult<object> GetDays()
        {
            try{
                using (var stream = new MemoryStream())
                {
                    var options = new JsonWriterOptions
                    {
                        Indented = true
                    };

                    using (var writer = new Utf8JsonWriter(stream, options))
                    {
                        writer.WriteStartArray();

                        foreach (DayType dt in Enum.GetValues(typeof(DayType)).Cast<DayType>())
                        {
                            writer.WriteStartObject();

                            writer.WriteNumber("id", (int)dt);
                            writer.WriteString("label", dt.ToString().Replace('_',' '));

                            writer.WriteEndObject();
                        }
                        writer.WriteEndArray();
                    }
                    string json = Encoding.UTF8.GetString(stream.ToArray());
                    return Ok(json);
                }
            }
            catch(Exception ex){
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPost("nurses")]
        public ActionResult<object> AddNurses(List<Nurse> nurses)
        {
            try
            {
                _context.AddRange(nurses);
                _context.SaveChanges();

                return Ok(_context.Nurses);
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }

        }
        [HttpPost("requests")]
        public ActionResult<object> AddRequests()
        {
            try
            {
                return Ok("");
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("reports")]
        public ActionResult<object> GetReports()
        {
            try
            {
                return Ok("");
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("reports/{id}")]
        public ActionResult<object> GetReport(int id)
        {
            try
            {
                return Ok("");
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }

    }
}