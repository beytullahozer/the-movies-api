//
//  DetailsVC.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let movieImageView = UIImageView()
    
    var selected: Result?
    var dataList = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        setUp()
        fetchImage()
    }

    
    func setUp(){
        view.backgroundColor = .white
        
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "btn_back"), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0.037 * screenWidth, y: 0.089 * screenHeight, width: 0.045 * screenWidth, height: 0.045 * screenWidth)
        backButton.contentVerticalAlignment.self = .center
        backButton.contentHorizontalAlignment.self = .center
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: 0.2 * screenWidth, y: 0.069 * screenHeight, width: 0.6 * screenWidth, height: 0.06 * screenHeight))
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .black
        titleLabel.text = selected?.title ?? "No fetch data."
        titleLabel.numberOfLines = 0
        titleLabel.font = font_DmSansBold(size: 17)
        view.addSubview(titleLabel)
        
        // MARK: - Add Scroll View
        scrollView.delegate = self
        scrollView.frame = CGRect(x:0 * screenWidth, y: 0.13 * screenHeight, width:1 * screenWidth, height: 0.87 * screenHeight)
        scrollView.isPagingEnabled = true
        scrollView.contentSize.height = 1000
        view.addSubview(scrollView)
        
        movieImageView.image = UIImage()
        movieImageView.frame = CGRect(x: 0 * screenWidth, y: 0 * screenHeight, width: 1 * screenWidth, height: 0.34 * screenHeight)
        scrollView.addSubview(movieImageView)
        
        let imdbImageView = UIImageView()
        var showimage = UIImage()
        
        imdbImageView.image = showimage
        imdbImageView.frame = CGRect(x:0.03 * screenWidth, y: 0.35 * screenHeight, width: 0.13 * screenWidth, height: 0.037 * screenHeight)
        scrollView.addSubview(imdbImageView)
        
        let rateImageView = UIImageView()
        rateImageView.image = UIImage(named: "Rate Icon")
        rateImageView.frame = CGRect(x:0.193 * screenWidth, y: 0.356 * screenHeight, width: 0.05 * screenWidth, height: 0.05 * screenWidth)
        scrollView.addSubview(rateImageView)
        
        let rateLabel = UILabel(frame: CGRect(x: 0.264 * screenWidth, y: 0.35 * screenHeight, width: 0.4 * screenWidth, height: 0.04 * screenHeight))
        rateLabel.textAlignment = .left
        rateLabel.textColor = .black
        rateLabel.text = String(selected?.voteAverage ?? 10); "/10"
        rateLabel.numberOfLines = 1
        rateLabel.font = font_DmSansBold(size: 14)
        scrollView.addSubview(rateLabel)
        
        let dateLabel = UILabel(frame: CGRect(x: 0.25 * screenWidth, y: 0.35 * screenHeight, width: 0.5 * screenWidth, height: 0.04 * screenHeight))
        dateLabel.textAlignment = .center
        dateLabel.textColor = .black
        dateLabel.text = selected?.releaseDate ?? "No fetch data."
        dateLabel.numberOfLines = 1
        dateLabel.font = font_DmSansMedium(size: 15)
        scrollView.addSubview(dateLabel)
        
        let letterTitleLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.4085 * screenHeight, width: 0.97 * screenWidth, height: 0.03 * screenHeight))
        letterTitleLabel.textAlignment = .left
        letterTitleLabel.textColor = .black
        letterTitleLabel.text = selected?.originalTitle ?? "No fetch data."
        letterTitleLabel.numberOfLines = 1
        letterTitleLabel.font = font_DmSansBold(size: 18)
        scrollView.addSubview(letterTitleLabel)
        
        let letterDescriptionLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.47 * screenHeight, width: 0.94 * screenWidth, height: 0.53 * screenHeight))
        letterDescriptionLabel.textAlignment = .justified
        letterDescriptionLabel.textColor = .black
        letterDescriptionLabel.text = selected?.overview ?? "No fetch data."
        letterDescriptionLabel.numberOfLines = 0
        letterDescriptionLabel.sizeToFit()
        letterDescriptionLabel.font = font_DmSansMedium(size: 15)
        scrollView.addSubview(letterDescriptionLabel)
        
    }
    
    func fetchImage(){
        
        let urlString = "https://image.tmdb.org/t/p/w500/\(selected?.posterPath)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { data, _, error in
            
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
                    
                        
                        let data = try? Data(contentsOf: url)
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                self.movieImageView.image = image
                            }else {
                                self.movieImageView.image = UIImage(named: "SomeEmptyImage")
                                
                            }
                    }
                    
                } else {
                    print("URLSession dataTask error:", error ?? "nil")
                }
                
            }catch{
                print("JSONSerialization error:", error)
            }
        }
        
        task.resume()
    
    }
    
    
    @objc func backClicked(){
        dismiss(animated: true)
        print("back")
    }
    
}
