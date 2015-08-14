//
//  ViewController.swift
//  BooksAndMovies
//
//  Created by Josh Brown on 8/14/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource {
    let moviesSegment = 0
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = MasterViewModel()

    @IBAction func didChangeSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == moviesSegment {
            // load movies
            loadMovies()
        } else {
            // load books
            loadBooks()
        }
    }
    
    func loadMovies() {
        viewModel.refreshMovies {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    func loadBooks() {
        viewModel.refreshBooks {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovies()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = viewModel.titleForItemAtIndexPath(indexPath)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPathForCell(cell) {
            
            vc.viewModel = viewModel.detailViewModelForIndexPath(indexPath)
        }
    }
}

