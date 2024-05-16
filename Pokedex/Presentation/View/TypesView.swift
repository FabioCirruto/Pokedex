//
//  TypesView.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 16/05/24.
//

import UIKit

class TypesView: UIView {
    let label: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textColor = .gray
        return lbl
    }()
    
    lazy var container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view).offset(4)
            make.bottom.equalTo(view).offset(-4)
            make.left.equalTo(view).offset(UIConstant.spacing)
            make.right.equalTo(view).offset(-UIConstant.spacing)
        }
        
        return view
    }()
    
    required init() {
        super.init(frame: .zero)
        buildSubviews()
        buildConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildSubviews() {
        self.addSubview(container)
    }
    
    func buildConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    static func getSize(text: String) -> CGSize {
        let itemSize = (text).size(withAttributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
        ])
        let horizontalInset: CGFloat = CGFloat(UIConstant.spacing * 2)
        let verticalInset: CGFloat = 4 * 2
        let totalWidth = horizontalInset + itemSize.width
        let totalHeight = itemSize.height + verticalInset
        return CGSize(width: totalWidth, height: totalHeight)
    }
}
