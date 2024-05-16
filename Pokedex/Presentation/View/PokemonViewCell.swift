//
//  PokemonViewCell.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 15/05/24.
//

import UIKit
import SnapKit

class PokemonViewCell: UITableViewCell {
    let imgView: UIImageView = UIImageView(frame: .zero)
    
    var lblName: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    var lblDesc: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        return lbl
    }()
    
    let container: UIView = UIView(frame: .zero)
    
    var divider: UIView = {
        let view: UIView = UIView(frame: .zero)
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        buildSubviews()
        buildConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func buildSubviews() {
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(lblName)
        self.contentView.addSubview(container)
        self.contentView.addSubview(lblDesc)
        self.contentView.addSubview(divider)
    }
    
    func buildConstraints() {
        imgView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView).offset(UIConstant.padding)
            make.width.height.equalTo(44)
        }
        
        lblName.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.left.equalTo(imgView.snp.right).offset(UIConstant.spacing)
            make.right.equalTo(contentView).offset(-UIConstant.padding)
        }
        
        container.snp.makeConstraints { make in
            make.top.equalTo(lblName.snp.bottom).offset(UIConstant.spacing)
            make.left.equalTo(imgView.snp.right).offset(UIConstant.spacing)
            make.right.equalTo(contentView).offset(-UIConstant.padding)
        }
        
        lblDesc.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(UIConstant.spacing)
            make.left.equalTo(imgView.snp.right).offset(UIConstant.spacing)
            make.right.equalTo(contentView).offset(-UIConstant.padding)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(lblDesc.snp.bottom).offset(UIConstant.spacing)
            make.left.equalTo(contentView).offset(UIConstant.padding)
            make.right.equalTo(contentView).offset(-UIConstant.padding)
            make.bottom.equalTo(contentView).offset(-UIConstant.padding)
            make.height.equalTo(1)
        }
    }
    
    func configure(pokemon: PokemonUI) {
        lblName.text = pokemon.name
        lblDesc.text = pokemon.desc
        imgView.image = pokemon.image
        container.subviews.forEach({$0.removeFromSuperview()})
        
        let insets = UIConstant.spacing * 4
        let screenWidth = UIScreen.main.bounds.width
        let fullWidth = screenWidth - CGFloat(insets)
        
        var previousView: UIView?
        var previousViewSize: CGFloat = 0.0
        
        pokemon.types.enumerated().forEach { index, type in
            let tagView = TypesView()
            tagView.configure(text: type)
            let availableRowSpaceWidth: CGFloat
            if previousViewSize > 0 {
                availableRowSpaceWidth = fullWidth - CGFloat(UIConstant.spacing) - previousViewSize
            } else {
                availableRowSpaceWidth = fullWidth
            }
            
            container.addSubview(tagView)
            
            let itemSize = TypesView.getSize(text: type)
            let isLastElement = index == pokemon.types.count - 1
            if availableRowSpaceWidth > itemSize.width {
                if let prev = previousView {
                    tagView.snp.makeConstraints { make in
                        make.top.equalTo(prev)
                        make.left.equalTo(prev.snp.right).offset(UIConstant.spacing)
                        if isLastElement {
                            make.bottom.equalTo(container)
                        }
                    }
                } else {
                    tagView.snp.makeConstraints { make in
                        make.top.left.equalTo(container)
                        if isLastElement {
                            make.bottom.equalTo(container)
                        }
                    }
                }
            } else {
                if let prev = previousView {
                    tagView.snp.makeConstraints { make in
                        make.top.equalTo(prev.snp.bottom).offset(UIConstant.spacing)
                        make.left.equalTo(container)
                        if isLastElement {
                            make.bottom.equalTo(container)
                        }
                    }
                    previousViewSize = 0
                } else {
                    tagView.snp.makeConstraints { make in
                        make.top.left.equalTo(container)
                        if isLastElement {
                            make.bottom.equalTo(container)
                        }
                    }
                }
            }
            previousView = tagView
            previousViewSize += itemSize.width
        }
    }
}
