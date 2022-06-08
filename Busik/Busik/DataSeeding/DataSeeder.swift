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
    
    init(ctxManager: ContextManager)
    {
        _ctxManager = ctxManager;
        _userRepository = UserRepository(contextManager: ctxManager);
        _localityRepository = LocalityRepository(contextManager: ctxManager);
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
    
}
