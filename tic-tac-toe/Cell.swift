import Foundation
import SwiftUI

struct Cell {
    var tile: Tile
    
    func displayTile() -> String {
        switch(tile) {
        case Tile.Circle:
            return "O"
        case Tile.Cross:
            return "X"
        default:
            return ""
        }
    }
    
    func tileColor() -> Color {
        switch(tile) {
        case Tile.Circle:
            return Color.red
        case Tile.Cross:
            return Color.blue
        default:
            return Color.white
        }
    }
}

enum Tile {
    case Circle
    case Cross
    case Empty
}
