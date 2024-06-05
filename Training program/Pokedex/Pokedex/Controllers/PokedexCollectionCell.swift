//
//  PokedexCollectionCell.swift
//  Pokedex
//
//  Created by Mustafa Mirza on 11/3/22.
//
import Foundation
import UIKit

class PokedexCollectionCell: UICollectionViewCell {
    
    
    static let reuseIdentifier: String = String(describing: PokedexCollectionCell.self)
    
    
    
    var onePokemon: Pokemon? {
        didSet {
            //if PokedexVC. == 0 {
                if let url = onePokemon?.imageUrl {
                    let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    })
                    task.resume()
                } else {
                    self.imageView.image = #imageLiteral(resourceName: "pokeball")
            }
            
            //}
            titleView.text = onePokemon?.name
            IDView.text = String(describing: onePokemon!.id)
            
        }
    }
    
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let IDView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        contentView.layer.borderColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(IDView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
