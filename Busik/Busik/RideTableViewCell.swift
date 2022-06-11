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
    @IBOutlet weak var priceLabel: UILabel!
    
    public func constructFromRide(ride: Ride) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        departureLabel.text = dateFormatter.string(from: ride.departureTime!)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        arrivalLabel.text  = dateFormatter.string(from: ride.arrivalTime!)
        durationLabel.text = String(ride.duration) + " min"
        priceLabel.text = String(format: "%.2fр", ride.price)
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
