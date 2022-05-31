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
    
    init(ctxManager: ContextManager)
    {
        _ctxManager = ctxManager;
        _userRepository = UserRepository(contextManager: ctxManager);
    }
    
    public func SeedUsers()
    {
        _userRepository.AddUser(login: "kris@gmail.com", password: "hd38h30dj");
        _userRepository.AddUser(login: "antoni@tut.by", password: "Y_3e3djd");
        _userRepository.AddUser(login: "petr_um@outlook.com", password: "Hddjnde_edj");
        _userRepository.AddUser(login: "anna_e@tut.by", password: "(edjejdeijd_e");
        _userRepository.AddUser(login: "mary@gmail.com", password: "Hjedhejdhdk_d");
    }
    
}
