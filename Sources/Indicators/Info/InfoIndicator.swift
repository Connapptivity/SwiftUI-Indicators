//
//  InfoIndicator.swift
//  Indicators
//
//  Created by Marlo Kessler on 09.07.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct InfoIndicator: Indicator {
    
    
    
    // MARK: - Initializer
    public init() {}
    
    private init(
                 _ foregroundColor: Color?,
                 _ lineWidth: CGFloat,
                 _ pace: Double,
                 _ animated: Bool,
                 _ customAnimation: Animation?
                 ) {
        self.foregroundColor = foregroundColor ?? .white
        self.lineWidth = lineWidth
        self.pace = pace
        self.animated = animated
        self.customAnimation = customAnimation
    }
    
    
    
    // MARK: - Variables
    private var foregroundColor: Color = .white
    private var lineWidth: CGFloat = 5
    private var pace: Double = 1.5
    private var animated: Bool = true
    private var customAnimation: Animation?
    
    
    
    @State private var progress: Double = 0
    
    private var animation: Animation {
        return Animation.easeInOut(duration: pace)
    }
    
    private var style: StrokeStyle {
        return StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
    }
    
    
    
    // MARK: - Methods
    private func initAnimation() {
        guard animated else {
            progress = 1
            return
        }
        progress = 0
        withAnimation(customAnimation ?? animation) {
            self.progress = 1
        }
    }
    
    // APIs
    public func foregroundColor(_ color: Color?) -> Self {
        return InfoIndicator(color, lineWidth, pace, animated, customAnimation)
    }
    
    public func lineWidth(_ width: Double) -> Self {
        return InfoIndicator(foregroundColor, CGFloat(width), pace, animated, customAnimation)
    }
    
    public func pace(_ pace: Double) -> Self {
        return InfoIndicator(foregroundColor, lineWidth, pace, animated, customAnimation)
    }
    
    public func animated(_ animated: Bool = true) -> Self {
        return InfoIndicator(foregroundColor, lineWidth, pace, animated, customAnimation)
    }
    
    public func animation(_ animation: Animation?) -> Self {
        return InfoIndicator(foregroundColor, lineWidth, pace, animated, animation)
    }
    
    
    
    // MARK:- View
    public var body: some View {
        InfoShape(self.progress)
                .stroke(self.foregroundColor, style: self.style)
                .onAppear {
                    self.initAnimation()
        }
    }
}
