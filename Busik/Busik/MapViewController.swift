//
//  MapViewController.swift
//  Busik
//
//  Created by Tyoma on 8.06.22.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var departurePointTextField: UITextField!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var validationLabel: UILabel!
    var suggestions: [String]! = []
    
    public var CtxManager: ContextManager!;
    var _userRepository: UserRepository!;
    var _localityRepository: LocalityRepository!;
    var _roureRepository: RouteRepository!;
    var _ridesRepository: RideRepository!;
    var _bookedTicketRepository: BookedTicketRepository!;
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            textField.resignFirstResponder()

            return true

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
        
        var localities = _localityRepository.GetLocalities()!;
        
        for var locality in localities{
            suggestions.append(locality.name!);
        }
        
        print(suggestions)
        
        departurePointTextField.delegate = self;
        
        
        
        let london = MKPointAnnotation()
        london.title = "London"
        london.coordinate = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
        map.addAnnotation(london)
        
        map.reloadInputViews()
        
        //let initialLocation = CLLocation(latitude: 53.893009, longitude: 27.567444)
        //map.centerToLocation(initialLocation)

    }
    
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
