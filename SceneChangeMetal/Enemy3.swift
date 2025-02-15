//
//  Enemy3.swift
//  SceneChangeMetal
//
//  Created by 泉芳樹 on 2019/07/16.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

import MetalKit

class Enemy3 {
    var live: Bool = true
    var jumpSpeed: Float = 0.0
    var gravity: Float = 0.01
    var spinData: [Rotation] = [
        // head
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        Rotation(axis: [ 0.0, 1.0, 0.0], angle: -70.0, speed: 0.0),
        /*        Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         
         // left hand
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         // right hand
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         
         // body
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         
         // left foot
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         // right foot
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         
         // tail
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),
         Rotation(axis: [ 0.0, 1.0, 0.0], angle: 0.0, speed: 0.01),*/
    ]
    
    
    var originalData: [[Original]] = [
        // head
        [Original(position: [ 0.0, 0.0,-1.0/3.0])],
        [Original(position: [ 0.0, 3.0/3.0, 4.0/3.0])],
        [Original(position: [ 0.0,-3.0/3.0, 4.0/3.0])],
        [Original(position: [ 2.0/3.0, 1.0/3.0, 5.0/3.0])],
        [Original(position: [-2.0/3.0, 1.0/3.0, 5.0/3.0])],
        [Original(position: [ 0.0,-1.0/3.0, 3.0/3.0])],
        [Original(position: [ 2.5/3.0, 3.5/3.0, 0.0])],
        [Original(position: [-2.5/3.0, 3.5/3.0, 0.0])],
        [Original(position: [ 3.1/3.0, 4.1/3.0, 0.6/3.0])],
        [Original(position: [-3.1/3.0, 4.1/3.0, 0.6/3.0])],
        
        /*        [Original(position: [-2.5/3.0, 4.7/3.0, -1.0/3.0])],
         [Original(position: [ 0.5, 3.7/3.0,  0.0])],
         [Original(position: [-0.5, 3.7/3.0,  0.0])],
         [Original(position: [ 0.0, 2.0/3.0,  0.0])],
         [Original(position: [ 0.0,-1.0/3.0,  0.0])],
         [Original(position: [ 0.5, 0.0,  1.0])],
         [Original(position: [-0.5, 0.0,  1.0])],
         [Original(position: [ 0.0,-1.0/3.0,  1.0])],
         
         // left hand
         [Original(position: [ 7.0/3.0, -1.0,  0.0])],
         // right hand
         [Original(position: [-7.0/3.0, -1.0,  0.0])],
         
         // body
         [Original(position: [ 0.0, -4.0/3.0,  0.0])],
         [Original(position: [ 0.0, -2.0,  0.0])],
         
         // left foot
         [Original(position: [ 4.0/3.0, -3.0,  1.0/3.0])],
         // right foot
         [Original(position: [-4.0/3.0, -3.0,  1.0/3.0])],
         
         // tail
         [Original(position: [ 0.0, -3.0,  -2.5/3.0])],
         [Original(position: [-0.8/3.0, -4.2,  -2.5/3.0])],
         [Original(position: [-4.0/3.0, -4.4,  -2.5/3.0])],
         [Original(position: [-6.0/3.0, -4.4,  -2.5/3.0])],
         */
    ]
    
    var translateData: [Position] = [
        // head
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        Position(x:0.0, y:5.0, z:-5.0),
        /*        Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         
         // left hand
         Position(x:0.0, y:5.0, z:-5.0),
         // right hand
         Position(x:0.0, y:5.0, z:-5.0),
         
         // body
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         
         // left foot
         Position(x:0.0, y:5.0, z:-5.0),
         // right foot
         Position(x:0.0, y:5.0, z:-5.0),
         
         // tail
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         Position(x:0.0, y:5.0, z:-5.0),
         */
    ]
    
    
    
