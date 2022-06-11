//
//  RideRepository.swift
//  Busik
//
//  Created by Kanstantin Venger on 6/9/22.
//

import Foundation
import CoreData

class RideRepository
{
    private let _ctxManager: ContextManager;
    private let _localityRepository: LocalityRepository!;
    
    init(contextManager: ContextManager)
    {
        _ctxManager = contextManager;
        _localityRepository = LocalityRepository(contextManager: _ctxManager);
    }
    
    func AddRide(departureTime: Date, arrivalTime: Date, duration: Int32, availiableTickets: Int32, price: Float, route: Route)
    {
        let ride = Ride(context: _ctxManager.Context);
        ride.price = price;
        ride.arrivalTime = arrivalTime;
        ride.availableTickets = availiableTickets;
        ride.duration = duration;
        ride.departureTime = departureTime;
        ride.route = route;
        
        do{
            try _ctxManager.SaveChanges();
        } catch let error as NSError{
            print("Failed to save new ride: \(ride) :error \(error)")
        }
    }
    
    func GetRides() -> [Ride]?{
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get all routes request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(after: Date) -> [Ride]?{
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        let predicate = NSPredicate(format: "departureTime > %@", after as CVarArg);
        
        fetchRequest.predicate = predicate;
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get rides request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(before: Date) -> [Ride]?{
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        let predicate = NSPredicate(format: "departureTime < %@", before as CVarArg);
        
        fetchRequest.predicate = predicate;
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get rides request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(before: Date, after: Date) -> [Ride]?{
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        let predicate = NSPredicate(format: "departureTime < %@ and departureTime > %@", before as CVarArg, after as CVarArg);
        
        fetchRequest.predicate = predicate;
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get rides request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(fromLocality: Locality) -> [Ride]?{
        
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        let predicate = NSPredicate(format: "route.from.name == %@", fromLocality.name!);
        
        fetchRequest.predicate = predicate;
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get rides request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(toLocality: Locality) -> [Ride]?{
        
        let fetchRequest = NSFetchRequest<Ride>(entityName: "Ride");
        
        let predicate = NSPredicate(format: "route.to.name == %@", toLocality.name!);
        
        fetchRequest.predicate = predicate;
        
        var rides: [Ride]? = nil
        
        do{
            try rides = _ctxManager.Context.fetch(fetchRequest);
        }
        catch let error as NSError{
            print("Get rides request failed with error: \(error)");
        }
        return rides;
    }
    
    func GetRides(fromLocality: Locality, toLocality: Locality, before: Date, after: Date) -> [Ride]?{
        //TODO:
        var rides: [Ride]? = nil
        return rides;
    }
    
    func GetRides(route: Route) -> [Ride]?
    {
        route.rides?.allObjects as! [Ride]?;
    }
}
