using CC_api.Business;
using CC_api.Models;
using CC_api.Repository;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Drive.v3;
using Google.Apis.Services;
using Google.Apis.Upload;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using Newtonsoft.Json;
using System.IO;

namespace CC_api.Controllers
{
  //Reference link : https://www.youtube.com/watch?v=Q5b0ivBYqeQ&ab_channel=DAIMTODeveloperTips
  public class AdController : Controller
  {
    private readonly DatabaseContext dbContext;

    private readonly AdBusiness _AdBusiness;
    private readonly AdRepository _AdRepository;
    private string? uploadedFileId;
    //Drive constant credentials
    private string PathToServiceAccountKeyFile = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "client_secret.json");
    private const string ServiceAccountEmail = "cc-436@cc-repository.iam.gserviceaccount.com";
    private const string DirectoryId = "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS";

    public AdController()
    {
      _AdBusiness = new AdBusiness();
      _AdRepository = new AdRepository();
      this.dbContext = new DatabaseContext();

    }



      [HttpPost("ExcelUploadAd")]
    public async Task<ActionResult> AdUploadExcelData([FromForm] string excelImportedData, [FromForm] int user_id, [FromForm] int company_id)
    {

        List<AdData> item = JsonConvert.DeserializeObject<List<AdData>>(excelImportedData);
        if (item == null || !item.Any())
      {
        return BadRequest("Excel data is empty.");
      }
      else
      {

        await _AdBusiness.AdImportData(item, user_id, company_id);
        return Ok();
      }

    }
   



    [HttpPost("PostAd")]
    public async Task<ActionResult> PostAd(IFormFile file,
      DateTime from_date, int expiry_date, string type_of_ad, int container_type_id,
      decimal price, int quantity, int port_id, int posted_by, int company_id,
      string contents, string port_of_departure, string port_of_arrival, int free_days,
      int per_diem, decimal pickup_charges, string operation)


    {
      if (operation == "PostAd")
      {
        // Load the Service account credentials and define the scope of its access.
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                        .CreateScoped(DriveService.ScopeConstants.Drive);

        var service = new DriveService(new BaseClientService.Initializer()
        {
          HttpClientInitializer = credential
        });

        // Upload file Metadata
        var fileMetadata = new Google.Apis.Drive.v3.Data.File()
        {
          Name = file.FileName,
          Parents = new List<string>() { "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS" }
        };

        await using (var stream = file.OpenReadStream())
        {
          var request = service.Files.Create(fileMetadata, stream, "application/pdf");
          request.Fields = "*";
          var results = await request.UploadAsync(CancellationToken.None);
          Console.WriteLine($"File upload status: {results.Status}");
          Console.WriteLine($"in weeks: {expiry_date}");
          if (results.Status == UploadStatus.Failed)
          {
            Console.WriteLine($"Error uploading file: {results.Exception.Message}");
          }

          DateTime expiry_date_time = from_date.AddDays(expiry_date * 7);
          // the file id of the new file we created
          uploadedFileId = request.ResponseBody?.Id;
          var Ad = new Ad
          {
            date_created = DateTime.Now,
            from_date = from_date,
            expiry_date = expiry_date_time,
            type_of_ad = type_of_ad,
            container_type_id = container_type_id,
            price = price,
            status = "pending",
            quantity = quantity,
            port_id = port_id,
            company_id = company_id,
            posted_by = posted_by,
            contents = contents,
            port_of_departure = port_of_departure,
            port_of_arrival = port_of_arrival,
            free_days = free_days,
            per_diem = per_diem,
            pickup_charges = pickup_charges,
            file = uploadedFileId
          };
          await this._AdBusiness.PostAd(Ad);


          return Ok(new { uploadedFileId, message = "Success" });
        }
      }
      else
      {
        // Load the Service account credentials and define the scope of its access.
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                        .CreateScoped(DriveService.ScopeConstants.Drive);

        var service = new DriveService(new BaseClientService.Initializer()
        {
          HttpClientInitializer = credential
        });

        // Upload file Metadata
        var fileMetadata = new Google.Apis.Drive.v3.Data.File()
        {
          Name = file.FileName,
          Parents = new List<string>() { "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS" }
        };

        await using (var stream = file.OpenReadStream())
        {
          var request = service.Files.Create(fileMetadata, stream, "application/pdf");
          request.Fields = "*";
          var results = await request.UploadAsync(CancellationToken.None);
          Console.WriteLine($"File upload status: {results.Status}");
          Console.WriteLine($"in weeks: {expiry_date}");
          if (results.Status == UploadStatus.Failed)
          {
            Console.WriteLine($"Error uploading file: {results.Exception.Message}");
          }

          DateTime expiry_date_time = from_date.AddDays(expiry_date * 7);
          // the file id of the new file we created
          uploadedFileId = request.ResponseBody?.Id;
          var Ad = new Ad
          {
            date_created = DateTime.Now,
            from_date = from_date,
            expiry_date = expiry_date_time,
            type_of_ad = type_of_ad,
            container_type_id = container_type_id,
            price = price,
            status = "draft",
            quantity = quantity,
            port_id = port_id,
            company_id = company_id,
            posted_by = posted_by,
            contents = contents,
            port_of_departure = port_of_departure,
            port_of_arrival = port_of_arrival,
            free_days = free_days,
            per_diem = per_diem,
            pickup_charges = pickup_charges,
            file = uploadedFileId
          };
          await this._AdBusiness.PostAd(Ad);


          return Ok(new { uploadedFileId, message = "Success" });
        }
      }

    }

