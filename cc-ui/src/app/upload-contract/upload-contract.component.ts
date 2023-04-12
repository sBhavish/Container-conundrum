import { Component } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { filter } from 'rxjs';
import { SessionService } from '../session.service';

@Component({
  selector: 'app-upload-contract',
  templateUrl: './upload-contract.component.html',
  styleUrls: ['./upload-contract.component.css']
})
export class UploadContractComponent {
  currentUser: any;

  constructor(private sessionService: SessionService,private router: Router) { }

  ngOnInit(): void {
    // retrieve the user session information
    this.sessionService.getCurrentUser().subscribe(user => {
      // if (user.id==null && user.token==null) {  // use this once token is used for a user
      if (user.user_id==null) {
        // if user session is null, redirect to login page
        this.router.navigate(['/sign-in']);
      }
      else{
        this.currentUser = user;
      console.log('From session '+this.currentUser.email+'  id here '+this.currentUser.user_id)

      }
      // store the user session information in a property
      
    });

    //when navigate back to sign-in session ends
    this.router.events.pipe(
      filter(event => event instanceof NavigationEnd && event.url === '/sign-in')
    ).subscribe(() => {
      this.sessionService.clearSession();
    });
  }

  logout(): void {
    // clear session data and redirect to login page
    this.sessionService.clearSession();
  
}
}
