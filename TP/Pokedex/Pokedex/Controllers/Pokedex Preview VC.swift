//
//  Pokedex Preview VC.swift
//  Pokedex
//
//  Created by Mustafa Mirza on 19/3/22.
//

import Foundation
import UIKit

class PokedexPreviewVC: UIViewController {
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        view.addSubview(imageView)
        let width = 400
        let height = 400
        preferredContentSize = CGSize(width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 100, right: 70))
    }
    init(symbol: Pokemon) {
        super.init(nibName: nil, bundle: nil)
        
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .gray
        if let imageData = try? Data(contentsOf: symbol.imageUrl!) {
            if let currentImage = UIImage(data: imageData) {
                imageView.image = currentImage
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) isn't implemented")
    }
    
}

