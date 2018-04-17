//
//  ListViewController.swift
//  CocoaHeadsMobile
//
//  Created by Jesse Collis on 9/4/17.
//  Copyright © 2017 Melbourne CocoaHeads. All rights reserved.
//

import UIKit
import APIClient

class ListViewController: UITableViewController, SegueHandlerType {
    
    enum SegueIdentifier: String {
        case showDetails
    }
    
    var events:[ListEvent] = [] {
        didSet {
            print("Did set \(events.count) events.")
            
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.events.isEmpty {
            startLoading()
        }
    }
    
    func startLoading() {
        if let control = self.refreshControl {
            if !control.isRefreshing {
                control.beginRefreshing()
            }
        }
        
        loadEvents()
    }
    
    //MARK: API requests
    
    func loadEvents() {
        EventsAPI.getEvents { (result:Result<EventsResponse>) in
            
            self.finishLoading()
            
            switch result {
            case let .success(response):
                guard let events = response.events else {
                    self.displayEvents([])
                    return
                }
                
                self.events = events.flatMap { ListEvent(fromEvent:$0) }
            case let .failure(error):
                self.displayError(error: error)
            }
        }
    }
    
    //MARK: Refresh
    
    @IBAction func refreshControlValueDidChange(sender:UIRefreshControl) {
        if sender.isRefreshing {
            startLoading()
        }
    }
    
    func finishLoading() {
        self.refreshControl?.endRefreshing()
    }
    
    //MARK: Cell config
    
    func configure(cell:UITableViewCell, withEvent event:ListEvent) {
        cell.textLabel?.text = event.title
        cell.detailTextLabel?.text = event.subtitle
    }
    
    //MARK: Error States
    
    func displayError(error:Error) {
        //TODO: JC - Display Error
    }

    func displayEvents(_ events:[ListEvent]) {
        self.events = events
    }
    
    //MARK: Segue
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segueIdentifierForSegue(segue) {
            switch (identifier) {
            case .showDetails:
                if let controller = segue.destination as? EventDetailViewController {
                    if let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell) {
                        let event = self.events[indexPath.row]
                        controller.event = event
                    }
                }
            }
        }
    }
    
    //MARK: Tableview
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .listCell, forIndexPath: indexPath)
        
        let event = self.events[indexPath.row]
        
        configure(cell: cell, withEvent: event)
        
        return cell
    }
}

