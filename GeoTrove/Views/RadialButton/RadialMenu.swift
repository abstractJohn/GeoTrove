//
//  RadialMenu.swift
//  GeoTrove
//
//  Created by John Nelson on 3/31/24.
//  Special thanks to Paul Hudson at Hacking with Swift
//

import SwiftUI

struct RadialButton {
    var label: String
    var image: Image
    var action: () -> Void
}

struct RadialMenu: View {
    var title: String
    let closedImage: Image
    let openImage: Image
    let buttons: [RadialButton]
    var direction = Angle(degrees: 315)
    var range = Angle(degrees: 90)
    var distance = 100.0
    var animation = Animation.default
    @State private var isExpanded = false
    @State private var isShowingSheet = false
    let touchFeedback = UIImpactFeedbackGenerator(style: .medium)
    init(title: String, closedImage: Image, openImage: Image, buttons: [RadialButton], direction: Angle = Angle(degrees: 315), range: Angle = Angle(degrees: 90), distance: Double = 100.0, animation: SwiftUI.Animation = Animation.default, isExpanded: Bool = false, isShowingSheet: Bool = false) {
        self.title = title
        self.closedImage = closedImage
        self.openImage = openImage
        self.buttons = buttons
        self.direction = direction
        self.range = range
        self.distance = distance
        self.animation = animation
        self.isExpanded = isExpanded
        self.isShowingSheet = isShowingSheet
        touchFeedback.prepare()
    }
    var body: some View {
        ZStack {
            Button {
                if UIAccessibility.isVoiceOverRunning {
                    isShowingSheet.toggle()
                } else {
                    withAnimation(animation) {
                        isExpanded.toggle()
                    }
                }
                touchFeedback.impactOccurred()
            } label: {
                isExpanded ? openImage : closedImage
            }
            .accessibility(label: Text(title))

            ForEach(0..<buttons.count, id: \.self) { i in
                Button {
                    buttons[i].action()
                    isExpanded.toggle()
                } label: {
                    buttons[i].image
                }
                .accessibility(hidden: isExpanded == false)
                .accessibility(label: Text(buttons[i].label))
                .offset(offset(for: i))
            }
            .opacity(isExpanded ? 1 : 0)
        }
        .actionSheet(isPresented: $isShowingSheet) {
            ActionSheet(title: Text(title), buttons:
                            buttons.map { btn in
                    ActionSheet.Button.default(Text(btn.label), action: btn.action)
                } + [.cancel()]
            )
        }
    }

    func offset(for index: Int) -> CGSize {
        guard isExpanded else { return .zero }
        let buttonAngle = range.radians / Double(buttons.count - 1)
        let ourAngle = buttonAngle * Double(index)
        let finalAngle = direction - (range / 2) + Angle(radians: ourAngle)
        let finalX = cos(finalAngle.radians - .pi / 2) * distance
        let finalY = sin(finalAngle.radians - .pi / 2) * distance
        return CGSize(width: finalX, height: finalY)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title)
            .background(Color.blue.opacity(configuration.isPressed ? 0.5 : 1))
            .clipShape(Circle())
            .foregroundColor(.white)
    }
}

#Preview {
    RadialMenu(title: "Example", closedImage: Image(systemName: "plus"), openImage: Image(systemName: "multiply"), buttons: [RadialButton(label: "Example Button", image: Image(systemName: "globe"), action: {})])
}
