//
//  Scene1.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

import MetalKit

class Scene1: BaseScene {
    var buttonEnter:  UIButton = UIButton(frame: CGRect(x: 200, y: 700, width: 70, height: 30))

    override init(metalKitView: MTKView) {
        super.init(metalKitView: metalKitView)
        self.mtkView = metalKitView
        
        
        buttonEnter.addTarget(self, action: #selector(enterButton), for: .touchDown)
        buttonEnter.setTitle("Edit", for: UIControl.State.normal)
        buttonEnter.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonEnter.layer.borderWidth = 2.0
        buttonEnter.layer.borderColor = UIColor.red.cgColor
        buttonEnter.layer.cornerRadius = 5.0
        buttonEnter.backgroundColor = UIColor.blue

        mtkView?.addSubview(buttonEnter)

    }
    
    @objc func enterButton(sender: UIButton){
        changeScene = 1
        print("enter")
    }
    
    override func draw(in view: MTKView, pipelineState: MTLRenderPipelineState, depthStencilState: MTLDepthStencilState) {
//        view.device = MTLCreateSystemDefaultDevice()
//        guard let device = view.device else {
//            NSLog("Failed to create Metal device")
//            return
//        }
        guard let drawable = view.currentDrawable else {
            return
        }
        
        let commandQueue = view.device?.makeCommandQueue()
        let commandBuffer = commandQueue?.makeCommandBuffer()

        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 0.0, 1.0)
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        
        
        renderCommandEncoder?.setRenderPipelineState(pipelineState)
        renderCommandEncoder?.setDepthStencilState(depthStencilState)

        renderCommandEncoder?.endEncoding()
        
        
        commandBuffer?.present(_: drawable)
        commandBuffer?.commit()

    }
    override func setSize(size: CGSize) {
        windowSize = size
        
        buttonEnter.frame.origin.x = size.width / 4 - 70.0 / 2.0
    }
}
