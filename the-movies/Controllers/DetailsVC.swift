//
//  DetailsVC.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//


// https://api.themoviedb.org/3/movie/:movie_id?api_key=2a31a20cac3ff1a2105d8a8dc224479d&language=en-US&page=1


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
        fetchDataMovieImage()
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
        scrollView.contentSize.height = 900
        view.addSubview(scrollView)
        
        movieImageView.image = UIImage()
        movieImageView.frame = CGRect(x: 0 * screenWidth, y: 0 * screenHeight, width: 1 * screenWidth, height: 0.34 * screenHeight)
        scrollView.addSubview(movieImageView)
        
        let imdbImageView = UIImageView()
        imdbImageView.image = UIImage(named: "IMDB Logo")
        imdbImageView.frame = CGRect(x:0.03 * screenWidth, y: 0.35 * screenHeight, width: 0.13 * screenWidth, height: 0.037 * screenHeight)
        scrollView.addSubview(imdbImageView)
        
        let rateImageView = UIImageView()
        rateImageView.image = UIImage(named: "Rate Icon")
        rateImageView.frame = CGRect(x:0.193 * screenWidth, y: 0.356 * screenHeight, width: 0.05 * screenWidth, height: 0.05 * screenWidth)
        scrollView.addSubview(rateImageView)
        
        let rateLabel = UILabel(frame: CGRect(x: 0.264 * screenWidth, y: 0.35 * screenHeight, width: 0.4 * screenWidth, height: 0.04 * screenHeight))
        rateLabel.textAlignment = .left
        rateLabel.textColor = .black
        rateLabel.text = String(selected?.voteAverage ?? 10.0) + String(" / 10")
        rateLabel.numberOfLines = 1
        rateLabel.font = font_DmSansMedium(size: 14)
        scrollView.addSubview(rateLabel)
        
        let dateLabel = UILabel(frame: CGRect(x: 0.28 * screenWidth, y: 0.35 * screenHeight, width: 0.5 * screenWidth, height: 0.04 * screenHeight))
        dateLabel.textAlignment = .center
        dateLabel.textColor = .black
        dateLabel.text = selected?.releaseDate ?? "No fetch data."
        dateLabel.numberOfLines = 1
        dateLabel.font = font_DmSansMedium(size: 14)
        scrollView.addSubview(dateLabel)
        
        let letterTitleLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.4085 * screenHeight, width: 0.97 * screenWidth, height: 0.03 * screenHeight))
        letterTitleLabel.textAlignment = .left
        letterTitleLabel.textColor = .black
        letterTitleLabel.text = selected?.originalTitle ?? "No fetch data."
        letterTitleLabel.numberOfLines = 1
        letterTitleLabel.font = font_DmSansBold(size: 18)
        letterTitleLabel.sizeToFit()
        scrollView.addSubview(letterTitleLabel)
        
        let letterDescriptionLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.45 * screenHeight, width: 0.94 * screenWidth, height: 0.55 * screenHeight))
        letterDescriptionLabel.textAlignment = .justified
        letterDescriptionLabel.textColor = .black
        letterDescriptionLabel.text = selected?.overview ?? "No fetch data."
        letterDescriptionLabel.numberOfLines = 0
        letterDescriptionLabel.font = font_DmSansRegular(size: 15)
        letterDescriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        letterDescriptionLabel.sizeToFit()
        scrollView.addSubview(letterDescriptionLabel)
        
    }
    
    
    func fetchDataMovieImage(){
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500/\(selected!.posterPath)")!)){
            (data,req,error) in
            
            do{
                var datas = try data
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: datas!)
                    self.movieImageView.clipsToBounds = true
                    self.movieImageView.contentMode = .scaleAspectFill
                }
            }catch{
                print("catch is working")
            }
        }
        .resume()
    }
    
    
    
    
    
    @objc func backClicked(){
        dismiss(animated: true)
        print("back")
    }
    
}
