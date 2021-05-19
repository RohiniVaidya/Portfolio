//
//  HomeView.swift
//  MyPortfolioApp
//
//  Created by Rohini Vaidya on 01/05/21.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject var dataController: DataController
    var body: some View {
        
        
        NavigationView {
            Button("Add Data") {
                dataController.deleteAll()
                try? dataController.createSampleData()
            }
                .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