    //End upload


/*    [HttpGet("GetAllAds")]
    public async Task<IActionResult> GetAllFiles(int companyID)
    {
      var Ads = await this._AdRepository.GetAdByCompanyID(companyID);
      // Load the Service account credentials and define the scope of its access.
      var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                      .CreateScoped(DriveService.ScopeConstants.Drive);

      var service = new DriveService(new BaseClientService.Initializer()
      {
        HttpClientInitializer = credential
      });

      // Create a list to store the results
      var results = new List<KeyValuePair<int, string>>();

      // Retrieve the file name for each Ad
      foreach (var Ad in Ads)
      {
        var fileId = Ad.Value;
        var request = service.Files.Get(fileId);
        request.Fields = "name";
        var file = await request.ExecuteAsync();
        results.Add(new KeyValuePair<int, string>(Ad.Key, file.Name));
      }

      // Return the list of results as a JSON array
      return Json(results);
    }
*/


    [HttpGet("GetAllAds")]
    public async Task<List<Ad>> GetAllFiles(int companyID, string operation)
    {
      var Ads = await this._AdRepository.GetAdByCompanyID(companyID, operation);
      return Ads;



      //to return with file use this//

      // Load the Service account credentials and define the scope of its access.
      /* var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
           .CreateScoped(DriveService.ScopeConstants.Drive);

       var service = new DriveService(new BaseClientService.Initializer()
       {
         HttpClientInitializer = credential
       });

       // Create a list to store the results
       var results = new List<Ad>();*/

      // Retrieve the file name for each Ad
      /* foreach (var Ad in Ads)
       {

         var fileId = Ad.file;
         var request = service.Files.Get(fileId);
         request.Fields = "name";
         var file = await request.ExecuteAsync();
         Ad.file = file.Name;
         results.Add(Ad);

       }*/

      // Return the list of results as a JSON array
      /*  return new JsonResult(results);*/


    }

    [HttpPut("Edit/{id}")]
   
