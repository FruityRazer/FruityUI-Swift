//
//  Reactive.swift
//  FruityUI
//
//  Created by Eduardo Almeida on 09/05/2020.
//  Copyright © 2020 Eduardo Almeida. All rights reserved.
//

import ColorPicker
import FruityKit
import SwiftUI

struct Reactive: View {
    @State var speed: Int = 1
    @State var color: FruityKit.Color? = nil
    
    @Binding var mode: Synapse2Handle.Mode?
    
    private func updateMode() {
        if let color = color {
            mode = .reactive(speed: speed, color: color)
        } else {
            mode = nil
        }
    }
    
    var body: some View {
        let speedFieldBinding = Binding<String>(
            get: { String(self.speed) },
            set: {
                self.speed = Int($0)!
                
                self.updateMode()
            }
        )
        
        let colorBinding = Binding<FruityKit.Color?>(
            get: { self.color },
            set: {
                self.color = $0
                
                self.updateMode()
            }
        )
        
        return VStack {
            GroupBox(label: Text("Speed")) {
                TextField("", text: speedFieldBinding)
            }
            
            GroupBox(label: Text("Color")) {
                CompleteColorPicker(selectedColor: colorBinding)
            }
        }
    }
}

struct Reactive_Previews: PreviewProvider {
    static var previews: some View {
        Reactive(mode: .constant(nil))
    }
}
