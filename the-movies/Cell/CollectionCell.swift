//
//  CollectionCell.swift
//  the-movies
//
//  Created by Beytullah Özer on 4.05.2022.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    static var collectionCell = "cell"
    
    var movieWebImageView = UIImageView()
    var titleLabel = UILabel()
    var desLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultSize(view: contentView)
        
        addSubview()
        configureLabels()
        configureImageViews()
        setConstraits()
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addSubview(){
        contentView.addSubview(movieWebImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(desLabel)
        
    }
    
    func configureImageViews(){
        movieWebImageView.clipsToBounds = true
        movieWebImageView.contentMode = .scaleAspectFill
        movieWebImageView.alpha = 0.7
    
    }
    
    func configureLabels(){ // Label özellikleri oluşturuldu.
        titleLabel.numberOfLines = 1
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = font_DmSansBold(size: 67)
        
        desLabel.numberOfLines = 2
        desLabel.text = ""
        desLabel.textColor = .white
        desLabel.textAlignment = .left
        desLabel.font = font_DmSansMedium(size: 50)
        
    }
    
    func setConstraits(){
        
        movieWebImageView.frame = CGRect(x: 0 * screenWidth, y: -0.076 * screenHeight, width: 1 * screenWidth, height: 1.1 * screenHeight)
        titleLabel.frame = CGRect(x: 0.033 * screenWidth, y: 0.5 * screenHeight, width: 0.96 * screenWidth, height: 0.2 * screenHeight)
        desLabel.frame = CGRect(x: 0.033 * screenWidth, y: 0.65 * screenHeight, width: 0.96 * screenWidth, height: 0.28 * screenHeight)
        
    }
    
    func fetchDataToCollectionCell(data:Result){
        
        titleLabel.text = data.originalTitle
        desLabel.text = data.overview
        
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w500/\(data.posterPath)")!)){
            (data,req,error) in
            
            do{
                var datas = try data
                DispatchQueue.main.async {
                    self.movieWebImageView.image = UIImage(data: datas!)
                    self.movieWebImageView.clipsToBounds = true
                    self.movieWebImageView.contentMode = .scaleAspectFill
                    self.movieWebImageView
                }
            }catch{
                print("catch is working")
            }
        }
        .resume()
    }
    
    
    
    
}

