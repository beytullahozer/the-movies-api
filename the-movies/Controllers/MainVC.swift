//
//  ViewController.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//


import UIKit

class MainVC: UIViewController{
    
    var pageControl: UIPageControl = .init()
    let scrollView = UIScrollView()
    let tableView = UITableView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    
    var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var contentWidth : CGFloat = 0.0
    var dataList = [Result]()
    var selectedUpcoming: Result?
    
    let imagelist = ["Moonrise Kingdom", "There Will Be Blood", "Moonrise Kingdom", "There Will Be Blood", "Moonrise Kingdom"]
    let labelList = ["label_1", "label_2", "label_3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        setUp()
        configurePageControl()
        fetchUpComingMovieData()
        fetchNowPlayingMovieData()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            collectionView.setCollectionViewLayout(flowLayout, animated: true)
        }
    }
    

    
    func configurePageControl() {
        view.backgroundColor = .white
        
        collectionView.frame = CGRect(x: 0 * screenWidth, y: 0 * screenHeight, width: 1 * screenWidth, height: 0.36 * screenHeight)
        collectionView.delegate = self
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.collectionCell)

        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        
        pageControl.frame = CGRect(x: 0 * screenWidth, y: 0.32 * screenHeight, width: 1 * screenWidth, height: 0.03 * screenHeight)
        pageControl.numberOfPages = imagelist.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
    }
    
    func setUp() {
        
        let subView = UIView(frame: frame)
        subView.backgroundColor = .clear
        collectionView.addSubview(subView)
        
//        for image in 0..<5{

//        for image in stride(from: 0, to: imagelist.count, by: 1) {
//            var frame = CGRect.zero
//            frame.origin.x = self.scrollView.frame.size.width * CGFloat(image)
//            frame.origin.y = -100
//            frame.size = self.scrollView.frame.size
//            self.scrollView.isPagingEnabled = true
//
//            let imageToDisplay:UIImage = UIImage(named: imagelist[image])!
//            let imageView:UIImageView = UIImageView()
//            imageView.image = imageToDisplay
//            imageView.contentMode = .scaleAspectFit
//            imageView.frame = CGRect(x:view.frame.minX, y: 0 * screenHeight, width: view.frame.width-60, height: 0.36 * screenHeight)
//            subView.addSubview(imageView)
//
//            let xCord = view.frame.midX + view.frame.width * CGFloat(image)
//            contentWidth += view.frame.width
//        }
 
//        scrollView.frame = CGRect(x: 0 * screenWidth, y: 0 * screenHeight, width: 1 * screenWidth, height: 0.36 * screenHeight)
//        scrollView.delegate = self
//        scrollView.isPagingEnabled = true
//        scrollView.isScrollEnabled = true
//        view.addSubview(scrollView)
//        scrollView.contentSize = CGSize(width:contentWidth, height: self.scrollView.frame.size.height)
//        scrollView.addSubview(subView)
        
         
        
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0 * screenWidth, y: 0.36 * screenHeight, width: 1 * screenWidth, height: 0.64 * screenHeight)
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
    }
    
    @objc func changePage(sender: AnyObject) {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    
    
}




extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell, for: indexPath) as! TableCell
        cell.onBind(data: dataList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedUpcoming = dataList[indexPath.row]
        print("Movie \(indexPath.row) Clicked.")
        let destination = DetailsVC()
        destination.selected = selectedUpcoming
        presentVC(currentVC: self, destinationVC: destination, toDirection: .right)
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.collectionCell, for: indexPath) as! CollectionCell
        cell.onBindCollection(data: dataList[indexPath.row])
        cell.titleLabel.text = "selectedUpcoming?.title"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentVC(currentVC: self, destinationVC: DetailsVC(), toDirection: .right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:contentWidth, height: self.collectionView.frame.size.height)
    }
   
    
}


extension MainVC: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
