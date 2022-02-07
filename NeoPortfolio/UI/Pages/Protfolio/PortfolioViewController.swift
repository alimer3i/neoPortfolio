//
//  PortfolioViewController.swift
//  NeoPortfolio
//
//  Created by Ali Merhie on 2/5/22.
//

import Foundation
import UIKit

class PortfolioViewController: BaseViewController<PortfolioVM> {
    
    let cellIdentifier = "PortfolioTableViewCell"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupTableView()
        viewModel.pageDidLoad()
    }


    override func bindToViewModel() {
        super.bindToViewModel()
        
        // Setup for reloadTableViewClosure
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.navigateToOptions = { [weak self] selectedPortfolio in
            DispatchQueue.main.async {
                if let strongSelf = self{
                let vc = OptionsViewController.pushVC(mainView: strongSelf)
                    vc.viewModel.selectedPortfolio = selectedPortfolio
                }
            }
        }

    }
}

extension PortfolioViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.didSelectRow(at: indexPath)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! PortfolioTableViewCell
        self.viewModel.configure(cell: cell, at: indexPath)
        return cell
    }
}
