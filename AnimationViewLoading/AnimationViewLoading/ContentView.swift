
import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var offsets: [CGSize] = Array(repeating: .zero, count: 3)
    
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    
    @State var delayTime: Double = 0
    
    var locations: [CGSize] = [
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: -110, height: 0),
        CGSize(width: 110, height: 110),
        CGSize(width: 110, height: -110),
        CGSize(width: -110, height: -110),
        CGSize(width: 0, height: 110),
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0)
    
    ]
    
    var body: some View {
        ZStack {
            Color(.blue)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color(.red))
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .offset(offsets[0])
                    
                }
                .frame(width: 210, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color(.purple))
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .offset(offsets[1])
                    Rectangle()
                        .fill(Color(.yellow))
                        .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .offset(offsets[2])
                    
                }
            }
        }
        .onAppear(perform: doAnimation)
        .onReceive(timer, perform: { _ in
            print("reDo Animation")
            delayTime = 0
            doAnimation()
        })
    }
    
    func doAnimation() {
        
        var tempOffsets: [[CGSize]] = []
        var currentSet: [CGSize] = []
        for value in locations {
            currentSet.append(value)
            
            if currentSet.count == 3 {
                tempOffsets.append(currentSet)
                currentSet.removeAll()
            }
        }
        
        if !currentSet.isEmpty {
            tempOffsets.append(currentSet)
            currentSet.removeAll()
        }
        
        for offset in tempOffsets {
            for index in offset.indices{
                doAnimation(delay: .now() + delayTime, value: offset[index], index: index)
                delayTime += 0.3
            }
        }
        
    }
    func doAnimation(delay: DispatchTime, value: CGSize, index: Int) {
        DispatchQueue.main.asyncAfter(deadline: delay) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.offsets[index] = value
            }
        }
    }
    
}

// Just cancel timer when new pages open or closed
