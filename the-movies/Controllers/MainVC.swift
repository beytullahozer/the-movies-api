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
    var dataList = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        setUp()
        configurePageControl()
        upComingGetApi()
    }
    
    func configurePageControl() {
        
        view.backgroundColor = .white
        
        scrollView.frame = CGRect(x:0 * screenWidth, y: 0 * screenHeight, width:1 * screenWidth, height: 0.36 * screenHeight)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        view.addSubview(scrollView)
        
        pageControl.frame = CGRect(x:0 * screenWidth, y: 0.32 * screenHeight, width:1 * screenWidth, height: 0.03 * screenHeight)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
    }
    
    func setUp(){
        
        for index in 0..<5 {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
        
        
        let subView = UIView(frame: frame)
        subView.backgroundColor = .clear
        scrollView.addSubview(subView)
 
        
        let backgroundImageView = UIImageView()
        backgroundImageView.frame = CGRect(x:0 * screenWidth, y: 0 * screenHeight, width:1 * screenWidth, height: 0.36 * screenHeight)
        backgroundImageView.image = UIImage(named: "Moonrise Kingdom")
        subView.addSubview(backgroundImageView)
        
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
        subTitle.numberOfLines = 2
        subTitle.textColor = .lightGray
        subTitle.font = font_DmSansRegular(size: 20)
        subView.addSubview(subTitle)
        
        let label2 = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.2 * screenHeight, width: 0.9 * 1.5 * screenWidth, height: 0.1 * screenHeight))
        label2.text = ""
        label2.textAlignment = .left
        label2.numberOfLines = 1
        label2.textColor = .white
        label2.font = font_DmSansMedium(size: 16)
        scrollView.addSubview(label2)
        
        let subTitle2 = UILabel(frame: CGRect(x: 0.05 * screenWidth, y: 0.24 * screenHeight, width: 0.9 * 1.5 * screenWidth, height: 0.1 * screenHeight))
        subTitle2.text = ""
        subTitle2.textAlignment = .left
        subTitle2.numberOfLines = 2
        subTitle2.textColor = .lightGray
        subTitle2.font = font_DmSansRegular(size: 14)
        scrollView.addSubview(subTitle2)
        
        
        scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 5,height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0 * screenWidth, y: 0.36 * screenHeight, width: 1 * screenWidth, height: 0.64 * screenHeight)
        tableView.backgroundColor = .white
        tableView.rowHeight = 140
        tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
        view.addSubview(tableView)
            
            UIView.animate(withDuration: 0.2) { [self] in
                self.tableView.setContentOffset(.init(x: view.frame.size.width, y: tableView.frame.maxY + 70), animated: false)
                backgroundImageView.alpha = 1
            }
            
        }
            
    }
    
    func upComingGetApi(){
        
//        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "http://api.themoviedb.org/3/movie/upcoming?api_key=2a31a20cac3ff1a2105d8a8dc224479d&language=en-US&page=1")!)){
//            (data,response,error) in
//
//            do{
//                let result = try! JSONDecoder().decode(MoviesUpcoming.self, from: data!)
//
//                DispatchQueue.main.async {
//                    print("results are here \(result.results)")
//                    self.dataList = result.results
//                    self.tableView.reloadData()
//                }
//
//            }catch{
//                print("catch working")
//            }
//
//        }.resume()
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
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell, for: indexPath) as! TableCell
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        cell.onBind(data: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Movie \(indexPath.row) Clicked.")
        presentVC(currentVC: self, destinationVC: DetailsVC(), toDirection: .right)
    }
    
    

    
}


