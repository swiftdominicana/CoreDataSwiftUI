//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Libranner Leonel Santos Espinal on 15/02/2020.
//  Copyright © 2020 Libranner Leonel Santos Espinal. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Device.entity(), sortDescriptors: [])
  var devices: FetchedResults<Device>
  
  @State var deviceName: String = ""
  @State var priceRawValue: Double = 0
  @State var showForm = false
  
  private var currencyFormatter: NumberFormatter = {
    let f = NumberFormatter()
    f.numberStyle = .currency
    return f
  }()
  
  var price: Binding<String> {
    Binding<String>(
      get: { String(format: "%.2f", Double(self.priceRawValue)) },
      set: {
        if let value = NumberFormatter().number(from: $0) {
          self.priceRawValue = value.doubleValue
        }
      }
    )
  }
  
  var body: some View {
    VStack {
      VStack {
        List(devices, id:\.self) { device in
          VStack(alignment: .leading, spacing: 3) {
            Text(device.name ?? "N/A")
            Text(String(format: "%.2f", device.price))
              .font(.subheadline)
              .foregroundColor(.gray)
          }
        }
        
        Button("Add new Device") {
          self.showForm = true
        }
        
        Button("Guardar") {
          if self.moc.hasChanges {
            do {
              try self.moc.save()
            }
            catch {
              print(error.localizedDescription)
            }
          }
        }
      }
    }.sheet(isPresented: $showForm) {
      VStack(spacing: 30) {
        TextField(" Enter device name", text: self.$deviceName)
        TextField(" Enter device price", text: self.price)
        Button("Add") {
          let device = Device(context: self.moc)
          device.name = self.deviceName
          device.price = self.priceRawValue
          
          self.deviceName = ""
          self.priceRawValue = 0
          self.showForm = false
        }
      }.padding([.leading, .trailing], 40)
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
