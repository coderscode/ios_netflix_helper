//
//  ViewController.swift
//  NetflixLikeView
//
//  Created by ADMIN on 2/15/19.
//  Copyright © 2019 Virtuoso. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var collectionViewHomeData: UICollectionView!
    var homeModelArray  :   [CategoryModel] =   []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let router = Router.getGreetings()
        WebService().sendData(showLoader: true, loadingMessage: "", router: router, completionHandler: {responseModel in
            WebService().hideLoader()
            print("data from service:- \(responseModel.data)")
            self.homeModelArray.removeAll()
            for datas in responseModel.data["home_page"] as! NSArray{
                if ((datas as! NSDictionary)["type"] as? String  ??  "")    !=  "subcategory"{
                    self.homeModelArray.append(CategoryModel(dictionary: datas as! NSDictionary))
                }
            }
            self.collectionViewHomeData.reloadData()
            print("count for all data without subcats:- \(self.homeModelArray.count)")
            
        })
    }
//CellImageOnly
//CellImageAndText
}

extension   ViewController  :   UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let subCategory =   homeModelArray[section]
        return subCategory.subcategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let catModel    =   self.homeModelArray[indexPath.section]
        let subCatModel =   catModel.subcategories[indexPath.row]
        if indexPath.section    ==  0{
            let cell1   =   collectionView.dequeueReusableCell(withReuseIdentifier: "CellImageOnly", for: indexPath) as! CollectionCellImageOnly
//            cell1.maskView?.sd_setImageLoad(with: URL(string: subCatModel.imageURL), completed: nil)
            return cell1
        }else{
            let cell2   =   collectionView.dequeueReusableCell(withReuseIdentifier: "CellImageAndText", for: indexPath) as! CollectionCellImageText
            cell2.imageView?.sd_setImage(with: URL(string: subCatModel.imageURL), completed: nil)
            cell2.labelTitle.text   =   subCatModel.title
            return cell2
        }
    }
}



//class CollectionCellImageOnly : UICollectionViewCell{
//    @IBOutlet weak var cardView: CardView!
//    @IBOutlet weak var imageView: UIImageView!
//    
//}


class CollectionCellImageText : UICollectionViewCell{
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardView: CardView!
}
