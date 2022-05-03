//
//  TableCell.swift
//  the-movies
//
//  Created by Beytullah Özer on 28.04.2022.
//

import UIKit

class TableCell: UITableViewCell {
    
    static var cell = "cell"
    
    var movieImageView = UIImageView()
    var nextImage = UIImageView()
    var labelName = UILabel()
    var labelDes = UILabel()
    var labelDate = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setDefaultSize(view: contentView)
        addSubview()
        configureImageViews()
        configureLabels()
        setConstraits()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) { // Override init ile birlikte required init, program çökmesine karşı otomatik oluşturuldu.
        fatalError("init(coder:) fatal error has not been implemented")
    }
    
    func addSubview(){
        contentView.addSubview(movieImageView)
        contentView.addSubview(nextImage)
        contentView.addSubview(labelName)
        contentView.addSubview(labelDes)
        contentView.addSubview(labelDate)
    }
    
    func configureImageViews(){ // ImageView özellikleri configure metodunda oluşturuldu.
        movieImageView.layer.cornerRadius = 14
        movieImageView.clipsToBounds = true
        movieImageView.image = UIImage(named: "American Beauty")
        movieImageView.contentMode = .scaleAspectFit
    
        nextImage.image = UIImage(named: "Arrow Icon")
    }
    
    func configureLabels(){ // Label özellikleri oluşturuldu.
        labelName.numberOfLines = 0
        //labelName.adjustsFontSizeToFitWidth = true
        labelName.text = "Moonrise Kingdom (2001)"
        labelName.textColor = .black
        labelName.textAlignment = .left
        labelName.font = font_DmSansBold(size: 350)
        
        labelDes.numberOfLines = 2
        //labelDes.adjustsFontSizeToFitWidth = true
        labelDes.text = "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description "
        labelDes.textColor = .darkGray
        labelDes.textAlignment = .justified
        //        labelDes.backgroundColor = .red
        labelDes.font = font_DmSansMedium(size: 260)
        
        labelDate.numberOfLines = 0
        //labelDate.adjustsFontSizeToFitWidth = true
        labelDate.text = "02/03/2022"
        labelDate.textColor = .gray
        labelDate.textAlignment = .right
        labelDate.font = font_DmSansMedium(size: 260)
    }
    
    func setConstraits(){
        
        movieImageView.frame = CGRect(x: 0.04 * screenWidth, y: 0.25 * screenHeight, width: 0.36 * screenWidth, height: 0.36 * screenWidth)
        nextImage.frame = CGRect(x: 1.24 * screenWidth, y: 1.48 * screenHeight, width: 0.05 * screenWidth, height: 0.05 * screenWidth)
        labelName.frame = CGRect(x: 0.45 * screenWidth, y: 0.29 * screenHeight, width: 0.73 * screenWidth, height: 0.78 * screenHeight)
        labelDes.frame = CGRect(x: 0.45 * screenWidth, y: 1.1 * screenHeight, width: 0.73 * screenWidth, height: 1.16 * screenHeight)
        labelDate.frame = CGRect(x: 0.83 * screenWidth, y: 2.5 * screenHeight, width: 0.35 * screenWidth, height: 0.6 * screenHeight)
        
    }
    
    func onBind(data:Result){
        
        labelName.text = data.title
        labelDes.text = data.overview
        labelDate.text = data.releaseDate
        
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://image.tmdb.org/t/p/w342/\(data.posterPath)")!)){
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
