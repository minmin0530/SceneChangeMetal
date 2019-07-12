//
//  SceneStage3.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/10.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//
import MetalKit

class SceneStage3 : BaseScene {
    var character = Character()
    var characterPosition = float3(5.0,0.0,-8.0)
    var enemy = Enemy1()
    var enemyPosition = float3(10.0,0.0,-8.0)
    
    
    var stage = Stage()
    
    var hurdleData:[Cube] = [
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:1.0,g:0.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        
        
        
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        Cube(r:0.0,g:1.0,b:0.0,a:1.0,sx:1.0,sy:1.0,sz:1.0),
        
        ]
    var translateDataHurdle: [Position] = [
        Position(x:GOAL_X/3.0 * 1.0 + 6.0,y: 0.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 7.0,y: 0.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 8.0,y: 0.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 12.0,y: 3.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 13.0,y: 3.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 14.0,y: 3.0,z: -8.0 ),
        
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 5.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 4.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 3.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 2.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 1.0,z: -8.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 0.0,z: -8.0 ),
        
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 5.0,z: -7.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 4.0,z: -7.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 3.0,z: -7.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 2.0,z: -7.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 1.0,z: -7.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 0.0,z: -7.0 ),
        
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 5.0,z: -6.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 4.0,z: -6.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 3.0,z: -6.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 2.0,z: -6.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 1.0,z: -6.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 0.0,z: -6.0 ),
        
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 5.0,z: -5.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 4.0,z: -5.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 3.0,z: -5.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 2.0,z: -5.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 1.0,z: -5.0 ),
        Position(x:GOAL_X/3.0 * 1.0 + 18.0,y: 0.0,z: -5.0 ),
        
        ]
    var originalDataHurdle: [[Original]] = [
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        [Original(position: [0.0,0.0,0.0])],
        
        ]
    var dynamicUniformBufferArrayHurdle: [MTLBuffer]?
    var uniformsArrayHurdle: [UnsafeMutablePointer<Uniforms>]?
    
    var projectionMatrix: matrix_float4x4 = matrix_float4x4()
    
    let inFlightSemaphore = DispatchSemaphore(value: maxBuffersInFlight)
    var uniformBufferOffset = 0
    var uniformBufferIndex = 0
    
    
    var eye   : float3 = float3(EYE_X, EYE_Y, EYE_Z)
    var target: float3 = float3(TARGET_X, TARGET_Y, TARGET_Z)
    var light : float3 = float3(0.0, 0.0, 0.0)
    
    var goalCount: Int = 0
    var labelGoal: UILabel = UILabel(frame: CGRect(x: 0, y: 300, width: 600, height: 200))
    
    var buttonJumpY:  UIButton = UIButton(frame: CGRect(x:   0, y: 600, width: 70, height: 30))
    var buttonJumpZ:  UIButton = UIButton(frame: CGRect(x:   0, y: 700, width: 70, height: 30))
    var buttonLeft :  UIButton = UIButton(frame: CGRect(x:   0, y: 650, width: 70, height: 30))
    var buttonRight:  UIButton = UIButton(frame: CGRect(x: 100, y: 650, width: 70, height: 30))
    
    var leftButtonFlag: Bool = false
    var rightButtonFlag: Bool = false
    
    override init(metalKitView: MTKView) {
        super.init(metalKitView: metalKitView)
        self.mtkView = metalKitView
        
        let uniformBufferSize = alignedUniformsSize * maxBuffersInFlight
        character.initUniform(device: metalKitView.device!, uniformBufferSize: uniformBufferSize)
        enemy.initUniform(device: metalKitView.device!, uniformBufferSize: uniformBufferSize)
        stage.initUniform(device: metalKitView.device!, uniformBufferSize: uniformBufferSize)
        
        dynamicUniformBufferArrayHurdle = []
        uniformsArrayHurdle = []
        for i in 0..<hurdleData.count {
            dynamicUniformBufferArrayHurdle?.append((metalKitView.device?.makeBuffer(length:uniformBufferSize, options:[MTLResourceOptions.storageModeShared])!)!)
            dynamicUniformBufferArrayHurdle![i].label = "UniformBufferHurdle"
            uniformsArrayHurdle?.append(UnsafeMutableRawPointer(dynamicUniformBufferArrayHurdle![i].contents()).bindMemory(to:Uniforms.self, capacity:1) )
        }
        
        
        
        let longPressLeft = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressLeft(gesture:)))
        longPressLeft.minimumPressDuration = 0.01
        buttonLeft.addGestureRecognizer(longPressLeft)
        buttonLeft.setTitle("Left", for: UIControl.State.normal)
        buttonLeft.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonLeft.backgroundColor = UIColor.white
        buttonLeft.layer.borderWidth = 2.0
        buttonLeft.layer.borderColor = UIColor.red.cgColor
        buttonLeft.layer.cornerRadius = 5.0
        metalKitView.addSubview(buttonLeft)
        
        
        let longPressRight = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressRight(gesture:)))
        longPressRight.minimumPressDuration = 0.01
        buttonRight.addGestureRecognizer(longPressRight)
        buttonRight.setTitle("Right", for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonRight.backgroundColor = UIColor.white
        buttonRight.layer.borderWidth = 2.0
        buttonRight.layer.borderColor = UIColor.red.cgColor
        buttonRight.layer.cornerRadius = 5.0
        metalKitView.addSubview(buttonRight)
        
        
        buttonJumpY.addTarget(self, action: #selector(jumpYButton), for: .touchDown)
        buttonJumpY.setTitle("jump", for: UIControl.State.normal)
        buttonJumpY.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonJumpY.backgroundColor = UIColor.white
        buttonJumpY.layer.borderWidth = 2.0
        buttonJumpY.layer.borderColor = UIColor.red.cgColor
        buttonJumpY.layer.cornerRadius = 5.0
        mtkView?.addSubview(buttonJumpY)
        buttonJumpZ.addTarget(self, action: #selector(jumpZButton), for: .touchDown)
        buttonJumpZ.setTitle("jump", for: UIControl.State.normal)
        buttonJumpZ.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonJumpZ.backgroundColor = UIColor.white
        buttonJumpZ.layer.borderWidth = 2.0
        buttonJumpZ.layer.borderColor = UIColor.red.cgColor
        buttonJumpZ.layer.cornerRadius = 5.0
        mtkView?.addSubview(buttonJumpZ)
        
        labelGoal.isHidden = true
        labelGoal.text = "GOAL!!"
        labelGoal.textColor = UIColor.red
        labelGoal.font = UIFont.boldSystemFont(ofSize: 128.0)
        mtkView?.addSubview(labelGoal)
        
    }
    
    @objc func longPressLeft(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            leftButtonFlag = true
        }
        if gesture.state == .ended {
            leftButtonFlag = false
        }
    }
    @objc func longPressRight(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            rightButtonFlag = true
        }
        if gesture.state == .ended {
            rightButtonFlag = false
        }
    }
    @objc func jumpYButton(sender: UIButton){
        character.jumpSpeed = 0.3
        
        //        changeScene = 3
        print("jumpY")
    }
    @objc func jumpZButton(sender: UIButton){
        character.jumpSpeedZ = 0.3
        //        changeScene = 3
        print("jumpZ")
    }
    
    override func draw(in view: MTKView, pipelineState: MTLRenderPipelineState, depthStencilState: MTLDepthStencilState) {
        
        if  enemy.live &&
            enemyPosition.x + 1.0 >= characterPosition.x + 0.0 &&
            enemyPosition.x       <= characterPosition.x + 1.0 &&
            enemyPosition.y + 1.0 >= characterPosition.y + 0.0 &&
            enemyPosition.y       <= characterPosition.y + 0.0 &&
            enemyPosition.z + 1.0 >= characterPosition.z + 0.0 &&
            enemyPosition.z       <= characterPosition.z + 0.0
        {
            enemy.live = false
            enemy.jumpSpeed = -0.1
            character.jumpSpeed = 0.3
        }
        if !enemy.live {
            if enemyPosition.y > -5.0 {
                enemyPosition.y += enemy.jumpSpeed
            }
        }
        
        
        var hitRightFlag = false
        for hurdle in translateDataHurdle {
            if  hurdle.x + 1.0 >= characterPosition.x + 1.0 &&
                hurdle.x       <= characterPosition.x + 1.0 &&
                hurdle.y + 1.0 >= characterPosition.y       &&
                hurdle.y       <= characterPosition.y       &&
                hurdle.z + 1.0 >= characterPosition.z       &&
                hurdle.z       <= characterPosition.z
            {
                hitRightFlag = true
            }
        }
        
        var hitLeftFlag = false
        for hurdle in translateDataHurdle {
            if  hurdle.x + 1.0 >= characterPosition.x &&
                hurdle.x       <= characterPosition.x &&
                hurdle.y + 1.0 >= characterPosition.y &&
                hurdle.y       <= characterPosition.y &&
                hurdle.z + 1.0 >= characterPosition.z &&
                hurdle.z       <= characterPosition.z
            {
                hitLeftFlag = true
            }
        }
        
        
        if leftButtonFlag && goalCount == 0 && !hitLeftFlag && characterPosition.x > -2.0 {
            characterPosition.x -= 0.1
            
            stage.updateLeft(characterPosition: characterPosition)
        }
        
        if rightButtonFlag && !hitRightFlag {
            characterPosition.x += 0.1
        }
        
        eye.x = characterPosition.x
        target.x = characterPosition.x
        
        characterPosition.y += character.jumpSpeed
        character.jumpSpeed -= character.gravity
        characterPosition.z += character.jumpSpeedZ
        character.jumpSpeedZ -= character.gravity
        if characterPosition.y < 0.0 {
            characterPosition.y = 0.0
            character.jumpSpeed = 0.0
        }
        if characterPosition.z < -8.0 {
            characterPosition.z = -8.0
            character.jumpSpeedZ = 0.0
        }
        
        if characterPosition.x > GOAL_X + Float(STAGE_WIDTH) {
            labelGoal.isHidden = false
            goalCount += 1
        }
        if (goalCount > 100) {
            changeScene = 3
        }
        if characterPosition.x > GOAL_X {
            stage.updateGoal(characterPosition: characterPosition)
        } else {
            stage.updateRight(characterPosition: characterPosition)
        }
        
        
        for hurdle in translateDataHurdle {
            if  hurdle.x + 1.0 >= characterPosition.x       &&
                hurdle.x       <= characterPosition.x + 1.0 &&
                hurdle.y + 1.0 >= characterPosition.y - 2.0 &&
                hurdle.y       <= characterPosition.y - 2.0 &&
                hurdle.z + 1.0 >= characterPosition.z       &&
                hurdle.z       <= characterPosition.z
            {
                characterPosition.y = hurdle.y + 3.0
                character.jumpSpeed = 0.0
            }
        }
        
        
        
        
        uniformBufferIndex = (uniformBufferIndex + 1) % maxBuffersInFlight
        uniformBufferOffset = alignedUniformsSize * uniformBufferIndex
        
        let aspect = Float(UIScreen.main.bounds.size.width) / Float(UIScreen.main.bounds.size.height)
        projectionMatrix = matrix_perspective_right_hand(fovyRadians: radians_from_degrees(fov), aspectRatio:aspect, nearZ: 0.1, farZ: farZ)
        let viewMatrix = matrix_lookAt(eye: eye, target: target, up:float3(0,1,0))
        
        
        for i in 0..<hurdleData.count {
            uniformsArrayHurdle![i] = UnsafeMutableRawPointer(dynamicUniformBufferArrayHurdle![i].contents() + uniformBufferOffset).bindMemory(to:Uniforms.self, capacity:1)
            projectionMatrix = matrix_perspective_right_hand(fovyRadians: radians_from_degrees(65), aspectRatio:aspect, nearZ: 0.1, farZ: 100.0)
            uniformsArrayHurdle![i][0].projectionMatrix = projectionMatrix
            let translateMatrix = matrix4x4_translation(translateDataHurdle[i].x,translateDataHurdle[i].y,translateDataHurdle[i].z)
            let viewMatrix = matrix_lookAt(eye: eye, target: target, up:float3(0,1,0))
            uniformsArrayHurdle![i][0].modelViewMatrix = simd_mul(viewMatrix, translateMatrix)
            uniformsArrayHurdle![i][0].lightPosition = light
        }
        
        
        
        view.device = MTLCreateSystemDefaultDevice()
        guard let device = view.device else {
            NSLog("Failed to create Metal device")
            return
        }
        guard let drawable = view.currentDrawable else {
            return
        }
        
        character.update(device: device, projectionMatrix: projectionMatrix, viewMatrix: viewMatrix, light: light, uniformBufferIndex: uniformBufferIndex, uniformBufferOffset: uniformBufferOffset, position: characterPosition)
        enemy.update(device: device, projectionMatrix: projectionMatrix, viewMatrix: viewMatrix, light: light, uniformBufferIndex: uniformBufferIndex, uniformBufferOffset: uniformBufferOffset, position: enemyPosition)
        stage.update(device: device, projectionMatrix: projectionMatrix, viewMatrix: viewMatrix, light: light, uniformBufferIndex: uniformBufferIndex, uniformBufferOffset: uniformBufferOffset, position: characterPosition)
        
        var vertexBufferHurdle :[MTLBuffer] = []
        for i in 0..<hurdleData.count {
            vertexBufferHurdle.append(device.makeBuffer(bytes: hurdleData[i].vertexData, length: 82 * hurdleData[i].vertexData.count, options:[])!)
        }
        var originalBufferHurdle: [MTLBuffer] = []
        for data in originalDataHurdle {
            originalBufferHurdle.append( device.makeBuffer(bytes: data, length: 16, options:[])! )
        }
        
        
        let commandQueue = view.device?.makeCommandQueue()
        let commandBuffer = commandQueue?.makeCommandBuffer()
        
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 1.0, 1.0)
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        
        
        renderCommandEncoder?.setRenderPipelineState(pipelineState)
        renderCommandEncoder?.setDepthStencilState(depthStencilState)
        
        
        
        
        var i = 0
        for data in vertexBufferHurdle {
            renderCommandEncoder?.setVertexBuffer(data, offset: 0, index: 0)
            renderCommandEncoder?.setVertexBuffer(dynamicUniformBufferArrayHurdle![i], offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
            renderCommandEncoder?.setVertexBuffer(originalBufferHurdle[i], offset:0, index: BufferIndex.originalPositions.rawValue)
            renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 36, instanceCount: 12)
            i += 1
        }
        
        character.draw(renderCommandEncoder: renderCommandEncoder!, uniformBufferOffset: uniformBufferOffset)
        enemy.draw(renderCommandEncoder: renderCommandEncoder!, uniformBufferOffset: uniformBufferOffset)
        stage.draw(renderCommandEncoder: renderCommandEncoder!, uniformBufferOffset: uniformBufferOffset)
        
        
        
        
        renderCommandEncoder?.endEncoding()
        
        
        commandBuffer?.present(_: drawable)
        commandBuffer?.commit()
        
    }
    
    override func setSize(size: CGSize) {
        windowSize = size
        buttonJumpY.frame.origin.x = size.width / 2 - 70.0
        buttonJumpZ.frame.origin.x = size.width / 2 - 70.0
    }
    
    
}
