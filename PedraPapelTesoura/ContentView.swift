//
//  ContentView.swift
//  PedraPapelTesoura
//
//  Created by Eduardo Hoffmann on 19/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var opcoes = ["pedra", "papel", "tesoura"]
    @State private var opcaoCorreta = Int.random(in: 0...2)
    @State private var imageName = "padrao"
    @State private var scoreTitle = ""
    @State private var cont: Int = 0
    @State private var nulo: Int = 0
    @State private var contError: Int = 0
    @State private var time: Timer?
    @State private var currentRound = 0
    @State private var maxRound = 9
    @State private var showingAlert = false
   
    
    @State private var showingScore = false
    @State private var endGameAlert = false
    
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .ignoresSafeArea()
            VStack() {
                
                Section(){
                    Text("O aplicativo escolheu:")
                        .font(.system(size: 22, weight: .heavy, design: .default))
                        .foregroundColor(Color.brown)
                    if endGameAlert == true {
                        Image(opcoes[opcaoCorreta]).resizable().frame(width: 180.0, height: 180.0)
                    } else {
                        Image(imageName).resizable().frame(width: 180.0, height: 180.0)
                    }
                }
                
                VStack(){
                    Section(){
                        
                        HStack(){
                            
                            ForEach (0..<3) { number in
                                Button {
                                    opcaoTocada(number)
                                } label: {
                                    Image(opcoes[number])
                                        .resizable().frame(width: 120.0, height: 120.0)
                                }
                                
                            }
                        }
                    } header: {
                        Text("Escolha sua jogada:")
                            .foregroundColor(Color.brown)
                            .font(.system(size: 20, weight: .heavy, design: .default))
                    }
                }
                .padding(80)
                VStack() {
                    HStack{
                        Spacer(minLength: 2)
                        Label("\(cont)", systemImage: "checkmark").foregroundColor(.green)
                        Spacer()
                        Label("\(contError)", systemImage: "xmark").foregroundColor(.red)
                        Spacer(minLength: 2)
                        
                    }
                    VStack{
                        Label("\(nulo)", systemImage: "equal").foregroundColor(.yellow)
                        
                    }
                    
                }
                .font(.system(size: 30, weight: .heavy, design: .default))
            }
            .alert(isPresented: $endGameAlert) {
                Alert(title: Text("Fim do jogo!"), message: Text("Sua pontuação final foi \(cont)/10"), dismissButton: .default(Text("Jogar novamente")) {
                    resetGame()
                })
                
            }
            
        }
    }
    
    func opcaoTocada(_ number: Int) {
        imageName = opcoes[opcaoCorreta]
        
        if number == opcaoCorreta {
            nulo += 1
        } else if number == 0 && opcaoCorreta == 2 {
            cont += 1
        } else if number == 0 && opcaoCorreta == 1 {
            contError += 1
        } else if number == 1 && opcaoCorreta == 0 {
            cont += 1
        } else if number == 1 && opcaoCorreta == 2 {
            contError += 1
        } else if number == 2 && opcaoCorreta == 0 {
            contError += 1
        } else if number == 2 && opcaoCorreta == 1 {
            cont += 1
        }
       
       
        
        showingScore = true
        
        endGameAlert = currentRound == maxRound
            // score = 0        // reset this at the "Restart" call
            // currentRound = 0 // reset this at the "Restart" call
            
            if currentRound < maxRound {
                currentRound += 1
               // minimo -= 1
            }
            showingAlert = true
        
        self.askQuestion()
        
        
    }
    
    
    func askQuestion() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { time in
            imageName = "padrao"
            
        })
        opcaoCorreta = Int.random(in: 0...2)
    }
    
    
    func resetGame() {
        cont = 0
        contError = 0
        nulo = 0
        endGameAlert = false
        currentRound = 0
        maxRound = 9
        showingAlert = false
        showingScore = false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
