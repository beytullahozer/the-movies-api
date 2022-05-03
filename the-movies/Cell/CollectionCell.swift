//
//  CollectionCell.swift
//  the-movies
//
//  Created by Beytullah Özer on 4.05.2022.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    static var collectionCell = "collectionCell"
    
    var movieImageView = UIImageView()
    var titleLabel = UILabel()
    var desLabel = UILabel()

    
    func addSubview(){
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desLabel)
    }
    
    func configureImageViews(){
        movieImageView.clipsToBounds = true
        movieImageView.image = UIImage(named: "American Beauty")
        movieImageView.contentMode = .scaleAspectFit
    
       
    }
    
    func configureLabels(){ // Label özellikleri oluşturuldu.
        titleLabel.numberOfLines = 0
        titleLabel.text = "Moonrise Kingdom (2001)"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = font_DmSansBold(size: 350)
        
        desLabel.numberOfLines = 2
        desLabel.text = "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description "
        desLabel.textColor = .darkGray
        desLabel.textAlignment = .left
        desLabel.font = font_DmSansMedium(size: 260)
        
    }
    
    func setConstraits(){
        
        movieImageView.frame = CGRect(x: 0.04 * screenWidth, y: 0.25 * screenHeight, width: 0.36 * screenWidth, height: 0.36 * screenWidth)
        titleLabel.frame = CGRect(x: 0.05 * screenWidth, y: 0.16 * screenHeight, width: 0.9 * screenWidth, height: 0.1 * screenHeight)
        titleLabel.backgroundColor = .blue
        desLabel.frame = CGRect(x: 0.05 * screenWidth, y: 0.22 * screenHeight, width: 0.9 * screenWidth, height: 0.1 * screenHeight)
        
    }
    
    func onBindCollection(data:Result){
        
        titleLabel.text = data.originalTitle
        desLabel.text = data.overview
        
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "image.tmdb.org/t/p/w500/\(data.posterPath)")!)){
            (data,req,error) in
            
            do{
                var datas = try data
                DispatchQueue.main.async {
                    self.movieImageView.image = UIImage(data: datas!)
                    self.movieImageView.layer.cornerRadius = 14
                    self.movieImageView.clipsToBounds = true
                    self.movieImageView.contentMode = .scaleAspectFill
                }
            }catch{
                print("catch is working")
            }
        }
        .resume()
    }
    
    
    
    
}

