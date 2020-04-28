/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A model object that stores app data.
*/

import Combine
import SwiftUI

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var tutorials = tutorialData
    @Published var favorites: [String: Bool] = favoriteData
    @Published var sketches = sketchData
}
