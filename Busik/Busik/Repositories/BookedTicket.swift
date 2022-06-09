//
//  BookedTicket.swift
//  Busik
//
//  Created by Kanstantin Venger on 6/9/22.
//

import Foundation
import CoreData

class BookedTicketRepository
{
    private let _ctxManager: ContextManager;
    private let _localityRepository: LocalityRepository!;
    
    init(contextManager: ContextManager)
    {
        _ctxManager = contextManager;
        _localityRepository = LocalityRepository(contextManager: _ctxManager);
    }
    
    func BookTicket(user: User, ride: Ride)
    {
        let bookedTicket = BookedTicket(context: _ctxManager.Context);
        
        if ride.availableTickets <= 0{
            print("Cannot book a ticket for ride: \(ride) as no tickets left");
            return;
        }
        
        ride.availableTickets-=1;
        bookedTicket.bookingTime = Date();
        bookedTicket.ride = ride;
        bookedTicket.user = user;
        
        do{
            try _ctxManager.SaveChanges();
        } catch let error as NSError{
            print("Failed to book ticket \(bookedTicket) with error \(error)");
        }
    }
    
    func GetBookedTicketsByUserLogin(login: String) -> [BookedTicket]?{
        let fetchRequest = NSFetchRequest<BookedTicket>(entityName: "BookedTicket");
        
        let predicate = NSPredicate(format: "user.login == %@", login);
        
        fetchRequest.predicate = predicate;
        
        var bookedTickets: [BookedTicket]? = nil
        
        do{
            try bookedTickets = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Failed to get booked tickets by login \(error)");
        }
        return bookedTickets;
    }
}
