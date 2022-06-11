//
//  BookedTicketsViewController.swift
//  Busik
//
//  Created by Tyoma on 11.06.22.
//

import UIKit

class BookedTicketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    fileprivate let CELL_ID = "CELL_ID"
    fileprivate var items = [Ride]()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        let item = items[indexPath.row]
        
        let text = dateFormatter.string(from: item.arrivalTime!) + " " + dateFormatter.string(from: item.departureTime!) + " \(item.price)"
        cell.textLabel?.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //TODO: remove from DB
        }
        //tableView.reloadData()
    }
}
