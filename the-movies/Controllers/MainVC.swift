//
//  ViewController.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//

import UIKit

class MainVC: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var pageControl : UIPageControl = UIPageControl()
    let scrollView = UIScrollView()
    let tableView = UITableView()
    
    var pages:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.gray]
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    
    var films: [TableCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultSize(view: view)
        setUp()
        configurePageControl()
        
    }
    
    func configurePageControl() {
        view.backgroundColor = .white
        
        scrollView.frame = CGRect(x:0 * screenWidth, y: 0 * screenHeight, width:1 * screenWidth, height: 0.34 * screenHeight)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        
        pageControl.frame = CGRect(x:0 * screenWidth, y: 0.34 * screenHeight, width:1 * screenWidth, height: 0.03 * screenHeight)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
    }
    
    func setUp(){
        
        for index in 0..<5 {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
        }
        
        let subView = UIView(frame: frame)
        subView.backgroundColor = .clear
        scrollView.addSubview(subView)
        scrollView.backgroundColor = .gray
        
        let BackgroundImageView = UIImageView()
        BackgroundImageView.frame = CGRect(x:0 * screenWidth, y: 0 * screenHeight, width:1 * screenWidth, height: 0.34 * screenHeight)
        BackgroundImageView.image = UIImage(named: "Moonrise Kingdom")
        subView.addSubview(BackgroundImageView)
        
        let label = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.16 * screenHeight, width: 0.9 * screenWidth, height: 0.1 * screenHeight))
        label.text = "Moonrise Kingdom (2001)"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.font = font_DmSansMedium(size: 22)
        subView.addSubview(label)
        
        let subTitle = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.22 * screenHeight, width: 0.9 * screenWidth, height: 0.1 * screenHeight))
        subTitle.text = "123"
        subTitle.textAlignment = .left
        label.numberOfLines = 2
        subTitle.textColor = .lightGray
        subTitle.font = font_DmSansRegular(size: 20)
        subView.addSubview(subTitle)
        
        let label2 = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.2 * screenHeight, width: 0.9 * 1.5 * screenWidth, height: 0.1 * screenHeight))
        label2.text = ""
        label2.textAlignment = .left
        label.numberOfLines = 1
        label2.textColor = .white
        label2.font = font_DmSansMedium(size: 16)
        scrollView.addSubview(label2)
        
        let subTitle2 = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.24 * screenHeight, width: 0.9 * 1.5 * screenWidth, height: 0.1 * screenHeight))
        subTitle2.text = ""
        subTitle2.textAlignment = .left
        label.numberOfLines = 2
        subTitle2.textColor = .lightGray
        subTitle2.font = font_DmSansRegular(size: 14)
        scrollView.addSubview(subTitle2)
        
        
        scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 5,height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0 * screenWidth, y: 0.37 * screenHeight, width: 1 * screenWidth, height: 0.63 * screenHeight)
        tableView.backgroundColor = .white
        tableView.rowHeight = 140
        tableView.reloadData()
        tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        view.addSubview(tableView)
        
        
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    //MARK: - Add Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell, for: indexPath)
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Movie \(indexPath.row) Clicked.")
        presentVC(currentVC: self, destinationVC: DetailsVC(), toDirection: .right)
    }
    
    
    
    
    //    func createSlides() -> [Slide] {
    //        slideImage1.image = UIImage(named: "ic_onboarding_1")
    //
    //        slideLabel1.text = "A real-life bear"
    //

    //        slideDescLabel1.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    //
    //
    //        slideImage2.image = UIImage(named: "ic_onboarding_2")
    //
    //
    //        slideLabel2.text = "A real-life bear"
    //
    //        slideDescLabel2.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    //
    //        slideImage3.image = UIImage(named: "ic_onboarding_3")
    //
    //        slideLabel3.text = "A real-life bear"
    //
    //        slideDescLabel3.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    //
    //        slideImage4.image = UIImage(named: "ic_onboarding_4")
    //
    //
    //        slideLabel4.text = "A real-life bear"
    //        slideDescLabel4.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    //
    //        slideImage5.image = UIImage(named: "ic_onboarding_5")
    //        slideLabel5.text = "A real-life bear"
    //        slideDescLabel5.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
    //        slideLabel1, slideLabel2, slideLabel3, slideLabel4, slideLabel5, slideDescLabel1, slideDescLabel2, slideDescLabel3, slideDescLabel4, slideDescLabel5
    
    //        return [slideLabel5]
    //    }
    
}


