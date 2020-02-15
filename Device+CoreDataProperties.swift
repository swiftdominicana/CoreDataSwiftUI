//
//  Device+CoreDataProperties.swift
//  CoreDataSwiftUI
//
//  Created by Libranner Leonel Santos Espinal on 15/02/2020.
//  Copyright © 2020 Libranner Leonel Santos Espinal. All rights reserved.
//
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double

}
