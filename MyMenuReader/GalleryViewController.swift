//
//  GalleryViewController.swift
//  MyMenuReader
//
//  Created by xi zhang on 1/11/18.
//  Copyright © 2018 xi zhang. All rights reserved.
//
import Foundation
import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public var photos: [String] = []
    
    fileprivate let reuseIdentifier = "reusableCell"
    fileprivate let padding:CGFloat = 5.0
    fileprivate let photoPerRow = 3
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName:"PhotoCell", bundle:nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(padding)
        layout.minimumInteritemSpacing = CGFloat(padding)
        self.collectionView.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.configureWithData(data: self.photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let wh = (self.collectionView.bounds.size.width - padding * CGFloat(photoPerRow + 1)) / CGFloat(photoPerRow)
        let size = CGSize.init(width: wh, height: wh)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
    }
}
