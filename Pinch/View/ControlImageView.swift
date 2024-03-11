//
//  ControlImageView.swift
//  Pinch
//
//  Created by Peyman Osatian on 2024-03-09.
//

import SwiftUI

struct ControlImageView: View {
    let icon : String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

#Preview {
    ControlImageView(icon: "minus.magnifyingglass")
       
}
