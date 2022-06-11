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
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        let cell = timetable.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        let item = items[indexPath.row]
        
        let text = dateFormatter.string(from: item.arrivalTime!) + " " + dateFormatter.string(from: item.departureTime!) + " \(item.price)"
        cell.textLabel?.text = text
        
        return cell
    }
    
    @IBAction func cityFromChanged(_ sender: Any) {
        let cityFromText = fromTextField.text!
        cityFrom = (_localityRepository.GetLocalityByName(name: cityFromText)?.first!)!
    }
    @IBAction func cityToChanged(_ sender: Any) {
        let cityToText = toTextField.text!
        cityTo = (_localityRepository.GetLocalityByName(name: cityToText)?.first!)!
    }
    @IBAction func beforeDateChanged(_ sender: Any) {
        beforeDate = beforeDatePicker.date
    }
    @IBAction func afterDateChanged(_ sender: Any) {
        afterDate = afterDatePicker.date
    }
    @IBAction func buttonSearchClicked(_ sender: Any) {
        FillTableWithData()
    }
    
    private func FillTableWithData(){
        let data = _ridesRepository.GetRides(from: afterDate, to: beforeDate, fromLocality: cityFrom, toLocality: cityTo)
        if data == nil{
            return
        }
        
        items = data!
    }
    
}
