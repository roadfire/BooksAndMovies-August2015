//
//  DetailViewController.swift
//  BooksAndMovies
//
//  Created by Josh Brown on 8/14/15.
//  Copyright (c) 2015 Roadfire Software. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var summaryLabel: UILabel!
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchImage { data in
            if let data = data {
                let image = UIImage(data: data)
                dispatch_async(dispatch_get_main_queue(), { [unowned self] () -> Void in
                    self.imageView.image = image
                })
            } else {
                println("fetch image returned no data")
            }
        }
        
        titleLabel.text = viewModel.title()
        artistLabel.text = viewModel.artist()
        genreLabel.text = viewModel.genre()
        summaryLabel.text = viewModel.summary()
    }
}