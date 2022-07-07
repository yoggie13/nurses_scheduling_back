using Microsoft.AspNetCore.Mvc;

namespace nurses_scheduling.Controllers
{
    [ApiController]
    [Route("")]
    public class NursesController : ControllerBase
    {
        
        private readonly ILogger<NursesController> _logger;

        public NursesController(ILogger<NursesController> logger)
        {
            _logger = logger;
        }

        [HttpGet("nurses")]
        public ActionResult<object> GetNurses()
        {
            try
            {
                return Ok("");
            }
            catch(Exception ex)
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