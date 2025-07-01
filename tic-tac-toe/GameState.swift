import Foundation

class GameState: ObservableObject {
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var circleScore = 0
    @Published var crossScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"

    init() {
        resetBoard()
    }
    
    func turnText() -> String {
        return turn == Tile.Cross ? "X's Turn" : "O's Turn"
    }

    func placeTile(_ row: Int, _ col: Int) {
        if (board[row][col]).tile != Tile.Empty { return }

        board[row][col].tile = turn == Tile.Cross ? Tile.Cross : Tile.Circle

        if checkWin() {
            if turn == Tile.Cross {
                crossScore += 1
            } else {
                circleScore += 1
            }
            let winner = turn == Tile.Cross ? "X" : "O"
            alertMessage = winner + " Wins!"
            showAlert = true
        } else {
            turn = turn == Tile.Cross ? Tile.Circle : Tile.Cross
        }

        if checkDraw() {
            alertMessage = "Draw"
            showAlert = true
        }
    }
    
    func checkDraw() -> Bool {
        for row in board {
            for cell in row {
                if cell.tile == Tile.Empty {
                    return false
                }
            }
        }
        return true
    }

    func checkWin() -> Bool {
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0) {
            return true
        } else if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1) {
            return true
        } else if isTurnTile(0, 2) && isTurnTile(1, 2) && isTurnTile(2, 2) {
            return true
        } else if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {
            return true
        } else if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {
            return true
        } else if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {
            return true
        } else {
            return false
        }
    }

    func isTurnTile(_ row: Int, _ col: Int) -> Bool {
        return board[row][col].tile == turn
    }

    func resetBoard() {
        var newBoard = [[Cell]]()

        for _ in 0...2 {
            var row = [Cell]()
            for _ in 0...2 {
                row.append(Cell(tile: Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
