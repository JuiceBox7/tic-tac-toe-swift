import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    
    var body: some View {
        let borderSize = CGFloat(5)
        
        Text(gameState.turnText())
            .font(.title)
            .bold()
            .bold()
        Spacer()
        
        Text(String(format: "X: %d", gameState.crossScore))
            .font(.title)
            .bold()
            .bold()
        
        VStack(spacing: borderSize) {
            ForEach(0...2, id: \.self) {
                row in
                HStack(spacing: borderSize) {
                    ForEach(0...2, id: \.self) {
                        col in
                        let cell = gameState.board[row][col]
                        
                        Text(cell.displayTile())
                            .font(.system(size: 100))
                            .foregroundColor(cell.tileColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, col)
                            }
                    }
                }
            }
        }
        .background(Color.black)
        .padding()
        .alert(isPresented: $gameState.showAlert) {
            Alert(
                title: Text(gameState.alertMessage),
                dismissButton: .default(Text("Okay")) {
                    gameState.resetBoard()
                }
            )
        }
        Text(String(format: "O: %d", gameState.circleScore))
            .font(.title)
            .bold()
            .bold()
        Spacer()
    }
}

#Preview {
    ContentView()
}
