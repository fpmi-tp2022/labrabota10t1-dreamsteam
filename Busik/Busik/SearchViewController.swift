//
//  ViewController.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var beforeDatePicker: UIDatePicker!
    @IBOutlet weak var afterDatePicker: UIDatePicker!
    @IBOutlet weak var timetable: UITableView!
    @IBOutlet weak var cityFromControl: UISegmentedControl!
    @IBOutlet weak var cityToControl: UISegmentedControl!
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    var _localityRepository: LocalityRepository!;
    var _roureRepository: RouteRepository!;
    var _ridesRepository: RideRepository!;
    var _bookedTicketRepository: BookedTicketRepository!;
    
    fileprivate let CELL_ID = "CELL_ID"
    fileprivate var items = [Ride]()
    
    private var cityFrom: Locality
    private var cityTo: Locality
    private var beforeDate: Date
    private var afterDate: Date
    
    required init?(coder: NSCoder) {
        cityFrom = Locality()
        cityTo = Locality()
        beforeDate = Date()
        afterDate = Date()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
        _localityRepository = LocalityRepository(contextManager: CtxManager);
        _roureRepository = RouteRepository(contextManager: CtxManager);
        _ridesRepository = RideRepository(contextManager: CtxManager);
        _bookedTicketRepository = BookedTicketRepository(contextManager: CtxManager);
        
        let dataSeeder = DataSeeder(ctxManager: CtxManager);
        
        //ATTENTION: uncomment to get add test data to db if needed
        //But do it only once on each device
        //dataSeeder.SeedUsers()
        //dataSeeder.SeedLocalities();
        //dataSeeder.SeedRoutes();
        //dataSeeder.SeedRides();
        //dataSeeder.SeedBookedTickets();
        
        //cityFrom = (_localityRepository.GetLocalityByName(name: "Minsk")?.first!)!
        //cityTo = (_localityRepository.GetLocalityByName(name: "Minsk")?.first!)!
        
        timetable.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
        FillTableWithData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCell(withIdentifier: "cell");

        //print("IndexPath: \(indexPath), number \(indexPath.item)\n")
        //return cell!;
        let dateFormatter = DateFormatter()
        let cell = timetable.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        let item = items[indexPath.row]
        
        let text = dateFormatter.string(from: item.arrivalTime!) + " " + dateFormatter.string(from: item.departureTime!) + " \(item.price)"
        cell.textLabel?.text = text
        
        return cell
    }
    @IBAction func fromSegmentedControlChanged(_ sender: Any) {
        switch(cityFromControl.selectedSegmentIndex){
        case 0:
            cityFrom = (_localityRepository.GetLocalityByName(name: "Minsk")?.first!)!
            break
        case 1:
            cityFrom = (_localityRepository.GetLocalityByName(name: "Grodno")?.first!)!
            break
        case 2:
            cityFrom = (_localityRepository.GetLocalityByName(name: "Gomel")?.first!)!
            break
        case 3:
            cityFrom = (_localityRepository.GetLocalityByName(name: "Vitebsk")?.first!)!
            break
        default:
            break
        }
        FillTableWithData()
    }
    @IBAction func toSegmentedControlChanged(_ sender: Any) {
        switch(cityToControl.selectedSegmentIndex){
        case 0:
            cityTo = (_localityRepository.GetLocalityByName(name: "Minsk")?.first!)!
            break
        case 1:
            cityTo = (_localityRepository.GetLocalityByName(name: "Grodno")?.first!)!
            break
        case 2:
            cityTo = (_localityRepository.GetLocalityByName(name: "Gomel")?.first!)!
            break
        case 3:
            cityTo = (_localityRepository.GetLocalityByName(name: "Vitebsk")?.first!)!
            break
        default:
            break
        }
        FillTableWithData()
    }
    @IBAction func beforeDateChanged(_ sender: Any) {
        beforeDate = beforeDatePicker.date
        FillTableWithData()
    }
    @IBAction func afterDateChanged(_ sender: Any) {
        afterDate = afterDatePicker.date
        FillTableWithData()
    }
    
    private func FillTableWithData(){
        let data = _ridesRepository.GetRides(fromLocality: cityFrom, toLocality: cityTo, before: beforeDate, after: afterDate)
        if data == nil{
            return
        }
        
        items = data!
    }
    
}
