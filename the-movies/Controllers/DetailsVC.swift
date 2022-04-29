//
//  DetailsVC.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//

import UIKit

class DetailsVC: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultSize(view: view)
        setUp()
    }
    
    func setUp(){
        view.backgroundColor = .white
        
        let backButton = UIButton()
        backButton.setBackgroundImage(UIImage(named: "btn_back"), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0.05 * screenWidth, y: 0.087 * screenHeight, width: 0.052 * screenWidth, height: 0.052 * screenWidth)
        backButton.contentVerticalAlignment.self = .center
        backButton.contentHorizontalAlignment.self = .center
        backButton.addTarget(self, action: #selector(backClicked), for: .touchUpInside)
        view.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: 0.1 * screenWidth, y: 0.08 * screenHeight, width: 0.8 * screenWidth, height: 0.04 * screenHeight))
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.text = "Moonrise Kingdom (2021)"
        titleLabel.numberOfLines = 0
        titleLabel.font = font_DmSansBold(size: 20)
        view.addSubview(titleLabel)
        
        // MARK: - Add Scroll View
        scrollView.delegate = self
        scrollView.frame = CGRect(x:0 * screenWidth, y: 0.13 * screenHeight, width:1 * screenWidth, height: 0.87 * screenHeight)
        scrollView.isPagingEnabled = true
        scrollView.contentSize.height = 1000
        view.addSubview(scrollView)
        
        let movieImageView = UIImageView()
        movieImageView.image = UIImage(named: "Moonrise Kingdom")
        movieImageView.frame = CGRect(x:0 * screenWidth, y: 0 * screenHeight, width:1 * screenWidth, height: 0.34 * screenHeight)
        movieImageView.backgroundColor = .red
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
        rateLabel.text = "7.8/10"
        rateLabel.numberOfLines = 1
        rateLabel.font = font_DmSansBold(size: 14)
        scrollView.addSubview(rateLabel)
        
        let dateLabel = UILabel(frame: CGRect(x: 0.25 * screenWidth, y: 0.35 * screenHeight, width: 0.5 * screenWidth, height: 0.04 * screenHeight))
        dateLabel.textAlignment = .center
        dateLabel.textColor = .black
        dateLabel.text = "19/12/2222"
        dateLabel.numberOfLines = 1
        dateLabel.font = font_DmSansMedium(size: 15)
        scrollView.addSubview(dateLabel)
        
        let letterTitleLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.4085 * screenHeight, width: 0.97 * screenWidth, height: 0.03 * screenHeight))
        letterTitleLabel.textAlignment = .left
        letterTitleLabel.textColor = .black
        letterTitleLabel.text = "Moonrise Kingdom (2021)"
        letterTitleLabel.numberOfLines = 0
        letterTitleLabel.font = font_DmSansBold(size: 18)
        scrollView.addSubview(letterTitleLabel)
        
        let letterDescriptionLabel = UILabel(frame: CGRect(x: 0.03 * screenWidth, y: 0.4045 * screenHeight, width: 0.96 * screenWidth, height: 0.52 * screenHeight))
        letterDescriptionLabel.textAlignment = .left
        letterDescriptionLabel.textColor = .black
        letterDescriptionLabel.text = "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum"
        letterDescriptionLabel.numberOfLines = 0
        letterDescriptionLabel.font = font_DmSansMedium(size: 15)
        scrollView.addSubview(letterDescriptionLabel)
        
    }
    
    @objc func backClicked(){
        dismiss(animated: true)
        print("back")
    }
    
}
