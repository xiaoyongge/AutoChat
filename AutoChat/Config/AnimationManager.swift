import SwiftUI

class AnimationManager: ObservableObject {
    static let shared = AnimationManager()
    
    private init() {}
    
    // 基础动画持续时间
    let defaultDuration: Double = 0.3
    let longDuration: Double = 0.5
    let shortDuration: Double = 0.15
    
    // 常用动画曲线
    let defaultEasing = Animation.easeInOut
    let springEasing = Animation.spring(response: 0.3, dampingFraction: 0.8)
    let bounceEasing = Animation.spring(response: 0.5, dampingFraction: 0.6)
    
    // 消息气泡动画
    var messageBubbleTransition: Animation {
        .spring(response: 0.4, dampingFraction: 0.7)
    }
    
    // 列表项动画
    var listItemTransition: Animation {
        .easeInOut(duration: defaultDuration)
    }
    
    // 模态视图转场动画
    var modalTransition: Animation {
        .spring(response: 0.35, dampingFraction: 0.85)
    }
    
    // 加载动画
    var loadingRotation: Animation {
        .linear(duration: 1.0)
            .repeatForever(autoreverses: false)
    }
    
    // 按钮点击动画
    var buttonTapScale: Animation {
        .spring(response: 0.2, dampingFraction: 0.5)
    }
    
    // 渐显动画
    func fadeIn(delay: Double = 0) -> Animation {
        .easeIn(duration: defaultDuration)
        .delay(delay)
    }
    
    // 渐隐动画
    func fadeOut(delay: Double = 0) -> Animation {
        .easeOut(duration: defaultDuration)
        .delay(delay)
    }
    
    // 滑入动画
    func slideIn(edge: Edge, delay: Double = 0) -> Animation {
        .spring(response: 0.3, dampingFraction: 0.8)
        .delay(delay)
    }
    
    // 缩放动画
    func scale(duration: Double = 0.3, delay: Double = 0) -> Animation {
        .spring(response: duration, dampingFraction: 0.7)
        .delay(delay)
    }
}

// 视图扩展，添加常用动画修饰符
extension View {
    func fadeInOut(isPresented: Bool) -> some View {
        self.opacity(isPresented ? 1 : 0)
            .animation(isPresented ? AnimationManager.shared.fadeIn() : AnimationManager.shared.fadeOut(), value: isPresented)
    }
    
    func slideTransition(edge: Edge = .trailing) -> some View {
        self.transition(AnyTransition.slide.animation(AnimationManager.shared.slideIn(edge: edge)))
    }
    
    func scaleOnTap() -> some View {
        self.scaleEffect(1.0)
            .animation(AnimationManager.shared.buttonTapScale, value: true)
    }
}