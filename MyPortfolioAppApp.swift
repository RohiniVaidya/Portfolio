//
//  MyPortfolioAppApp.swift
//  MyPortfolioApp
//
//  Created by Rohini Vaidya on 01/05/21.
//

import SwiftUI

@main
struct MyPortfolioAppApp: App {
    
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
