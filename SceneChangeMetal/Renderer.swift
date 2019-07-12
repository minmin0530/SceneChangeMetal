//
//  Renderer.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

// Our platform independent renderer class

import Metal
import MetalKit

// The 256 byte aligned size of our uniform structure
let alignedUniformsSize = (MemoryLayout<Uniforms>.size & ~0xFF) + 0x100

let maxBuffersInFlight = 3

enum RendererError: Error {
    case badVertexDescriptor
}

class Renderer: NSObject, MTKViewDelegate {
    
    public let device: MTLDevice
    let commandQueue: MTLCommandQueue
//    var dynamicUniformBuffer: MTLBuffer
    var pipelineState: MTLRenderPipelineState
    var depthState: MTLDepthStencilState
//    var colorMap: MTLTexture
    var mtlVertexDescriptor: MTLVertexDescriptor
    
    var projectionMatrix: matrix_float4x4 = matrix_float4x4()
    
    var rotation: Float = 0
    
//    var mesh: MTKMesh
    
    var buttonEnter:  UIButton = UIButton(frame: CGRect(x: 200, y: 700, width: 70, height: 30))

    var scene: BaseScene?
    var mtkView: MTKView?
    init?(metalKitView: MTKView) {
        self.device = metalKitView.device!
        self.commandQueue = self.device.makeCommandQueue()!
        
        metalKitView.depthStencilPixelFormat = MTLPixelFormat.depth32Float_stencil8
        metalKitView.colorPixelFormat = MTLPixelFormat.bgra8Unorm_srgb
        metalKitView.sampleCount = 1
        
        let depthStateDesciptor = MTLDepthStencilDescriptor()
        depthStateDesciptor.depthCompareFunction = MTLCompareFunction.less
        depthStateDesciptor.isDepthWriteEnabled = true
        self.depthState = self.device.makeDepthStencilState(descriptor:depthStateDesciptor)!
        mtlVertexDescriptor = MTLVertexDescriptor()
        
        
        do {
            pipelineState = try Renderer.buildRenderPipelineWithDevice(device: device,
                                                                       metalKitView: metalKitView,
                                                                       mtlVertexDescriptor: mtlVertexDescriptor)
        } catch {
            print("Unable to compile render pipeline state.  Error info: \(error)")
            return nil
        }
        
        super.init()

        mtkView = metalKitView
        scene = SceneStage4(metalKitView: metalKitView)
        scene?.setSize(size: mtkView!.drawableSize)

    }
 
    
    @objc func enterButton(sender: UIButton){
        print("enter")
    }

    
    class func buildRenderPipelineWithDevice(device: MTLDevice,
                                             metalKitView: MTKView,
                                             mtlVertexDescriptor: MTLVertexDescriptor) throws -> MTLRenderPipelineState {
        /// Build a render state pipeline object
        
        let library = device.makeDefaultLibrary()
        
        let vertexFunction = library?.makeFunction(name: "vertex_func")
        let fragmentFunction = library?.makeFunction(name: "fragment_func")
        
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        pipelineDescriptor.label = "RenderPipeline"
        pipelineDescriptor.sampleCount = metalKitView.sampleCount
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = mtlVertexDescriptor
        
        pipelineDescriptor.colorAttachments[0].pixelFormat = metalKitView.colorPixelFormat
        pipelineDescriptor.colorAttachments[0].isBlendingEnabled = true
        pipelineDescriptor.colorAttachments[0].rgbBlendOperation = MTLBlendOperation.add
        pipelineDescriptor.colorAttachments[0].alphaBlendOperation = MTLBlendOperation.add
        pipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = MTLBlendFactor.sourceAlpha
        pipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = MTLBlendFactor.sourceAlpha
        pipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = MTLBlendFactor.oneMinusSourceAlpha
        pipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = MTLBlendFactor.oneMinusSourceAlpha
        pipelineDescriptor.depthAttachmentPixelFormat = metalKitView.depthStencilPixelFormat
        pipelineDescriptor.stencilAttachmentPixelFormat = metalKitView.depthStencilPixelFormat
        
        return try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    }
    
    func removeSubViews(mtkView: MTKView) {
        let subviews = mtkView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    func draw(in view: MTKView) {
        /// Per frame updates hare
        scene?.draw(in: view, pipelineState: pipelineState, depthStencilState: depthState)
        
//        _ = inFlightSemaphore.wait(timeout: DispatchTime.distantFuture)
//
//        if let commandBuffer = commandQueue.makeCommandBuffer() {
//
//            let semaphore = inFlightSemaphore
//            commandBuffer.addCompletedHandler { (_ commandBuffer)-> Swift.Void in
//                semaphore.signal()
//            }
        if scene?.changeScene == 1 {
            removeSubViews(mtkView: view)
            scene = Scene2(metalKitView: scene!.mtkView!)
            scene?.setSize(size: view.drawableSize)
            scene?.changeScene = 0
        }
        if scene?.changeScene == 2 {
            removeSubViews(mtkView: view)
            scene = SceneStage1(metalKitView: scene!.mtkView!)
            scene?.setSize(size: view.drawableSize)
            scene?.changeScene = 0
        }
        if scene?.changeScene == 3 {
            removeSubViews(mtkView: view)
            scene = Scene1(metalKitView: scene!.mtkView!)
            scene?.setSize(size: view.drawableSize)
            scene?.changeScene = 0
        }
        if scene?.changeScene == 4 {
            removeSubViews(mtkView: view)
            scene = SceneStage2(metalKitView: scene!.mtkView!)
            scene?.setSize(size: view.drawableSize)
            scene?.changeScene = 0
        }
        if scene?.changeScene == 5 {
            removeSubViews(mtkView: view)
            scene = SceneStage3(metalKitView: scene!.mtkView!)
            scene?.setSize(size: view.drawableSize)
            scene?.changeScene = 0
        }

    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        /// Respond to drawable size or orientation changes here
        scene?.setSize(size: size)
        let aspect = Float(size.width) / Float(size.height)
        projectionMatrix = matrix_perspective_right_hand(fovyRadians: radians_from_degrees(65), aspectRatio:aspect, nearZ: 0.1, farZ: 100.0)
    }
}