        public async Task<ActionResult> UpdateAd(int id,IFormFile file,
      DateTime from_date, int expiry_date, string type_of_ad, int container_type_id,
      decimal price, int quantity, int port_id, int posted_by, int company_id,
      string contents, string port_of_departure, string port_of_arrival, int free_days,
      int per_diem, decimal pickup_charges, string operation)
    {
      if (operation == "Approve")
      {
        // Load the Service account credentials and define the scope of its access.
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                        .CreateScoped(DriveService.ScopeConstants.Drive);

        var service = new DriveService(new BaseClientService.Initializer()
        {
          HttpClientInitializer = credential
        });

        // Upload file Metadata
        var fileMetadata = new Google.Apis.Drive.v3.Data.File()
        {
          Name = file.FileName,
          Parents = new List<string>() { "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS" }
        };

        await using (var stream = file.OpenReadStream())
        {
          var request = service.Files.Create(fileMetadata, stream, "application/pdf");
          request.Fields = "*";
          var results = await request.UploadAsync(CancellationToken.None);
          Console.WriteLine($"File upload status: {results.Status}");
          Console.WriteLine($"in weeks: {expiry_date}");
          if (results.Status == UploadStatus.Failed)
          {
            Console.WriteLine($"Error uploading file: {results.Exception.Message}");
          }

          // the file id of the new file we created
          uploadedFileId = request.ResponseBody?.Id;

          DateTime expiry_date_time = from_date.AddDays(expiry_date*7);

          var Ad = new Ad
          {
            ad_id = id,
            date_created = DateTime.Now,
            from_date = from_date,
          expiry_date = expiry_date_time,
            type_of_ad = type_of_ad,
            container_type_id = container_type_id,
            price = price,
            status = "active",
            quantity = quantity,
            port_id = port_id,
            company_id = company_id,
            posted_by = posted_by,
            contents = contents,
            port_of_departure = port_of_departure,
            port_of_arrival = port_of_arrival,
            free_days = free_days,
            per_diem = per_diem,
            pickup_charges = pickup_charges,
            file = uploadedFileId
          };
          await this._AdBusiness.UpdateAd(Ad);


          return Ok(new { uploadedFileId, message = "Success" });
        }

      }
      else if(operation=="Draft")
      {
        // Load the Service account credentials and define the scope of its access.
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                        .CreateScoped(DriveService.ScopeConstants.Drive);

        var service = new DriveService(new BaseClientService.Initializer()
        {
          HttpClientInitializer = credential
        });

        // Upload file Metadata
        var fileMetadata = new Google.Apis.Drive.v3.Data.File()
        {
          Name = file.FileName,
          Parents = new List<string>() { "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS" }
        };

        await using (var stream = file.OpenReadStream())
        {
          var request = service.Files.Create(fileMetadata, stream, "application/pdf");
          request.Fields = "*";
          var results = await request.UploadAsync(CancellationToken.None);
          Console.WriteLine($"File upload status: {results.Status}");
          Console.WriteLine($"in weeks: {expiry_date}");
          if (results.Status == UploadStatus.Failed)
          {
            Console.WriteLine($"Error uploading file: {results.Exception.Message}");
          }

          // the file id of the new file we created
          uploadedFileId = request.ResponseBody?.Id;
          var Ad = new Ad
          {
            ad_id = id,
            date_created = DateTime.Now,
            from_date = from_date,
            expiry_date = from_date,
            type_of_ad = type_of_ad,
            container_type_id = container_type_id,
            price = price,
            status = "draft",
            quantity = quantity,
            port_id = port_id,
            company_id = company_id,
            posted_by = posted_by,
            contents = contents,
            port_of_departure = port_of_departure,
            port_of_arrival = port_of_arrival,
            free_days = free_days,
            per_diem = per_diem,
            pickup_charges = pickup_charges,
            file = uploadedFileId
          };
          await this._AdBusiness.UpdateAd(Ad);


          return Ok(new { uploadedFileId, message = "Success" });
        }

      }
      else
      {
        // Load the Service account credentials and define the scope of its access.
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                        .CreateScoped(DriveService.ScopeConstants.Drive);

        var service = new DriveService(new BaseClientService.Initializer()
        {
          HttpClientInitializer = credential
        });

        // Upload file Metadata
        var fileMetadata = new Google.Apis.Drive.v3.Data.File()
        {
          Name = file.FileName,
          Parents = new List<string>() { "1w4uzPE0UuoaQVeKDLALs4l1ceqUFfLMS" }
        };

        await using (var stream = file.OpenReadStream())
        {
          var request = service.Files.Create(fileMetadata, stream, "application/pdf");
          request.Fields = "*";
          var results = await request.UploadAsync(CancellationToken.None);
          Console.WriteLine($"File upload status: {results.Status}");
          Console.WriteLine($"in weeks: {expiry_date}");
          if (results.Status == UploadStatus.Failed)
          {
            Console.WriteLine($"Error uploading file: {results.Exception.Message}");
          }

          // the file id of the new file we created
          uploadedFileId = request.ResponseBody?.Id;
          var Ad = new Ad
          {
            ad_id = id,
            date_created = DateTime.Now,
            from_date = from_date,
            expiry_date = from_date,
            type_of_ad = type_of_ad,
            container_type_id = container_type_id,
            price = price,
            status = "pending",
            quantity = quantity,
            port_id = port_id,
            company_id = company_id,
            posted_by = posted_by,
            contents = contents,
            port_of_departure = port_of_departure,
            port_of_arrival = port_of_arrival,
            free_days = free_days,
            per_diem = per_diem,
            pickup_charges = pickup_charges,
            file = uploadedFileId
          };
          await this._AdBusiness.UpdateAd(Ad);


          return Ok(new { uploadedFileId, message = "Success" });
        }

      }

    }

    [HttpPut("Approve")]
    public async Task<IActionResult> ActivateAd(int adId)
    {
      await _AdBusiness.UpdateAdStatus(adId);
      return Ok();
    }


    [HttpDelete("DeleteAd")]
    public async Task<IActionResult> DeleteAd(int AdID)
    {
      try
      {
        var credential = GoogleCredential.FromFile(PathToServiceAccountKeyFile)
                     .CreateScoped(DriveService.ScopeConstants.Drive);
        var service = new DriveService(new BaseClientService.Initializer
        {
          HttpClientInitializer = credential,
        });
        var fileId = await _AdRepository.GetFileIDbyAdID(AdID);
        // Delete the file from Google Drive
        await service.Files.Delete(fileId).ExecuteAsync();
        await _AdRepository.DeleteAd(AdID);

        // Return a success response
        return Ok();
      }
      catch
      {
        await _AdRepository.DeleteAd(AdID);

        // Return a success response
        return Ok();
      }
      
   
    }
  }
}


