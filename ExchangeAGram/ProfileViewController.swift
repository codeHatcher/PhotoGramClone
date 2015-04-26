//
//  ProfileViewController.swift
//  ExchangeAGram
//
//  Created by Brown Magic on 4/24/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FBLoginViewDelegate {
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var fbLoginView: FBLoginView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // this will allow the delegate to call the below functions
    self.fbLoginView.delegate = self
    // persmission we want facebook to give us access to
    self.fbLoginView.readPermissions = ["public_profile", "publish_actions"]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
    // unhide the image and label
    profileImageView.hidden = false
    nameLabel.hidden = false
  }
  
  func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
    
  }
  
  func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
    // hide image and label upon logout
    profileImageView.hidden = true
    nameLabel.hidden = true
  }
  
  func loginView(loginView: FBLoginView!, handleError error: NSError!) {
    
  }
  
}