//
//  SubCategoryModel.swift
//  NetflixLikeView
//
//  Created by ADMIN on 2/15/19.
//  Copyright © 2019 Virtuoso. All rights reserved.
//

import UIKit

class SubCategoryModel: NSObject {

    //{
    //        id = 1;
    //        image = "https://www.planwallpaper.com/static/images/beautiful-sunset-images-196063.jpg";
    //        priority = 7;
    //        title = Morning;
    //        types = subcategory;
    //},
    

    
    var id  :   NSNumber    =   0
    var imageURL    :   String  =   ""
    var priority    :   NSNumber    = 0
    var title       :   String  =   ""
    var types       :   String  =   ""
    
    var created       :   String  =   ""
    var views       :   NSNumber    =   0
    var downloads       :   NSNumber    =   0
    
    init(dictionary : NSDictionary) {
        self.id         =       dictionary["id"] as? NSNumber   ??  0
        self.imageURL   =       dictionary["image"] as? String  ??  ""
        self.priority   =       dictionary["priority"]  as? NSNumber    ??  0
        self.title      =       dictionary["title"] as? String  ??  ""
        self.types      =       dictionary["types"]     as? String  ??  ""
        
        self.created      =     dictionary["created"]     as? String  ??  ""
        self.views      =       dictionary["views"]     as? NSNumber   ??  0
        self.downloads      =   dictionary["downloads"]     as? NSNumber   ??  0
        
    }
    
}
