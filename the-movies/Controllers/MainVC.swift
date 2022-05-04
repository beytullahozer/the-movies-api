//
//  ViewController.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//


import UIKit

class MainVC: UIViewController{
    
    let pageControl: UIPageControl = .init()
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var contentWidth : CGFloat = 0.0
    
    var dataList = [Result]()
    var imageWebList:[String] = []
    
    var selected: Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        
        setUp()
        configurePageControl()
        fetchNowPlayingMovieData()
        fetchUpComingMovieData()
        
    }
    
    
    
    func configurePageControl() {
        
        collectionView.frame = CGRect(x: 0 * screenWidth, y: 0 * screenHeight, width: 1 * screenWidth, height: 0.36 * screenHeight)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.collectionCell)
        
        collectionView.reloadData()
        view.addSubview(collectionView)
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            flowLayout.collectionView?.bouncesZoom = true
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionView.setCollectionViewLayout(flowLayout, animated: true)
            collectionView.reloadData()
        }
        
        
        var frame = self.view.bounds
        frame.origin.y = -frame.size.height
        let grayView = UIView(frame: frame)
        grayView.backgroundColor = .gray
        grayView.alpha = 0.9
        collectionView.addSubview(grayView)
        
        
        pageControl.frame = CGRect(x: 0 * screenWidth, y: 0.32 * screenHeight, width: 1 * screenWidth, height: 0.032 * screenHeight)
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
    }
    
    func setUp() {
        view.backgroundColor = .white
        
        let subView = UIView(frame: frame)
        subView.backgroundColor = .clear
        collectionView.addSubview(subView)
        
        
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        
        
        tableView.frame = CGRect(x: 0 * screenWidth, y: 0.36 * screenHeight, width: 1 * screenWidth, height: 0.64 * screenHeight)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.rowHeight = 140
        tableView.register(TableCell.self, forCellReuseIdentifier: TableCell.cell)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
        view.addSubview(tableView)
        
        UIView.animate(withDuration: 0.2) { [self] in
            self.tableView.setContentOffset(.init(x: view.frame.size.width, y: tableView.frame.maxY + 70), animated: false)
            
        }
    }
    
    func fetchUpComingMovieData() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=2a31a20cac3ff1a2105d8a8dc224479d&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("Error with fetching: \(error)")
                return
            }
            
            do{
                if let data = data {
                    
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        print("results are here \(result.results)")
                        self.dataList = result.results
                        self.tableView.reloadData()
                    }
                }
                
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error.localizedDescription)
            }
        }
        
        task.resume()
        self.tableView.reloadData()
    }
    
    func fetchNowPlayingMovieData() {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=2a31a20cac3ff1a2105d8a8dc224479d&language=en-US&page=1") else {
            fatalError("Invalid URL")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print("Error with fetching: \(error)")
                return
            }
            
            do{
                if let data = data {
                    
                    let result = try JSONDecoder().decode(Movies.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        print("results are here \(result.results)")
                        self.dataList = result.results
                        self.collectionView.reloadData()
                        
                    }
                }
                
            }catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error.localizedDescription)
            }
        }
        
        task.resume()
        self.collectionView.reloadData()
    }
    
    
    @objc func changePage(sender: AnyObject) {
        let x = CGFloat(pageControl.currentPage) * collectionView.frame.size.width
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
}



extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell, for: indexPath) as! TableCell
        cell.fetchDataToTableCell(data: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selected = dataList[indexPath.row]
        
        print("Movie \(indexPath.row) Clicked.")
        let destination = DetailsVC()
        destination.selected = selected
        presentVC(currentVC: self, destinationVC: destination, toDirection: .right)
    }
}



extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.collectionCell, for: indexPath) as! CollectionCell
        
        cell.titleLabel.text = "Cell \(indexPath.row)"
        cell.desLabel.text = "Cell \(indexPath.row)"
        cell.fetchDataToCollectionCell(data: dataList[indexPath.row])
        
        let pageNumber = round(collectionView.contentOffset.x / collectionView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    
}
