//
//  SpottingViewController.swift
//  ShotSpotter
//
//  Created by Jonah Witcig on 5/22/19.
//  Copyright © 2019 University of Missouri. All rights reserved.
//

import UIKit

/*
 Displays the details for a single shot spotting.
*/
class SpottingViewController: UIViewController {
    
    // outlets to our UI elements
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var beatLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
        
    // the landing being viewed
    var spotting: ShotSpotting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let spotting = self.spotting else {
            print("ShotSpottingViewController requires that 'spotting' property is set before loading!")
            return
        }
        
        // setting values on the UI labels
        self.typeLabel.text = spotting.type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.dateLabel.text = "Date: \(dateFormatter.string(from: spotting.date))"

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let timeString = timeFormatter.string(from: spotting.time)
        self.timeLabel.text = "Time: \(timeString)"
        
        self.roundsLabel.text = "Rounds: \(spotting.rounds)"
        self.beatLabel.text = "Beat: \(spotting.beat)"
        self.locationLabel.text = "Location: \(spotting.location.latitude), \(spotting.location.longitude)"
    }
    
    @IBAction func backPressed(sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
