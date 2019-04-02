//
//  GLTableCollectionViewController.swift
//  GLTableCollectionView
//
//  Created by Giulio Lombardo on 24/11/16.
//
//  MIT License
//
//  Copyright (c) 2018 Giulio Lombardo
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH TH@objc E SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//

import UIKit

final class GLTableCollectionViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // This static string constant will be the cellIdentifier for the
    // UITableViewCells holding the UICollectionView, it's important to append
    // "_section#" to it so we can understand which cell is the one we are
    // looking for in the debugger. Look in UITableView's data source
    // cellForRowAt method for more explanations about the UITableViewCell reuse
    // handling.
    static let tableCellID: String = "tableViewCellID_section_#"

    var numberOfSections: Int = 0
    var numberOfCollectionsForRow: Int = 1
    var numberOfCollectionItems: Int = 0
    
    
    
    
    var homeModelArray  :   [CategoryModel] =   []
    var colorsDict: [Int: [UIColor]] = [:]

    /// Set true to enable UICollectionViews scroll pagination
    var paginationEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between
        // presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the
        // navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

//        (0 ... numberOfSections - 1).forEach { section in
//            colorsDict[section] = randomRowColors()
//        }
    }

  
    
    
    
    @IBAction func actionLoad(_ sender: Any) {
        let router = Router.getGreetings()
        WebService().sendData(showLoader: true, loadingMessage: "", router: router, completionHandler: {responseModel in
            WebService().hideLoader()
            print("data from service:- \(responseModel.data)")
            self.homeModelArray.removeAll()
            for datas in responseModel.data["home_page"] as! NSArray{
               // if ((datas as! NSDictionary)["type"] as? String  ??  "")    !=  "subcategory"{
                    self.homeModelArray.append(CategoryModel(dictionary: datas as! NSDictionary))
                //}
            }
            
            
            self.numberOfSections     =  self.homeModelArray.count
            self.numberOfCollectionItems = 0
            self.tableView.reloadData()
//            self.collectionViewHomeData.reloadData()
            print("count for all data without subcats:- \(self.homeModelArray.count)")
            
        })
    }
    
    
    private final func randomRowColors() -> [UIColor] {
        let colors: [UIColor] = (0 ... numberOfCollectionItems - 1).map({ _ -> UIColor in
            var randomRed: CGFloat = CGFloat(arc4random_uniform(256))
            let randomGreen: CGFloat = CGFloat(arc4random_uniform(256))
            let randomBlue: CGFloat = CGFloat(arc4random_uniform(256))

            if randomRed == 255.0 && randomGreen == 255.0 && randomBlue == 255.0 {
                randomRed = CGFloat(arc4random_uniform(128))
            }

            let color: UIColor

            if #available(iOS 10.0, *) {
                if traitCollection.displayGamut == .P3 {
                    color = UIColor(displayP3Red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
                } else {
                    color = UIColor(red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
                }
            } else {
                color = UIColor(red: randomRed / 255.0, green: randomGreen / 255.0, blue: randomBlue / 255.0, alpha: 1.0)
            }

            return color
        })

        return colors
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: <UITableView Data Source>

    override func numberOfSections(in _: UITableView) -> Int {
        return numberOfSections
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//        let catModel    =   self.homeModelArray[numberOfCollectionItems]
//        let subCat      =   catModel.subcategories
//        return subCat.count
        return numberOfCollectionsForRow
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell: GLCollectionTableViewCell? = tableView.dequeueReusableCell(withIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description) as? GLCollectionTableViewCell
//        let catModel    =   self.homeModelArray[indexPath.section]
//        let subCatModel =   catModel.subcategories[indexPath.row]
        if cell == nil {
            cell = GLCollectionTableViewCell(style: .default, reuseIdentifier: GLTableCollectionViewController.tableCellID + indexPath.section.description)

            // Configure the cell...
            cell?.selectionStyle = .none
            cell?.collectionViewPaginatedScroll = paginationEnabled
        }

        return cell!
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
//
//        let frame = tableView.frame
//
//        let button = UIButton(frame: CGRect(x: 5, y: 10, width: 20, height: 200))
//        button.tag = section
//        // the button is image - set image
//        // button.setImage(UIImage(named: "remove_button"), forState: UIControl.State.Normal)  // assumes there is an image named "remove_button"
//        //button.addTarget(self, action: #selector(TestController.remove(_:)), forControlEvents: .TouchUpInside)  // add selector called by clicking on the button
//
//        let headerView = UIView(frame: CGRect(x: 0,y: 0, width:frame.size.width, height: frame.size.height))  // create custom view
//        headerView.addSubview(button)   // add the button to the view
        
        
        let homeArray   =   self.homeModelArray[section]
        return homeArray.title
        
        
        
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let frame: CGRect = tableView.frame
        let DoneBut: UIButton = UIButton(frame: CGRect(x: 200, y: 0, width: 100, height: 20))
        
        DoneBut.setTitle("See All", for: .normal)
        DoneBut.backgroundColor = UIColor.black
     
        
        
        
        let homeArray   =   self.homeModelArray[section]
       // return homeArray.title
        
    
        DoneBut.addTarget(self, action:#selector(GLTableCollectionViewController.backAction(_sender:)), for: .touchUpInside)
        
        let headerView: UIView = UIView(frame: CGRect(x:0,y: 0,width: frame.size.height,height: frame.size.width))
        headerView.addSubview(DoneBut)
        
        
       
        
        
        let label1: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
            ] as [NSAttributedString.Key : Any]

        
        
        label1.attributedText = NSAttributedString(string: homeArray.title, attributes: strokeTextAttributes)
        
      
        label1.backgroundColor = UIColor.black
        
        headerView.addSubview(label1)
        
        
        
        return headerView
        
    }
  
    
  
    @objc public func backAction(_sender: UIButton) {
       Toast("see all").show(self)
        
    }
    
    
    
    
    //////here
//
//   func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let frame = tableView.frame
//
//        let button = UIButton(frame: CGRect(x: 5, y: 10, width: 220, height: 200))
//        button.tag = section
//        // the button is image - set image
//   // button.setImage(UIImage(named: "remove_button"), forState: UIControl.State.Normal)  // assumes there is an image named "remove_button"
//        //button.addTarget(self, action: #selector(TestController.remove(_:)), forControlEvents: .TouchUpInside)  // add selector called by clicking on the button
//
//    let headerView = UIView(frame: CGRect(x: 0,y: 0, width:frame.size.width, height: frame.size.height))  // create custom view
//        headerView.addSubview(button)   // add the button to the view
//
//        return headerView
//    }
//
//
    
    
    //here here here
    
    
    
    
    
    
    // MARK: <UITableView Delegate>

  
    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 50
    }

    override func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 0.0001
    }

    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell: GLCollectionTableViewCell = cell as? GLCollectionTableViewCell else {
            return
        }
    
        cell.setCollectionView(dataSource: self, delegate: self, indexPath: indexPath)
   
    }

   
    
    
    // MARK: <UICollectionView Data Source>

    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView : UICollectionView, numberOfItemsInSection _: Int) -> Int {
        let collection  =   collectionView as!   GLIndexedCollectionView
        
        let catModel    =   homeModelArray[collection.indexPath.section]
        let subCat      =   catModel.subcategories
        numberOfCollectionItems =    subCat.count
        return numberOfCollectionItems
    }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: GLIndexedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: GLIndexedCollectionViewCell.identifier, for: indexPath) as? GLIndexedCollectionViewCell else {
            fatalError("UICollectionViewCell must be of GLIndexedCollectionViewCell type")
        }

      
        guard let indexedCollectionView: GLIndexedCollectionView = collectionView as? GLIndexedCollectionView else {
            fatalError("UICollectionView must be of GLIndexedCollectionView type")
        }

        // Configure the cell...
        cell.backgroundColor = UIColor.black//colorsDict[indexedCollectionView.indexPath.section]?[indexPath.row]
        
        
        
        let collection  =   collectionView as!   GLIndexedCollectionView
        let section     =   collection.indexPath.section
        let catModel    =   homeModelArray[section]
        let subCatModel      =   catModel.subcategories[collection.indexPath.item]
        
        if section  ==  0
        
        {
            let cell1   =   collectionView.dequeueReusableCell(withReuseIdentifier: "CellImageOnly", for: indexPath) as! CollectionCellImageOnly
          
            print("=======images holi========",subCatModel.imageURL)
            cell1.imageView?.sd_setImage(with: URL(string: subCatModel.imageURL), completed: nil)
        
            return cell1
         
        }
        
        else
        {
            let cell2   =   collectionView.dequeueReusableCell(withReuseIdentifier: "CellImageAndText", for: indexPath) as! CollectionCellImageAndText
            cell2.imageView?.sd_setImage(with: URL(string: subCatModel.imageURL), completed: nil)
            cell2.labelTitle.text   =   subCatModel.title
            return cell2
        }
        

        return cell
    }

    // MARK: <UICollectionViewDelegate Flow Layout>

    let collectionTopInset: CGFloat = 0
    let collectionBottomInset: CGFloat = 0
    let collectionLeftInset: CGFloat = 10
    let collectionRightInset: CGFloat = 10

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: collectionTopInset, left: collectionLeftInset, bottom: collectionBottomInset, right: collectionRightInset)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let tableViewCellHeight: CGFloat = tableView.rowHeight
        let collectionItemWidth: CGFloat = 200//tableViewCellHeight - (collectionLeftInset + collectionRightInset)
        let collectionViewHeight: CGFloat = 200//collectionItemWidth

        return CGSize(width: collectionItemWidth, height: collectionViewHeight)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 10
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    // MARK: <UICollectionView Delegate>

    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
    }

    /*
     // MARK: <Navigation>

     // In a storyboard-based application, you will often want to do a little
     // preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
