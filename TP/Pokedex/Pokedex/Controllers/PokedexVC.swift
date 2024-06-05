//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit
    let grasscolor = UIColor(red: 141/255, green: 242/255, blue: 111/255, alpha: 1.0)
    

        

    
class PokedexVC: UIViewController {
    var layout = 0
    var filter: Bool = false
    var pokemonFiltered: [Pokemon] = []
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()

    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.text = "Find your Pokemon!"
        search.layer.borderWidth = 3
        search.barStyle = .default
        search.barTintColor = .gray
        search.searchTextField.borderStyle = .roundedRect
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private let welcomeHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Pokedex"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //private var PokedexBackground: UIImageView = {
        //let image = UIImage(named: "PokedexImage")
        //let imageView = UIImageView(image: image)
        //imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        //imageView.contentMode = .scaleAspectFit
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        //return imageView
    //}()
    //private var welcomeToPokedex: UIButton = {
        //let button = UIButton()
        //button.setTitle("Welcome to the Pokédex", for: .normal)
        //button.setTitleColor(.black, for: .normal)
        //button.backgroundColor = UIColor.white
        //button.titleLabel?.adjustsFontSizeToFitWidth = true
        //button.layer.borderWidth=3
        //button.translatesAutoresizingMaskIntoConstraints = false
        //return button
    //}()
    
    private let rowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.isSpringLoaded = true
        button.setTitle("R", for: .normal)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.isSpringLoaded = true
        button.setTitle("G", for: .normal)
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.tag = 0
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchButton : UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Search Pokemon!", for: .normal)
        button.isSpringLoaded = true
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 3
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let FilterbytypeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Pokemon Type", for: .normal)
        button.isSpringLoaded = true
        button.backgroundColor = .white
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokedexCollectionCell.self, forCellWithReuseIdentifier: PokedexCollectionCell.reuseIdentifier)
        return collectionView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addingSubViews()
        //view.bringSubviewToFront(searchBar)
        settingConstraints()
        initCallbacks()
        setUpCollectionView()
    }
        
    func setUpCollectionView() {
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 275, left: 30, bottom: 30, right: 30))
        //collectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self //This assigns SFSCollection to be the dataSource in order for collectionView to be able to ask for items
        collectionView.delegate = self //Both data source and delegate are part of the delegate design, but just have different names
        
    }

    func initCallbacks() {
        searchButton.addTarget(self, action: #selector(searchCallback(_:)), for: .touchUpInside)
    }
        
        
        // Do any additional setup after loading the view.
    func addingSubViews() {
        view.addSubview(welcomeHeader)
        view.addSubview(collectionView)
        view.addSubview(searchButton)
        view.addSubview(rowButton)
        view.addSubview(gridButton)
        view.addSubview(FilterbytypeButton)
        view.addSubview(searchBar)
        //view.addSubview(PokedexBackground)
        //view.addSubview(welcomeToPokedex)
    }
        
    func settingConstraints() {
        //searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant:50).isActive=true
        //searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive=true
        //searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive=true
       //searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300 ).isActive=true
        welcomeHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        welcomeHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        welcomeHeader.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -25).isActive = true
        welcomeHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        searchBar.topAnchor.constraint(equalTo: welcomeHeader.bottomAnchor, constant: 25).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: welcomeHeader.bottomAnchor, constant: 75).isActive = true
    
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 50).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -50).isActive = true
        
        //PokedexBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 1).isActive=true
        //PokedexBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1).isActive=true
        //PokedexBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1).isActive=true
        //PokedexBackground.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1 ).isActive=true
        
        //welcomeToPokedex.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive=true
        //welcomeToPokedex.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive=true
        //welcomeToPokedex.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive=true
        //welcomeToPokedex.heightAnchor.constraint(equalToConstant: 75 ).isActive=true
        
        rowButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        rowButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: -30).isActive = true
        rowButton.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 5).isActive = true
        
        gridButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        gridButton.leadingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: -2).isActive = true
        gridButton.trailingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: 35).isActive = true
        
        FilterbytypeButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        FilterbytypeButton.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 10).isActive = true
        FilterbytypeButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 60).isActive = true
    }
    @objc func searchCallback (_ sender: UIButton) {
        filter = true
        pokemonFiltered = []
        for pok in PokemonGenerator.shared.getPokemonArray() {
            if pok.name.contains(searchBar.text!) == true {
                pokemonFiltered.append(pok)
            }
        }
        collectionView.reloadData()
    }
}
    extension PokedexVC: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if filter {
                return pokemonFiltered.count
            } else {
            return PokemonGenerator.shared.getPokemonArray().count
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
            if filter {
                symbol = pokemonFiltered[indexPath.item]
            }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCollectionCell.reuseIdentifier, for: indexPath) as! PokedexCollectionCell
            cell.onePokemon = symbol
            return cell
        }
    }


    extension PokedexVC: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 80) //
        }
        
        func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
            if filter {
                symbol = pokemonFiltered[indexPath.item]
            }
            return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
                return PokedexPreviewVC(symbol: symbol)
            }) { _ in
                let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
                return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
            if filter {
                symbol = pokemonFiltered[indexPath.item]
            }
            let vc = StatsVC(symbol: symbol)
            present(vc, animated: true, completion: nil)
        }
    }

