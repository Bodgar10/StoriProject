//
//  DemoColorsViewController.swift
//  DesignSystemDemo
//
//  Created by Bodgar Espinosa Miranda on 16/12/24.
//

import UIKit
import DesignSystem

class ColorModel: Identifiable {
    let id = UUID()
    var name: String
    var color: UIColor
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

class DemoColorsViewController: UIViewController {

    fileprivate let colors: [ColorModel] = [
        ColorModel(name: "Color900", color: Colors.color900 ?? .black),
        ColorModel(name: "Color800", color: Colors.color800 ?? .black),
        ColorModel(name: "Color700", color: Colors.color700 ?? .black),
        ColorModel(name: "Color600", color: Colors.color600 ?? .black),
        ColorModel(name: "Color500", color: Colors.color500 ?? .black),
        ColorModel(name: "Color400", color: Colors.color400 ?? .black),
        ColorModel(name: "Color300", color: Colors.color300 ?? .black),
        ColorModel(name: "Color200", color: Colors.color200 ?? .black),
        ColorModel(name: "Color100", color: Colors.color100 ?? .black),
        ColorModel(name: "Color0", color: Colors.color0 ?? .black)
    ]
    
    private var collectionView: UICollectionView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Colors"
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
        
        self.view.addSubview(collectionView)
    }
}

extension DemoColorsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! ColorCell
        let colorModel = colors[indexPath.row]
        cell.configure(with: colorModel)
        return cell
    }
}

class ColorCell: UICollectionViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(colorView)
        stackView.addArrangedSubview(nameLabel)
        
        colorView.heightAnchor.constraint(equalTo: colorView.widthAnchor).isActive = true
    }
    
    func configure(with colorModel: ColorModel) {
        colorView.backgroundColor = colorModel.color
        nameLabel.text = colorModel.name
    }
}


