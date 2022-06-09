//
//  DataSeeder.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import Foundation

class DataSeeder
{
    private let _ctxManager: ContextManager;
    private var _userRepository: UserRepository;
    private var _localityRepository: LocalityRepository;
    private var _routeRepository: RouteRepository;
    private var _rideRepository: RideRepository;
    private var _bookedTicketRepository: BookedTicketRepository;
    
    init(ctxManager: ContextManager)
    {
        _ctxManager = ctxManager;
        _userRepository = UserRepository(contextManager: ctxManager);
        _localityRepository = LocalityRepository(contextManager: ctxManager);
        _routeRepository = RouteRepository(contextManager: ctxManager);
        _rideRepository = RideRepository(contextManager: ctxManager);
        _bookedTicketRepository = BookedTicketRepository(contextManager: ctxManager);
    }
    
    public func SeedUsers()
    {
        _userRepository.AddUser(login: "kris@gmail.com", password: "hd38h30dj");
        _userRepository.AddUser(login: "antoni@tut.by", password: "Y_3e3djd");
        _userRepository.AddUser(login: "petr_um@outlook.com", password: "Hddjnde_edj");
        _userRepository.AddUser(login: "anna_e@tut.by", password: "(edjejdeijd_e");
        _userRepository.AddUser(login: "mary@gmail.com", password: "Hjedhejdhdk_d");
    }
    
    public func SeedLocalities(){
        _localityRepository.AddLocality(name: "Minsk", latitude: 53.893009, longitude: 27.567444);
        _localityRepository.AddLocality(name: "Grodno", latitude: 53.669353, longitude: 23.813131);
        _localityRepository.AddLocality(name: "Brest", latitude: 52.097622, longitude: 23.734051);
        _localityRepository.AddLocality(name: "Mogilev", latitude: 53.900716, longitude: 30.331360);
        _localityRepository.AddLocality(name: "Vitebsk", latitude: 55.184806, longitude: 30.201622);
        _localityRepository.AddLocality(name: "Gomel", latitude: 52.441176, longitude: 30.987846);
    }
    
    public func SeedRoutes()
    {
        let localityMinsk: [Locality]? = _localityRepository.GetLocalityByName(name: "Minsk");
        let localityBrest: [Locality]? = _localityRepository.GetLocalityByName(name: "Brest");
        let localityGomel: [Locality]? = _localityRepository.GetLocalityByName(name: "Gomel");
        let localityVitebsk: [Locality]? = _localityRepository.GetLocalityByName(name: "Vitebsk");
        let localityMogilev: [Locality]? = _localityRepository.GetLocalityByName(name: "Mogilev");
        let localityGrodno: [Locality]? = _localityRepository.GetLocalityByName(name: "Grodno");
        
        
        
        _routeRepository.AddRoute(from: localityMinsk![0], to: localityBrest![0]);
        
        _routeRepository.AddRoute(from: localityMinsk![0], to: localityGrodno![0]);
        
        _routeRepository.AddRoute(from: localityMinsk![0], to: localityMogilev![0]);
        
        _routeRepository.AddRoute(from: localityMinsk![0], to: localityVitebsk![0]);
        
        _routeRepository.AddRoute(from: localityMinsk![0], to: localityGomel![0]);
        
        _routeRepository.AddRoute(from: localityBrest![0], to: localityGrodno![0]);
        
        _routeRepository.AddRoute(from: localityBrest![0], to: localityMogilev![0]);
        
        _routeRepository.AddRoute(from: localityBrest![0], to: localityVitebsk![0]);
        
        _routeRepository.AddRoute(from: localityBrest![0], to: localityGomel![0]);
        
        _routeRepository.AddRoute(from: localityGrodno![0], to: localityMogilev![0]);
        
        _routeRepository.AddRoute(from: localityGrodno![0], to: localityVitebsk![0]);
        
        _routeRepository.AddRoute(from: localityGrodno![0], to: localityGomel![0]);
        
        _routeRepository.AddRoute(from: localityMogilev![0], to: localityVitebsk![0]);
        
        _routeRepository.AddRoute(from: localityMogilev![0], to: localityGomel![0]);
        
        _routeRepository.AddRoute(from: localityVitebsk![0], to: localityGomel![0]);
        
        
        //-------------------------------------------------------
        _routeRepository.AddRoute(from: localityBrest![0], to: localityMinsk![0]);
        
        _routeRepository.AddRoute(from: localityGrodno![0], to: localityMinsk![0]);
        
        _routeRepository.AddRoute(from: localityMogilev![0], to: localityMinsk![0]);
        
        _routeRepository.AddRoute(from: localityVitebsk![0], to: localityMinsk![0]);
        
        _routeRepository.AddRoute(from: localityGomel![0], to: localityMinsk![0]);
        
        _routeRepository.AddRoute(from: localityGrodno![0], to: localityBrest![0]);
        
        _routeRepository.AddRoute(from: localityMogilev![0], to: localityBrest![0]);
        
        _routeRepository.AddRoute(from: localityVitebsk![0], to: localityBrest![0]);
        
        _routeRepository.AddRoute(from: localityGomel![0], to: localityBrest![0]);
        
        _routeRepository.AddRoute(from: localityMogilev![0], to: localityGrodno![0]);
        
        _routeRepository.AddRoute(from: localityVitebsk![0], to: localityGrodno![0]);
        
        _routeRepository.AddRoute(from: localityGomel![0], to: localityGrodno![0]);
        
        _routeRepository.AddRoute(from: localityVitebsk![0], to: localityMogilev![0]);
        
        _routeRepository.AddRoute(from: localityGomel![0], to: localityMogilev![0]);
        
        _routeRepository.AddRoute(from: localityGomel![0], to: localityVitebsk![0]);
    }
    
