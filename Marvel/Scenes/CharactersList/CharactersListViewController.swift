//
//  CharactersListViewController.swift
//  Marvel
//
//  Created by Magy Elias on 8/6/19.
//  Copyright © 2019 Magy Elias. All rights reserved.
//

import UIKit

final class CharactersListViewController: BaseViewController {
    
    // MARK: - Properties Conformance
    var charactersListPresenter: CharactersListPresentationLogic?
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersListTableView: UITableView!
    
    // MARK: - Private Properties
    private var charactersDataSource = [CharacterViewModel]()
    fileprivate var charactersTotalCount = 0
    fileprivate var searchCharacters = [CharacterViewModel]()
    fileprivate var searching = false
    
    private var pageNumber: Int {
        return (charactersDataSource.count / 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Characters"
        prepareTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searching = false
        searchCharacters = [CharacterViewModel]()
    }
    
    private func prepareTableView() {
        guard let charactersListPresenter = charactersListPresenter else { return }
        
        charactersListTableView.tableFooterView = UIView()
        charactersListTableView.estimatedRowHeight = 200.0
        charactersListTableView.rowHeight = UITableView.automaticDimension
        
        charactersListPresenter.getCharacters(pageNumber: pageNumber, showHideActivityIndicator: true, onComplete: { [weak self] (totalCount, viewModel) in
            self?.charactersDataSource = viewModel
            self?.charactersTotalCount = totalCount
            self?.charactersListTableView.reloadData()
        })
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchCharacters.count : charactersDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as! CharacterTableViewCell
        cell.characterData = searching ? searchCharacters[indexPath.row] : charactersDataSource[indexPath.row]
        cell.backgroundColor = ColorConstants.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let charactersListPresenter = charactersListPresenter else { return }
        
        charactersListPresenter.navigateToCharacterDetail(
            character: searching ? searchCharacters[indexPath.row] : charactersDataSource[indexPath.row]
        )
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: Pagination
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == charactersDataSource.count - 1 && charactersDataSource.count < charactersTotalCount {
            DispatchQueue.main.async { [weak self] in
                self?.charactersListTableView.tableFooterView?.isHidden = false
            }

            guard let charactersListPresenter = charactersListPresenter else { return }
            charactersListPresenter.getCharacters(pageNumber: pageNumber, showHideActivityIndicator: false, onComplete: { [weak self] (totalCount, viewModel) in
                guard let self = self else { return }
                var indexes: ClosedRange<Int>
                var dataCount: Int
                
                if self.searching {
                    self.searchCharacters += viewModel
                    indexes = indexPath.row + 1...self.searchCharacters.count - 1
                    dataCount = self.searchCharacters.count
                } else {
                    self.charactersDataSource += viewModel
                    indexes = indexPath.row + 1...self.charactersDataSource.count - 1
                    dataCount = self.charactersDataSource.count
                }

                let indexPaths:[IndexPath] = ((dataCount-indexes.count)...(dataCount-1)).map({ index -> IndexPath in
                    return IndexPath(row: index, section: 0)
                })
                
                // Better than reload the whole tableview
                DispatchQueue.main.async { [weak self] in
                    self?.charactersListTableView.performBatchUpdates({
                        self?.charactersListTableView.insertRows(at: indexPaths, with: .automatic)
                    }, completion: nil)
                }
            })
        }
    }
}

extension CharactersListViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let charactersListPresenter = charactersListPresenter, let searchText = searchBar.text else { return }
        charactersListPresenter.getFilteredCharacters(with: searchText, showHideActivityIndicator: false, onComplete: { [weak self] (totalCount, viewModel) in
            guard let self = self else { return }
            
            self.searchCharacters = viewModel
            self.searching = true
            self.charactersListTableView.reloadData()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchCharacters.removeAll()
        
        if !searchText.isEmpty {
            guard let charactersListPresenter = charactersListPresenter else { return }
            charactersListPresenter.getFilteredCharacters(with: searchText, showHideActivityIndicator: false, onComplete: { [weak self] (totalCount, viewModel) in
                guard let self = self else { return }

                self.searchCharacters += viewModel
                self.searching = true
                self.charactersListTableView.reloadData()
            })
        } else {
            searching = false
            charactersListTableView.reloadData()
        }
    }
}
