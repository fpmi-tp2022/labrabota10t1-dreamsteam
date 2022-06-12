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
    
    var cal = Calendar.current
    
    var timetable: UITableView
    var errorLabel: UILabel
    
    let CELL_ID = "RideTableViewCell"
    var items = [Ride]()
    var sections = [String]()
    var numSections = [Int]()
    
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
        cal.timeZone = TimeZone(identifier: "UTC")!
        
        let nib = UINib(nibName: CELL_ID, bundle: nil)
        timetable.register(nib, forCellReuseIdentifier: CELL_ID)
    }
    
    // sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section >= sections.count {
            return nil
        }
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section >= numSections.count {
            return 0
        }
        return numSections[section];
    }
    
    // cell clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RideTableViewCell
        
        tableView.beginUpdates()
        cell.showBookButton()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RideTableViewCell

        tableView.beginUpdates()
        cell.hideBookButton()
        tableView.endUpdates()
    }
    
    // appearance
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.indexPathForSelectedRow?.row == indexPath.row {
            return 100;
        } else {
            return 80;
        }
    }
    
    // cell info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timetable.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! RideTableViewCell
        let item = items[indexPath.row]
        
        cell.constructFromRide(ride: item)
        return cell
    }
    
    
    public func FillTableWithData(_ beforeDate: Date, _ afterDate: Date, _ cityFromName: String, _ cityToName : String){
        let cityFrom = _localityRepository.GetLocalityByName(name: cityFromName)
        let cityTo = _localityRepository.GetLocalityByName(name: cityToName)
        
        errorLabel.text = ""
        sections.removeAll()
        numSections.removeAll()
        items.removeAll()
        if cityFrom == nil || cityTo == nil {
            errorLabel.text = "Internal error"
            return
        }
        if cityFrom!.isEmpty {
            errorLabel.text = "City from is not found"
            return
        }
        if cityTo!.isEmpty {
            errorLabel.text = "City to is not found"
            return
        }
        
        let data = _ridesRepository.GetRides(from: beforeDate, to: afterDate, fromLocality: cityFrom!.first!, toLocality: cityTo!.first!)
        if data == nil {
            errorLabel.text = "Internal error"
            return
        }
        if data!.isEmpty {
            errorLabel.text = "No results found"
            return
        }
        
        var curCount = 0
        var curDate : Date = data![0].departureTime!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.timeZone = cal.timeZone
        
        
        for ride in data! {
            if .orderedSame != cal.compare(curDate, to: ride.departureTime!, toGranularity: .day) {
                sections.append(dateFormatter.string(from: curDate)) // add name for a prev section
                numSections.append(curCount) // add rows count for a prev section
                curCount = 1
                curDate = ride.departureTime!
            } else {
                curCount += 1
            }
        }
        sections.append(dateFormatter.string(from: curDate)) // add last section
        numSections.append(curCount) // add last section
        
        items = data!
        DispatchQueue.main.async {
           self.timetable.reloadData()
        }
    }
}