    public func SeedRides()
    {
        let route = _routeRepository.GetRoutesFrom(fromLocalityName: "Minsk")![0];
        
        let formatter = DateFormatter();
        //formatter.timeZone = TimeZone(
        formatter.dateFormat = "dd.MM.yyyy HH:mm";
        let departure = formatter.date(from: "10.06.2022 05:00");
        let arrival = formatter.date(from: "10.06.2022 11:09");
        
        _rideRepository.AddRide(departureTime: departure!, arrivalTime: arrival!, duration: 309, availiableTickets: 25, price: 19.6, route: route)
        
        
        //---------------------------------------------------
        
        /*let routeMinskBrest = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Brest");
        
        let routeMinskGrodno = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Grodno");
        
        let routeMinskMogilev = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Mogilev");
        
        let routeMinskVitebsk = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Vitebsk");
        
        let routeMinskGomel = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Gomel");
        
        let routeBrestGrodno = _routeRepository.GetRoute(fromLocalityName: "Brest", toLocalityName: "Grodno");
        
        let routeBrestMogilev = _routeRepository.GetRoute(fromLocalityName: "Brest", toLocalityName: "Mogilev");
        
        let routeBrestVitebsk = _routeRepository.GetRoute(fromLocalityName: "Brest", toLocalityName: "Vitebsk");
        
        let routeBrestGomel = _routeRepository.GetRoute(fromLocalityName: "Brest", toLocalityName: "Gomel");
        
        let routeGrodnoMogilev = _routeRepository.GetRoute(fromLocalityName: "Grodno", toLocalityName: "Mogilev");
        
        let routeGrodnoVitebsk = _routeRepository.GetRoute(fromLocalityName: "Grodno", toLocalityName: "Vitebsk");
        
        let routeGrodnoGomel = _routeRepository.GetRoute(fromLocalityName: "Grodno", toLocalityName: "Gomel");
        
        let routeMogilevVitebsk = _routeRepository.GetRoute(fromLocalityName: "Mogilev", toLocalityName: "Vitebsk");
        
        let routeMogilevGomel = _routeRepository.GetRoute(fromLocalityName: "Mogilev", toLocalityName: "Gomel");
        
        let routeVitebskGomel = _routeRepository.GetRoute(fromLocalityName: "Vitebsk", toLocalityName: "Gomel");
        
        // ------------------------------------------------
        
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");
        
        let route = _routeRepository.GetRoute(fromLocalityName: "", toLocalityName: "");*/
        
    }
    
    
    
    public func SeedBookedTickets()
    {
        let user = _userRepository.GetUsersByLogin(login: "kris@gmail.com")![0];
        
        let rideArray = _routeRepository.GetRoute(fromLocalityName: "Minsk", toLocalityName: "Brest")![0].rides!.allObjects as! [Ride];
        
        _bookedTicketRepository.BookTicket(user: user, ride: rideArray[0]);
    }
}
