//
//  ContentView.swift
//  Movi
//
//  Created by Arsh Malhotra on 8/22/23.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RecentSearch.timestamp, ascending: true)],
        animation: .default)
    private var recentSearches: FetchedResults<RecentSearch>
    
    @State private var movieSearch = ""
    @State private var searchIsActive = false

    var body: some View {
        NavigationView {
            if searchIsActive {
                // Show recent searches
                Section("Recent Searches") {
                    List {
                        ForEach(recentSearches) { search in
                            NavigationLink {
                                Text("Recent search of \(search.searchText!)")
                            } label: {
                                Text("\(search.searchText!)")
                            }
                        }
                    }
                }
            } else {
                Text("Search not active.")
            }
        }
        .navigationTitle("Searching: \(searchIsActive ? "Yes" : "No")")
        .searchable(text: $movieSearch, /* isPresented: $searchIsActive */ prompt: "Search for a movie")
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