    var cubeData = [
        // head
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:3.0/3.0,sy:4.0/3.0,sz:3.0/3.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:3.0/3.0,sy:1.0/3.0,sz:2.0/3.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:3.0/3.0,sy:1.0/3.0,sz:2.0/3.0),
        Cube(r:1.0,g:1.0,b:1.0,a:1.0,sx:1.0/3.0,sy:1.0/3.0,sz:1.0/3.0),
        Cube(r:1.0,g:1.0,b:1.0,a:1.0,sx:1.0/3.0,sy:1.0/3.0,sz:1.0/3.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0/3.0,sy:1.0/3.0,sz:1.0/3.0),
        Cube(r:1.0,g:1.0,b:1.0,a:1.0,sx:1.0/3.0,sy:1.0/3.0,sz:1.0/3.0),
        Cube(r:1.0,g:1.0,b:1.0,a:1.0,sx:1.0/3.0,sy:1.0/3.0,sz:1.0/3.0),
        Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:0.5/3.0,sz:0.5/3.0),
        Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:0.5/3.0,sz:0.5/3.0),
        
        /*        Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.7/3.0,sy:0.7/3.0,sz:0.7/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.7/3.0,sy:0.7/3.0,sz:0.7/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.7/3.0,sy:0.7/3.0,sz:0.7/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0/3.0,sz:1.0),
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:2.0/3.0,sz:1.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:1.0/3.0,sz:0.5/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:1.0/3.0,sz:0.5/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:0.5/3.0,sz:0.5/3.0),
         */
        /*        // left hand
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:2.0/3.0,sz:1.0),
         // right hand
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:2.0/3.0,sz:1.0),
         
         // body
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:2.0/3.0,sy:1.0/3.0,sz:2.0/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0/3.0,sz:1.0),
         
         // left foot
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:2.5/3.0,sy:2.5/3.0,sz:2.5/3.0),
         // right foot
         Cube(r:1.0,g:1.0,b:0.0,a:1.0,sx:2.5/3.0,sy:2.5/3.0,sz:2.5/3.0),
         
         // tail
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:3.0/3.0,sz:0.5/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:0.5/3.0,sy:0.5/3.0,sz:0.5/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:3.0/3.0,sy:0.5/3.0,sz:0.5/3.0),
         Cube(r:0.0,g:0.0,b:0.0,a:1.0,sx:1.5/3.0,sy:1.5/3.0,sz:1.5/3.0),
         */
    ]
    
    var vertexBuffer :[MTLBuffer]?
    var originalBuffer: [MTLBuffer]?
    
    var dynamicUniformBufferArray: [MTLBuffer]?
    var uniformsArray: [UnsafeMutablePointer<Uniforms>]?
    
    func initUniform(device: MTLDevice, uniformBufferSize: Int) {
        dynamicUniformBufferArray = []
        uniformsArray = []
        for i in 0..<originalData.count {
            dynamicUniformBufferArray?.append((device.makeBuffer(length:uniformBufferSize, options:[MTLResourceOptions.storageModeShared])!))
            dynamicUniformBufferArray![i].label = "UniformBufferCharacter"
            uniformsArray?.append(UnsafeMutableRawPointer(dynamicUniformBufferArray![i].contents()).bindMemory(to:Uniforms.self, capacity:1) )
        }
        
    }
    
    func update(device: MTLDevice, projectionMatrix: matrix_float4x4, viewMatrix: matrix_float4x4, light: float3, uniformBufferIndex: Int, uniformBufferOffset: Int, position: float3) {
        
        //        jumpSpeed -= gravity
        //        if translateData[0].y < 2.0 {
        //            jumpSpeed = 0.3
        //        }
        
        
        for i in 0..<originalData.count {
            uniformsArray![i] = UnsafeMutableRawPointer(dynamicUniformBufferArray![i].contents() + uniformBufferOffset).bindMemory(to:Uniforms.self, capacity:1)
            uniformsArray![i][0].projectionMatrix = projectionMatrix
            
            
            let spinMatrix = matrix4x4_rotation(radians: spinData[i].angle, axis: spinData[i].axis)
            let translateMatrix = matrix4x4_translation(translateData[i].x,translateData[i].y,translateData[i].z)
            //            uniformsArray![i][0].modelViewMatrix = simd_mul(viewMatrix, spinMatrix)
            uniformsArray![i][0].modelViewMatrix = simd_mul(viewMatrix, translateMatrix)
            uniformsArray![i][0].modelViewMatrix = simd_mul(uniformsArray![i][0].modelViewMatrix, spinMatrix)
            
            uniformsArray![i][0].lightPosition = light
            
            spinData[i].angle += spinData[i].speed
            
            //            if translateData[i].z < -10.0 {
            //                translateData[i].z = 10.0
            //            }
            //            if translateData[i].x > 5.0 {
            //                translateData[i].x = -5.0
            //            }
            //            if translateData[i].y > 10.0 {
            //                translateData[i].y = -10.0
            //            }
            translateData[i].x = position.x
            translateData[i].y = position.y
            translateData[i].z = position.z
        }
        
        vertexBuffer = []
        for i in 0..<cubeData.count {
            vertexBuffer?.append(device.makeBuffer(bytes: cubeData[i].vertexData, length: 82 * cubeData[i].vertexData.count, options:[])!)
        }
        
        originalBuffer = []
        for data in originalData {
            originalBuffer?.append( device.makeBuffer(bytes: data, length: 16, options:[])! )
        }
        
    }
    
    func draw(renderCommandEncoder: MTLRenderCommandEncoder, uniformBufferOffset: Int) {
        var i = 0
        for data in originalBuffer! {
            renderCommandEncoder.setVertexBuffer(vertexBuffer![i], offset: 0, index: 0)
            renderCommandEncoder.setVertexBuffer(dynamicUniformBufferArray![i], offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
            renderCommandEncoder.setVertexBuffer(data, offset:0, index: BufferIndex.originalPositions.rawValue)
            renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 36, instanceCount: 12)
            i += 1
        }
        
    }
}
