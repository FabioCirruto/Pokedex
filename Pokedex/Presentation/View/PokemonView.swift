//
//  PokemonView.swift
//  Pokedex
//
//  Created by Fabio Cirruto on 15/05/24.
//

import UIKit
import Factory
import SnapKit

class PokemonView: UIViewController {
    @Injected(\.pokemonViewModel) private var viewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(PokemonViewCell.self, forCellReuseIdentifier: PokemonViewCell.reusableIdentifer)
        tableView.allowsSelection = false
        return tableView
    }()
    
    let searchBar: UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildSubviews()
        buildConstraints()
        
        self.viewModel.vcReference = self
        self.viewModel.download()
    }
    
    func buildSubviews() {
        let attribute = NSAttributedString.build(strings: ["Pokemon","Box"], fonts: [UIFont.systemFont(ofSize: 16), UIFont.boldSystemFont(ofSize: 18)], colors: [.black, .black])
        let lblTitle = UILabel()
        lblTitle.attributedText = attribute
        navigationItem.titleView = lblTitle
        
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        searchBar.searchBar.sizeToFit()
        searchBar.searchBar.searchTextField.delegate = self
        navigationItem.searchController = searchBar
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
    }
}

extension PokemonView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonViewCell.reusableIdentifer) as! PokemonViewCell
        cell.configure(pokemon: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        if offsetY > contentHeight - screenHeight && viewModel.canDownloadMore {
            self.viewModel.download()
        }
    }
}

extension PokemonView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.viewModel.search(text: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        self.viewModel.delete()
    }
    
    @objc func onClear() {
        searchBar.searchBar.endEditing(true)
        self.viewModel.delete()
    }
}

extension PokemonView: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.viewModel.delete()
        self.searchBar.isActive = false
        return true
    }
}
