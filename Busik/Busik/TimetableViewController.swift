//
//  TimetableView.swift
//  Busik
//
//  Created by macos on 11.06.2022.
//

import Foundation
import UIKit

class TimetableViewController : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    var _localityRepository: LocalityRepository!;
    var _roureRepository: RouteRepository!;
    var _ridesRepository: RideRepository!;
    var _bookedTicketRepository: BookedTicketRepository!;
    
    var timetable: UITableView
    var errorLabel: UILabel
    
    let CELL_ID = "RideTableViewCell"
    var items = [Ride]()
    
    init(timetable: UITableView, errorLabel: UILabel) {
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
        _localityRepository = LocalityRepository(contextManager: CtxManager);
        _roureRepository = RouteRepository(contextManager: CtxManager);
        _ridesRepository = RideRepository(contextManager: CtxManager);
        _bookedTicketRepository = BookedTicketRepository(contextManager: CtxManager);
        
        self.timetable = timetable
        self.errorLabel = errorLabel
        let nib = UINib(nibName: CELL_ID, bundle: nil)
        timetable.register(nib, forCellReuseIdentifier: CELL_ID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timetable.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! RideTableViewCell
        let item = items[indexPath.row]
        
        cell.constructFromRide(ride: item)
        return cell
    }
    
    
    public func FillTableWithData(_ beforeDate: Date, _ afterDate: Date, _ cityFromName: String, _ cityToName : String){
        let cityFrom = _localityRepository.GetLocalityByName(name: cityFromName)
        let cityTo = _localityRepository.GetLocalityByName(name: cityToName)
        if cityFrom == nil || cityTo == nil {
            errorLabel.text = NSLocalizedString("INTERNAL_ERROR", comment: "")
            return
        }
        if cityFrom!.isEmpty {
            errorLabel.text = NSLocalizedString("FROM_NOT_FOUND", comment: "")
            return
        }
        if cityTo!.isEmpty {
            errorLabel.text = NSLocalizedString("TO_NOT_FOUND", comment: "")
            return
        }
        
        let data = _ridesRepository.GetRides(from: beforeDate, to: afterDate, fromLocality: cityFrom!.first!, toLocality: cityTo!.first!)
        if data == nil{
            errorLabel.text = NSLocalizedString("INTERNAL_ERROR", comment: "")
            return
        }
        if data!.isEmpty {
            errorLabel.text = NSLocalizedString("NO_RESULTS_FOUND", comment: "")
        }
        items = data!
        DispatchQueue.main.async {
           self.timetable.reloadData()
        }
    }
}
