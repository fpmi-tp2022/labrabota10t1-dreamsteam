//
//  RideTableViewCell.swift
//  Busik
//
//  Created by macos on 11.06.2022.
//

import UIKit

class RideTableViewCell: UITableViewCell {
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dashedLine: UILabel!
    
    public func constructFromRide(ride: Ride) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        departureLabel.text = dateFormatter.string(from: ride.departureTime!)
        arrivalLabel.text  = dateFormatter.string(from: ride.arrivalTime!)
        durationLabel.text = String(ride.duration) + " min"
        priceLabel.text = String(format: "%.2fр", ride.price)
        hideBookButton()
    }
    
    public func showBookButton() {
        UIView.animate(withDuration: 0.5) {
            self.bookButton.alpha = 1
            self.bookButton.isHidden = false
        }
    }
    
    public func hideBookButton() {
        UIView.animate(withDuration: 0.5) {
            self.bookButton.alpha = 0
            self.bookButton.isHidden = true
        }
    }
    
    @IBAction func bookTicket(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
