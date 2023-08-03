//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Radu Petrisel on 03.08.2023.
//

import SwiftUI

struct ContentView: View {
    private let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject private var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var isShowingSortOptionsDialog = false
    @State private var sorting = SortOptions.none
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort.")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Button("Sort") {
                    isShowingSortOptionsDialog = true
                }
            }
            .confirmationDialog("Choose sorting", isPresented: $isShowingSortOptionsDialog) {
                Button("Clear sorting") { sorting = .none }
                Button("By name") { sorting = .name }
                Button("By country") { sorting = .country }
                Button("Cancel", role: .cancel) { }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    
    private var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    private var sortedResorts: [Resort] {
        switch sorting {
        case .none:
            return filteredResorts
        case .name:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    private enum SortOptions {
        case none, name, country
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
