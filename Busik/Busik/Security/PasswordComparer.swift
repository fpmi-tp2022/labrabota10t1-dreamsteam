//
//  PasswordComparer.swift
//  Busik
//
//  Created by Kanstantin Venger on 6/11/22.
//

import Foundation

class PasswordComparer
{
    public static func Compare(coming: String?, stored: String?) -> Bool{
        
        if(coming == nil || stored == nil)
        {
            return false;
        }
        
        let hashed = String(coming!.hash);
        
        if(hashed == stored){
            return true;
        }
        
        return false;
    }
}
