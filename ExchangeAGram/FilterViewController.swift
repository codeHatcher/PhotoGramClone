//
//  FilterViewController.swift
//  ExchangeAGram
//
//  Created by Brown Magic on 4/15/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var thisFeedItem:FeedItem!
  
  var collectionView:UICollectionView!
  
  let kIntensity = 0.7
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // view instance to organize items UIFlowCollectionViewLayout
    
    let layout = UICollectionViewFlowLayout()
    // add some insets
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.itemSize = CGSize(width: 150.0, height: 150.0)
    collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
    
    // set delegate datasource, normally we drag in storyboard
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.whiteColor()
    // register cell with the class
    collectionView.registerClass(FilterCell.self, forCellWithReuseIdentifier: "MyCell")
    
    self.view.addSubview(collectionView)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // UICollectionViewDataSource
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell:FilterCell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath) as FilterCell
    cell.imageView.image = UIImage(named: "Placeholder")
    
    return cell
  }
  
  // Helper Function
  
  // return array of Image View filter instances
  func photoFilters() -> [CIFilter] {
    // filter instances
    let blur = CIFilter(name: "CIGaussianBlur")
    
    let instant = CIFilter(name: "CIPhotoEffectInstant")
    
    let noir = CIFilter(name: "CIPhotoEffectNoir")
    
    let transfer = CIFilter(name: "CIPhotoEffectTransfer")
    
    let unsharpen = CIFilter(name: "CIUnsharpMask")
    
    let monochrome = CIFilter(name: "CIColorMonochrome")
    
    let colorControls = CIFilter(name: "CIColorControls")
    colorControls.setValue(0.5, forKey: kCIInputSaturationKey)
    
    let sepia = CIFilter(name: "CISepiaTone")
    sepia.setValue(kIntensity, forKey: kCIInputIntensityKey)
    
    let colorClamp = CIFilter(name: "CIColorClamp")
    colorClamp.setValue(CIVector(x: 0.9, y: 0.9, z: 0.9, w: 0.9), forKey: "inputMaxComponents")
    colorClamp.setValue(CIVector(x: 0.2, y: 0.2, z: 0.2, w: 0.2), forKey: "inputMinComponents")
    
    let composite = CIFilter(name: "CIHardLightBlendMode")
    // take image from the sepia conversion
    composite.setValue(sepia.outputImage, forKey: kCIInputImageKey)
    
    let vignette = CIFilter(name: "CIVignette")
    vignette.setValue(composite.outputImage, forKey: kCIInputImageKey)
    vignette.setValue(kIntensity*2, forKey: kCIInputIntensityKey)
    vignette.setValue(kIntensity*30, forKey: kCIInputRadiusKey)
    
    return [blur, instant, noir, transfer, unsharpen, monochrome, colorControls, sepia, colorClamp, composite, vignette]
  }
  
}