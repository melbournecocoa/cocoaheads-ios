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
        EventsAPI.getEvents { response, error in
            
            self.finishLoading()
            
            switch (response, error) {
            case let (.some(response), .none()):
                guard let events = response.events else {
                    self.displayEvents([])
                    return
                }
                self.displayEvents(events.flatMap { ListEvent(fromEvent:$0) })
            case let (.none, .some(error)):
                self.displayError(error: error)
            default:
                // There is a case where we could receive no-content from the API.
                // Here we'd receive no response and no error.
                self.displayEvents([])
                break
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

