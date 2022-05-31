//
//  BookedTicket+CoreDataProperties.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//
//

import Foundation
import CoreData


extension BookedTicket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookedTicket> {
        return NSFetchRequest<BookedTicket>(entityName: "BookedTicket")
    }

    @NSManaged public var bookingTime: Date?
    @NSManaged public var ride: Ride?
    @NSManaged public var user: User?

}

extension BookedTicket : Identifiable {

}
