//
//  ViewController.swift
//  RxExample
//
//  Created by Jonatas on 17/11/20.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownPlayers = [String]()
    let allPlayers = ["Cristiano Ronaldo", "Neymar Junior", "Niedson Junior", "Messi", "Zico", "Pelé", "Vampeta"] // Mocked
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        searchBar
            .rx.text
            .orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                self.shownPlayers = self.allPlayers.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownPlayers[indexPath.row]
        
        return cell
    }
}
