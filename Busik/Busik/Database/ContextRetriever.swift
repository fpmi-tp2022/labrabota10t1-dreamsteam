//
//  File.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import Foundation
import UIKit
import CoreData

class ContextRetriever
{
    public static func RetrieveContext()-> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        return appDelegate.persistentContainer.viewContext;
    }
}
