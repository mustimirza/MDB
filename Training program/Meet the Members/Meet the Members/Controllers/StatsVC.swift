//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
    let dataExample: String
    var highScore: Int = 0
    var streak: [String] = []
    init(data: String) {
        self.dataExample = data
        // Delegate rest of the initialization to super class
        // designated initializer.
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //   init(highScore: Int, streak: [String]) {
  //      self.highScore = highScore
    //    self.streak = streak
//
   // }
    
    private let Statsheader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Game Stats:"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .medium)
        return label
    }()
    
    let labels: [UILabel] = {
        return (0..<3).map { index in
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 25, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tag = index
            return label
        }
    }()
    
    private let detailheader : UILabel = {
        let label = UILabel()
        label.text = "Recent Question's:"
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
        private let highscoreheader: UILabel = {
            let label = UILabel()
            label.backgroundColor = .gray
            label.textColor = .white
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 25, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        

    
    let returnbutton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue , for: .normal)
        button.setTitle("Go Back", for: .normal)
        button.backgroundColor = .cyan
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: >> Your Code Here <<
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(Statsheader)
        view.addSubview(returnbutton)
        view.addSubview(detailheader)
        view.addSubview(highscoreheader)
        for i in 0..<3 {
            view.addSubview(labels[i])
        }
        SettingConstraints()
        addingLabelText()
        returnbutton.addTarget(self, action: #selector(tapReturnHandler(_:sender:)), for: .touchUpInside)
        
        // MARK: >> Your Code Here <<
    }
    private func addingLabelText() {
        highscoreheader.text = "The Highest Score is: \(self.highScore)"
        for i in 0..<streak.count {
            labels[i].text = "\(i+1). \(streak[streak.count - 1 - i])"
        }
    }
    private func SettingConstraints() {
        Statsheader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive=true
        Statsheader.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -50).isActive=true
        Statsheader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive=true
        
        returnbutton.heightAnchor.constraint(equalToConstant: 50).isActive=true
        returnbutton.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -50).isActive=true
        returnbutton.widthAnchor.constraint(equalToConstant: 100).isActive=true
        returnbutton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive=true
        
        detailheader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive=true
        detailheader.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -50).isActive=true
        detailheader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive=true
        
        highscoreheader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive=true
        highscoreheader.trailingAnchor.constraint(equalTo:  view.trailingAnchor, constant: -200).isActive=true
        highscoreheader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive=true
        

        
        for i in 0..<3 {
            labels[i].heightAnchor.constraint(equalToConstant: 80).isActive=true
            labels[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75).isActive=true
            labels[i].trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
            labels[i].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25*i)).isActive=true
        }
        
    }
    @objc func tapReturnHandler(_ action: UIAction, sender: UIButton) {
        let vc = MainVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
