//
//  ViewController.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    var _localityRepository: LocalityRepository!;
    var _roureRepository: RouteRepository!;
    var _ridesRepository: RideRepository!;
    var _bookedTicketRepository: BookedTicketRepository!;
    

    @IBOutlet weak var beforeDatePicker: UIDatePicker!
    @IBOutlet weak var afterDatePicker: UIDatePicker!
    @IBOutlet weak var timetable: UITableView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filtersBackground: UIImageView!
    
    var suggestions: [String]! = []
    
    private var cityFrom: String = ""
    private var cityTo: String = ""
    private var beforeDate: Date = Date()
    private var afterDate: Date = Date()
    
    var cal = Calendar.current
    
    private var timetableController : TimetableViewController?  = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ctx = ContextRetriever.RetrieveContext();
        CtxManager = ContextManager(context: ctx);
        _userRepository = UserRepository(contextManager: CtxManager);
        _localityRepository = LocalityRepository(contextManager: CtxManager);
        _roureRepository = RouteRepository(contextManager: CtxManager);
        _ridesRepository = RideRepository(contextManager: CtxManager);
        _bookedTicketRepository = BookedTicketRepository(contextManager: CtxManager);
       
        filtersBackground.layer.cornerRadius = 20
        filtersBackground.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        searchButton.layer.cornerRadius = 10
        
        
        timetableController = TimetableViewController(timetable: timetable, errorLabel: errorLabel)
        timetable.delegate = timetableController!
        timetable.dataSource = timetableController!

        let localities = _localityRepository.GetLocalities()!;
        for locality in localities{
            suggestions.append(locality.name!);
        }
        fromTextField.delegate = self
        toTextField.delegate = self
        
        cal.timeZone = TimeZone(identifier: "UTC")!
        beforeDatePicker.timeZone = TimeZone.init(abbreviation: "UTC")
        afterDatePicker.timeZone = TimeZone.init(abbreviation: "UTC")
        beforeDate = cal.date(bySettingHour: 0, minute: 0, second: 0, of: beforeDatePicker.date)!
        afterDate = cal.date(bySettingHour: 23, minute: 59, second: 59, of: afterDatePicker.date)!
        
        //timetableController!.FillTableWithData(Date(), Date(), "Minsk", "Brest")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return !autoCompleteText(in: textField, using: string, suggestionsArray: suggestions);
    }
    
    func autoCompleteText(in textField: UITextField, using string: String, suggestionsArray: [String]) -> Bool{
        if !string.isEmpty,
           let selectedTextRange = textField.selectedTextRange,
           selectedTextRange.end == textField.endOfDocument,
           
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + string
            let matches = suggestionsArray.filter {
                $0.hasPrefix(prefix)
            }
            
            if (matches.count > 0) {
                textField.text = matches[0]
                
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                    return true
                }
            }
        }
        return false
    }
    
    @IBAction func buttonSearchClicked(_ sender: Any) {
        cityFrom = fromTextField.text!
        cityTo = toTextField.text!
        
        beforeDate = cal.date(bySettingHour: 0, minute: 0, second: 0, of: beforeDatePicker.date)!
        afterDate = cal.date(bySettingHour: 23, minute: 59, second: 59, of: afterDatePicker.date)!
        timetableController!.FillTableWithData(beforeDate, afterDate, cityFrom, cityTo)
    }
    
}
