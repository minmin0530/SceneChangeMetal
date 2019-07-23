//
//  BaseScene.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

import MetalKit

class BaseScene {
    var mtkView: MTKView?
    var changeScene:Scene = Scene.opening
    var windowSize: CGSize?
    init(metalKitView: MTKView) {
    }
    
    func draw(in view: MTKView, pipelineState: MTLRenderPipelineState, depthStencilState: MTLDepthStencilState) {
    }
    
    func setSize(size: CGSize) {
    }
}
