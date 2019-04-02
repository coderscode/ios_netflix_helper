//
//  CategoryModel.swift
//  NetflixLikeView
//
//  Created by ADMIN on 2/15/19.
//  Copyright © 2019 Virtuoso. All rights reserved.
//

import UIKit

//id = 1;
//image = "https://i.pinimg.com/originals/5a/e5/8f/5ae58f5036997cfd4636917403c3c951.jpg";
//subcategories =             (
//    {
//        id = 1;
//        image = "https://www.planwallpaper.com/static/images/beautiful-sunset-images-196063.jpg";
//        priority = 7;
//        title = Morning;
//        types = subcategory;
//},
//    {
//        id = 3;
//        image = "https://i.pinimg.com/236x/5a/30/07/5a30079fba05edbe41ffd16b039dcfba--good-afternoon-quotes-happy-morning.jpg";
//        priority = 8;
//        title = Afternoon;
//        types = subcategory;
//},
//    {
//        id = 5;
//        image = "https://i.ytimg.com/vi/4_Pj1ixJBWM/maxresdefault.jpg";
//        priority = 9;
//        title = Evening;
//        types = subcategory;
//}
//);
//title = "Daily Quotes";
//type = category;

class CategoryModel: NSObject {
    
    var id  :   NSNumber    =   0
    var imageURL    :   String  =   ""
    var subcategories    :   [SubCategoryModel]    = []
  //  var greetingmodel    :   [GREETING_Model]    = []

    var title       :   String  =   ""
    var types       :   String  =   ""
    
    init(dictionary : NSDictionary)
  
    {
        self.id         =       dictionary["id"] as? NSNumber   ??  0
        self.imageURL   =       dictionary["image"] as? String  ??  ""
        var subCats :   [SubCategoryModel]  =   []
        self.types      =       dictionary["type"]     as? String  ??  ""
        
        
        let subCategoriesArray  =   dictionary["subcategories"] as? NSArray ??  []
        if subCategoriesArray.count >   0{
            for subC in subCategoriesArray{
                let model   =   SubCategoryModel(dictionary: subC as! NSDictionary)
                subCats.append(model)
            }
        }
        
       
        
        let greetingsArray  =   dictionary["greetings"] as? NSArray ??  []
        
        if greetingsArray.count >   0{
           
            for subC in greetingsArray{

            let model   =   SubCategoryModel(dictionary: subC as! NSDictionary)
               
                subCats.append(model)
            }
        }
        
        
        
        self.subcategories   =    subCats
        self.title      =        dictionary["title"] as? String  ??  ""
        
    }

}
