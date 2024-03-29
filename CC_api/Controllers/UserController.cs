using CC_api.Business;
using CC_api.Models;
using CC_api.Repository;
using Microsoft.AspNetCore.Mvc;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;

namespace CC_api.Controllers
{
  public class UserController : Controller
  {
    private readonly ILogger<UserController> _logger;
    private readonly UserBusiness userBusiness;

    public UserController(ILogger<UserController> logger)
    {
      _logger = logger;
      userBusiness = new UserBusiness();
    }
    [HttpGet("GetUserDetails")]
    public async Task<IActionResult> GetUserAsync(int userId)
    {
      return Ok(await userBusiness.GetUserAsync(userId));
    }

    //[HttpGet("GetAllUser")]
    //public async Task<List<User>> GetAllUser(int companyid)
    //{
    //  return await userBusiness.GetAllUserAsync(companyid);
    //}



    [HttpPost("VerifyOTP")]
    public async Task<IActionResult> VerifyOTPAsync([FromBody] VerifyOTPRequest payload)
    {
      try
      {
        var result = await userBusiness.VerifyOTPAsync(payload.UserId, payload.otp);



        if (result)
          return Ok(new { message = "OTP verified successfully" });
        else
          return Ok(new { message = "OTP verification failed" });
      }
      catch (Exception ex)
      {
        return BadRequest();
      }
    }

    [HttpPost("SaveUser")]

    public async Task<IActionResult> SaveUserAsync([FromBody] User user)
    {
      {
        return await userBusiness.SaveUserAsync(user);

      }
    }

    [HttpGet("GetUserByEmail/{email}")]
    public async Task<IActionResult> GetUserByEmail(string email)
    {
      try
      {
        var user = await userBusiness.GetUserByEmail(email);
        if (user == null)
        {
          return NotFound(new { message = "User not found" });
        }
        return Ok(user);
      }
      catch (Exception ex)
      {
        return BadRequest();
      }
    }

    [HttpPost("Login")]
    public async Task<IActionResult> Login([FromBody] Login user)
    {
      try
      {
        var loginUser = await userBusiness.GetUserByEmailAndPassword(user.email, user.password);
        if (loginUser == null)
        {
          return Ok(new { message = "User not exist", user = loginUser });
        }



        return Ok(loginUser);
      }
      catch (Exception ex)
      {
        return BadRequest();
      }
    }
    [HttpGet("OTPVerification/{email}")]
    public async Task<int> OtpVerification(string email)
    {
      return await userBusiness.generateOTP(email);

    }
    [HttpPut("UpdatePassword")]
    public async Task<IActionResult> UpdateCompany([FromBody] User user)
    {
      return await userBusiness.UpdatePasswordAsync(user.user_id, user.company_id, user.password);
    }
    [HttpGet("GetUserById/{id}")]
    public async Task<User> GetUserById(int id)
    {
      return await userBusiness.GetUserById(id);
    }

    [HttpPut("EditUserById/{id}")]
    public async Task<IActionResult> EditUserById(int id, [FromBody] User user)
    {
      return await userBusiness.EditUserById(id, user);

    }
    [HttpGet("GetAllUser/{companyid}")]
    public async Task<List<User>> GetAllUser(int companyid)
    {
      return await userBusiness.GetAllUserAsync(companyid);
    }
    [HttpGet("GetAllUserCount/{companyid}")]
    public async Task<int> GetAllUserCount(int companyid)
    {
       return await userBusiness.GetAllUserCount(companyid);
    }

    [HttpDelete("DeleteUser/{id}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
      //await userBusiness.DeleteUser(id);
      await userBusiness.DeleteUser(id);

      return new OkResult();
    }
  }
}
