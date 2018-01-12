//
//  PhotoCell.swift
//  MyMenuReader
//
//  Created by xi zhang on 1/11/18.
//  Copyright © 2018 xi zhang. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    public func configureWithData(data:String){
        Alamofire.request(data).responseImage { response in
            if let image = response.result.value {
                self.imageView.image = image
            }
        }
    }
}
