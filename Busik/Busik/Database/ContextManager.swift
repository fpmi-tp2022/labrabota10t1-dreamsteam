//
//  ContextManager.swift
//  Busik
//
//  Created by Kanstantin Venger on 5/31/22.
//

import Foundation
import CoreData

class ContextManager
{
    public let Context: NSManagedObjectContext;
    
    init(context: NSManagedObjectContext)
    {
        Context = context;
    }
    
    public func GetContext() -> NSManagedObjectContext {
        return Context;
    }
    
    public func SaveChanges() throws {
        try Context.save();
    }
}
