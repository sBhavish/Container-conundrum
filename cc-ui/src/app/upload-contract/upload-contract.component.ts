import { Component, OnInit } from '@angular/core';
import { UploadService } from './upload.service';
import { FormGroup } from '@angular/forms';
import { SessionService } from '../session.service';



@Component({
  selector: 'app-upload-contract',
  templateUrl: './upload-contract.component.html',
  styleUrls: ['./upload-contract.component.css']
})
export class UploadContractComponent implements OnInit {
  contractForm!: FormGroup;
  description!: any;
  companyId: any;
  userId: any;
  title!: any;
  fileName?: string
  statusMsg?:string
  showFile:boolean = false
  files!: File[];

  constructor(private uploadService: UploadService, private sessionService: SessionService) {
  }


  ngOnInit(): void {

    //get company id from session
    this.sessionService.getCompanyId().subscribe(
      (companyId: number) => {
        this.companyId = companyId;
        console.log('company ID is :', companyId);
      },
      (error: any) => {
        console.error('Error retrieving company ID:', error);
      }
    );

    //user id from session 
    this.sessionService.getUserId().subscribe(
      (userId: number) => {
        this.userId = userId;
        console.log('User ID is :', userId);
      },
      (error: any) => {
        console.error('Error retrieving user ID:', error);
      }
    );
  }
  
  async onChange($event: Event) {
    debugger
    const target = $event.target as HTMLInputElement;
    const files: FileList = target.files as FileList;
    this.files = Array.from(files);

    this.showFile = !this.showFile;
    // await setTimeout(() => { this.showFile = !this.showFile }, 3000);
}

   async onUpload() {
    debugger
    if (this.files.length>0) {
      debugger
       this.uploadService.uploadFile(this.files, this.userId, this.companyId, this.description, this.title).subscribe((response: any) => {
        debugger
        if (response.message === 'Success') {
          this.statusMsg = 'Success';
          setTimeout(()=> {this.statusMsg = ""},2000)
          this.clear()
        } else {
          this.statusMsg = 'Failed';
          console.log(response.status) ;
        }
      });
    }
  }
  clear(){
    this.description = null
  }
}
