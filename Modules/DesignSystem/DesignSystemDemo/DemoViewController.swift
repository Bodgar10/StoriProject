//
//  DemoViewControllee.swift
//  DesignSystemDemo
//
//  Created by Bodgar Espinosa Miranda on 16/12/24.
//

import Foundation
import UIKit

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "DSMDemo"
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = "The DSM (Design System Manager) is a crucial tool for ensuring visual and interaction consistency in a mobile project. Its components are pre-built user interface elements"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        
        let subDescriptionLabel = UILabel()
        subDescriptionLabel.text = "They are crafted for reuse across the application, guaranteeing uniform design and functionality on every screen."
        subDescriptionLabel.textColor = .gray
        subDescriptionLabel.numberOfLines = 0
        subDescriptionLabel.textAlignment = .center
        
        let componentsButton = UIButton(type: .system)
        componentsButton.setTitle("01 - Components", for: .normal)
        componentsButton.addTarget(self, action: #selector(showComponents), for: .touchUpInside)
        
        let styleGuideButton = UIButton(type: .system)
        styleGuideButton.setTitle("02 - Style Guide", for: .normal)
        styleGuideButton.addTarget(self, action: #selector(showStyleGuide), for: .touchUpInside)
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(subDescriptionLabel)
        stackView.addArrangedSubview(componentsButton)
        stackView.addArrangedSubview(styleGuideButton)
        
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
        
    @objc func showComponents() {
        //let componentsViewController = ComponentListViewController()
        //navigationController?.pushViewController(componentsViewController, animated: true)
    }
        
    @objc func showStyleGuide() {
        let styleGuideViewController = GuideStyleViewController()
        navigationController?.pushViewController(styleGuideViewController, animated: true)
    }
}
