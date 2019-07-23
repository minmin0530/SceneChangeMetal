//
//  Scene2.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

import MetalKit

struct Rotation {
    var axis: float3
    var angle: Float
    var speed: Float
}
struct Position {
    var x: Float
    var y: Float
    var z: Float
}
struct Original {
    var position: vector_float3
}

class Scene2: BaseScene {
    var editCube: [[Original]] = []
    var originalDataCursor: [[Original]] = []
    var originalDataCube: [[Original]] = []
    
    var editData: [Cube] = []
    var cursorData: [BebelCube] = []
    var cubeData:[Cube] = []
    
    var translateDataCube: [Position] = []
    var translateDataCursor: [Position] = []
    var translateDataEdit: [Position] = []
    
//    public let device: MTLDevice
//    let commandQueue: MTLCommandQueue
    
    var dynamicUniformBufferArrayEdit: [MTLBuffer]?
    var dynamicUniformBufferArrayCube: [MTLBuffer]?
    var dynamicUniformBufferArrayCursor: [MTLBuffer]?
    
    //    var dynamicUniformBuffer: MTLBuffer
//    var pipelineState: MTLRenderPipelineState
    //    var colorMap: MTLTexture
    
    let inFlightSemaphore = DispatchSemaphore(value: maxBuffersInFlight)
    
    var uniformBufferOffset = 0
    
    var uniformBufferIndex = 0
    
    var uniformsArrayEdit: [UnsafeMutablePointer<Uniforms>]?
    var uniformsArrayCube: [UnsafeMutablePointer<Uniforms>]?
    var uniformsArrayCursor: [UnsafeMutablePointer<Uniforms>]?
    //    var uniforms: UnsafeMutablePointer<Uniforms>
    
    var projectionMatrix: matrix_float4x4 = matrix_float4x4()
    
    var rotation: Float = 0
    
    //    var mesh: MTKMesh
    
    
    
    
//    var depthState2: MTLDepthStencilState
    //    var uniforms2: UnsafeMutablePointer<Uniforms>
    //    var dynamicUniformBuffer2: MTLBuffer
//    var mtlVertexDescriptor2: MTLVertexDescriptor
    let MAX_SIZE = 8

    let EYE_X_DEFAULT: Float = 16.0
    let EYE_Y_DEFAULT: Float =  8.0
    let EYE_Z_DEFAULT: Float = 16.0
    var EYE_X: Float = 16.0
    var EYE_Y: Float =  8.0
    var EYE_Z: Float = 16.0
    let TARGET_X: Float = 16.0
    let TARGET_Y: Float = -8.0
    let TARGET_Z: Float = 0.0
    var cameraAngle: Float = 135.0

    
    var eye   : float3// = float3(EYE_X, EYE_Y, EYE_Z)
    var target: float3// = float3(0.0, TARGET_Y, 0.0)
    var light : float3// = float3(0.0, 0.0, 0.0)
    var lightSpeed : float3// = float3(1.0, 10.0, 1.0)
    
    let farZ:Float = 1000.0
    let fov:Float = 60.0

    var colorSpeedR:Float = 0.1
    var colorSpeedG:Float = 0.1
    var colorSpeedB:Float = 0.1
    var sizeSpeedX:Float = 1.0
    var sizeSpeedY:Float = 1.0
    var sizeSpeedZ:Float = 1.0
    
    var editColorR:Float = 0.0
    var editColorG:Float = 0.0
    var editColorB:Float = 0.0
    
    var editSizeX:Float = 1.0
    var editSizeY:Float = 1.0
    var editSizeZ:Float = 1.0

    override init(metalKitView: MTKView) {
        eye = float3(EYE_X, EYE_Y, EYE_Z)
        target = float3(0.0, TARGET_Y, 0.0)
        light = float3(0.0, 0.0, 0.0)
        lightSpeed = float3(1.0, 10.0, 1.0)

        for x in 0..<8 {
            for y in 0..<8 {
                for z in 0..<8 {
                    translateDataCursor.append( Position(x: Float(x), y: Float(y), z: Float(z)) )
                    originalDataCursor.append( [Original(position: [0.0,0.0,0.0])] )
                    cursorData.append( BebelCube(r:1.0,g:0.0,b:0.0,a:0.0,sx:1.0,sy:1.0,sz:1.0) )
                }
            }
        }
        cursorData[0].setColor(r: 1.0, g: 0.0, b: 0.0, a: 1.0)

        for x in 0..<MAX_SIZE {
            for y in 0..<MAX_SIZE {
                for z in 0..<MAX_SIZE {
                    cubeData.append(Cube(r: 0.0, g: 1.0, b: 0.0, a: 0.0, sx: 1.0, sy: 1.0, sz: 1.0))
                    translateDataCube.append(Position(x:Float(x) - Float(MAX_SIZE/2),y:Float(y) - Float(MAX_SIZE/2),z:Float(z) - Float(MAX_SIZE/2)))
                    originalDataCube.append([Original(position: [0.0,0.0,0.0])])
                }
            }
        }

        let uniformBufferSize = alignedUniformsSize * maxBuffersInFlight
        
        
        dynamicUniformBufferArrayCursor = []
        uniformsArrayCursor = []
        for i in 0..<originalDataCursor.count {
            dynamicUniformBufferArrayCursor?.append((metalKitView.device?.makeBuffer(length:uniformBufferSize, options:[MTLResourceOptions.storageModeShared])!)!)
            dynamicUniformBufferArrayCursor![i].label = "UniformBufferCursor"
            uniformsArrayCursor?.append(UnsafeMutableRawPointer(dynamicUniformBufferArrayCursor![i].contents()).bindMemory(to:Uniforms.self, capacity:1) )
        }
        
        
        dynamicUniformBufferArrayCube = []
        uniformsArrayCube = []
        for i in 0..<originalDataCube.count {
            dynamicUniformBufferArrayCube?.append((metalKitView.device?.makeBuffer(length:uniformBufferSize, options:[MTLResourceOptions.storageModeShared])!)!)
            dynamicUniformBufferArrayCube![i].label = "UniformBufferCube"
            uniformsArrayCube?.append(UnsafeMutableRawPointer(dynamicUniformBufferArrayCube![i].contents()).bindMemory(to:Uniforms.self, capacity:1) )
        }
        
        
        dynamicUniformBufferArrayEdit = []
        uniformsArrayEdit = []
        for i in 0..<editCube.count {
            dynamicUniformBufferArrayEdit?.append((metalKitView.device?.makeBuffer(length:uniformBufferSize, options:[MTLResourceOptions.storageModeShared])!)!)
            dynamicUniformBufferArrayEdit![i].label = "UniformBufferEdit"
            uniformsArrayEdit?.append(UnsafeMutableRawPointer(dynamicUniformBufferArrayEdit![i].contents()).bindMemory(to:Uniforms.self, capacity:1) )
        }

        
        
        
        super.init(metalKitView: metalKitView)

        self.mtkView = metalKitView
        
        
        buttonDelete.addTarget(self, action: #selector(deleteButton), for: .touchDown)
        buttonDelete.setTitle("Delete", for: UIControl.State.normal)
        buttonDelete.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonDelete.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonDelete)
        
        buttonEnter.addTarget(self, action: #selector(enterButton), for: .touchDown)
        buttonEnter.setTitle("Enter", for: UIControl.State.normal)
        buttonEnter.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonEnter.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonEnter)
        
        buttonLeft.addTarget(self, action: #selector(leftButton), for: .touchDown)
        buttonLeft.setTitle("Left", for: UIControl.State.normal)
        buttonLeft.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonLeft.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonLeft)
        
        buttonRight.addTarget(self, action: #selector(rightButton), for: .touchDown)
        buttonRight.setTitle("Right", for: UIControl.State.normal)
        buttonRight.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonRight.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonRight)
        
        buttonUp.addTarget(self, action: #selector(upButton), for: .touchDown)
        buttonUp.setTitle("Up", for: UIControl.State.normal)
        buttonUp.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonUp.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonUp)
        
        buttonDown.addTarget(self, action: #selector(downButton), for: .touchDown)
        buttonDown.setTitle("Down", for: UIControl.State.normal)
        buttonDown.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonDown.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonDown)
        
        buttonFront.addTarget(self, action: #selector(frontButton), for: .touchDown)
        buttonFront.setTitle("Front", for: UIControl.State.normal)
        buttonFront.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonFront.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonFront)
        
        buttonBack.addTarget(self, action: #selector(backButton), for: .touchDown)
        buttonBack.setTitle("Back", for: UIControl.State.normal)
        buttonBack.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonBack.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonBack)
        
        buttonColorR.addTarget(self, action: #selector(colorRButton), for: .touchDown)
        buttonColorR.setTitle("ColorR", for: UIControl.State.normal)
        buttonColorR.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonColorR.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonColorR)
        buttonColorG.addTarget(self, action: #selector(colorGButton), for: .touchDown)
        buttonColorG.setTitle("ColorG", for: UIControl.State.normal)
        buttonColorG.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonColorG.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonColorG)
        buttonColorB.addTarget(self, action: #selector(colorBButton), for: .touchDown)
        buttonColorB.setTitle("ColorB", for: UIControl.State.normal)
        buttonColorB.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonColorB.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonColorB)
        buttonColorD.addTarget(self, action: #selector(colorDButton), for: .touchDown)
        buttonColorD.setTitle("ColorD", for: UIControl.State.normal)
        buttonColorD.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonColorD.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonColorD)
        
        buttonSizeX.addTarget(self, action: #selector(sizeXButton), for: .touchDown)
        buttonSizeX.setTitle("sizeX", for: UIControl.State.normal)
        buttonSizeX.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonSizeX.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonSizeX)
        buttonSizeY.addTarget(self, action: #selector(sizeYButton), for: .touchDown)
        buttonSizeY.setTitle("sizeY", for: UIControl.State.normal)
        buttonSizeY.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonSizeY.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonSizeY)
        buttonSizeZ.addTarget(self, action: #selector(sizeZButton), for: .touchDown)
        buttonSizeZ.setTitle("sizeZ", for: UIControl.State.normal)
        buttonSizeZ.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonSizeZ.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonSizeZ)
        buttonSizeD.addTarget(self, action: #selector(sizeDButton), for: .touchDown)
        buttonSizeD.setTitle("sizeD", for: UIControl.State.normal)
        buttonSizeD.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonSizeD.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonSizeD)
        
        buttonCursorD.addTarget(self, action: #selector(cursorDButton), for: .touchDown)
        buttonCursorD.setTitle("cursorD", for: UIControl.State.normal)
        buttonCursorD.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonCursorD.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonCursorD)
        buttonCameraD.addTarget(self, action: #selector(cameraDButton), for: .touchDown)
        buttonCameraD.setTitle("cameraD", for: UIControl.State.normal)
        buttonCameraD.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonCameraD.backgroundColor = UIColor.blue
        metalKitView.addSubview(buttonCameraD)
        
        
        let pinchGestureRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.onPinchGesture(_:)))
        metalKitView.addGestureRecognizer(pinchGestureRecognizer)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(gesture:)))
        rightSwipe.direction = .right
        metalKitView.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.didSwipe(gesture:)))
        leftSwipe.direction = .left
        metalKitView.addGestureRecognizer(leftSwipe)
        
        buttonScene.addTarget(self, action: #selector(sceneButton), for: .touchDown)
        buttonScene.setTitle("Scene", for: UIControl.State.normal)
        buttonScene.setTitleColor(UIColor.red, for: UIControl.State.normal)
        buttonScene.backgroundColor = UIColor.blue
        mtkView?.addSubview(buttonScene)
        

    }
    
    @objc func sceneButton(sender: UIButton){
        changeScene = Scene.opening
        print("changeScene")
    }
    var buttonScene:  UIButton = UIButton(frame: CGRect(x: 300, y: 700, width: 70, height: 30))

    var buttonDelete: UIButton = UIButton(frame: CGRect(x:   0, y: 700, width: 70, height: 30))
    var buttonEnter:  UIButton = UIButton(frame: CGRect(x: 200, y: 700, width: 70, height: 30))
    var buttonLeft:   UIButton = UIButton(frame: CGRect(x:   0, y: 500, width: 70, height: 30))
    var buttonRight:  UIButton = UIButton(frame: CGRect(x:  75, y: 500, width: 70, height: 30))
    var buttonUp:     UIButton = UIButton(frame: CGRect(x:  40, y: 450, width: 70, height: 30))
    var buttonDown:   UIButton = UIButton(frame: CGRect(x:  40, y: 550, width: 70, height: 30))
    var buttonFront:  UIButton = UIButton(frame: CGRect(x: 200, y: 450, width: 70, height: 30))
    var buttonBack:   UIButton = UIButton(frame: CGRect(x: 200, y: 550, width: 70, height: 30))
    
    var buttonColorR: UIButton = UIButton(frame: CGRect(x:   0, y: 300, width: 70, height: 30))
    var buttonColorG: UIButton = UIButton(frame: CGRect(x: 100, y: 300, width: 70, height: 30))
    var buttonColorB: UIButton = UIButton(frame: CGRect(x: 200, y: 300, width: 70, height: 30))
    var buttonColorD: UIButton = UIButton(frame: CGRect(x: 300, y: 300, width: 70, height: 30))
    var buttonSizeX:  UIButton = UIButton(frame: CGRect(x:   0, y: 350, width: 70, height: 30))
    var buttonSizeY:  UIButton = UIButton(frame: CGRect(x: 100, y: 350, width: 70, height: 30))
    var buttonSizeZ:  UIButton = UIButton(frame: CGRect(x: 200, y: 350, width: 70, height: 30))
    var buttonSizeD:  UIButton = UIButton(frame: CGRect(x: 300, y: 350, width: 70, height: 30))
    
    var buttonCursorD:  UIButton = UIButton(frame: CGRect(x: 300, y: 550, width: 80, height: 30))
    var buttonCameraD:  UIButton = UIButton(frame: CGRect(x: 300, y: 650, width: 80, height: 30))
    
    //    var buttonLongLeft:  UIButton = UIButton(frame: CGRect(x:   0, y: 700, width: 70, height: 30))
    //    var buttonLongRight: UIButton = UIButton(frame: CGRect(x: 200, y: 700, width: 70, height: 30))
    
    @objc func deleteButton(sender: UIButton){
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    let x = Int(translateDataCursor[zz + yy * 8 + xx * 64].x) + MAX_SIZE/2
                    let y = Int(translateDataCursor[zz + yy * 8 + xx * 64].y) + MAX_SIZE/2
                    let z = Int(translateDataCursor[zz + yy * 8 + xx * 64].z) + MAX_SIZE/2
                    
                    cubeData[z + y * MAX_SIZE + x * MAX_SIZE * MAX_SIZE].setColor(r: editColorR, g: editColorG, b: editColorB, a: 0.0)
                }
            }
        }
    }
    
    @objc func enterButton(sender: UIButton){
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    let x = Int(translateDataCursor[zz + yy * 8 + xx * 64].x) + MAX_SIZE/2
                    let y = Int(translateDataCursor[zz + yy * 8 + xx * 64].y) + MAX_SIZE/2
                    let z = Int(translateDataCursor[zz + yy * 8 + xx * 64].z) + MAX_SIZE/2
                    
                    cubeData[z + y * MAX_SIZE + x * MAX_SIZE * MAX_SIZE].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func leftButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].x -= 1.0
                }
            }
        }
    }
    @objc func rightButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].x += 1.0
                }
            }
        }
    }
    @objc func upButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].y += 1.0
                }
            }
        }
    }
    @objc func downButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].y -= 1.0
                }
            }
        }
    }
    @objc func frontButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].z -= 1.0
                }
            }
        }
    }
    @objc func backButton(sender: UIButton){
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].z += 1.0
                }
            }
        }
    }
    @objc func colorRButton(sender: UIButton){
        editColorR += colorSpeedR
        if editColorR > 1.0 {
            editColorR = 1.0
            colorSpeedR *= -1
        }
        if editColorR < 0.0 {
            editColorR = 0.0
            colorSpeedR *= -1
        }
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    cursorData[zz + yy * 8 + xx * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func colorGButton(sender: UIButton){
        editColorG += colorSpeedG
        if editColorG > 1.0 {
            editColorG = 1.0
            colorSpeedG *= -1
        }
        if editColorG < 0.0 {
            editColorG = 0.0
            colorSpeedG *= -1
        }
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    cursorData[zz + yy * 8 + xx * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func colorBButton(sender: UIButton){
        editColorB += colorSpeedB
        if editColorB > 1.0 {
            editColorB = 1.0
            colorSpeedB *= -1
        }
        if editColorB < 0.0 {
            editColorB = 0.0
            colorSpeedB *= -1
        }
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    cursorData[zz + yy * 8 + xx * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func colorDButton(sender: UIButton){
        editColorR = 0.0
        editColorG = 0.0
        editColorB = 0.0
        
        for xx in 0..<Int(editSizeX) {
            for yy in 0..<Int(editSizeY) {
                for zz in 0..<Int(editSizeZ) {
                    cursorData[zz + yy * 8 + xx * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    
    @objc func sizeXButton(sender: UIButton){
        editSizeX += sizeSpeedX
        if editSizeX > 6.0 {
            editSizeX = 6.0
            sizeSpeedX *= -1
        }
        if editSizeX < 1.0 {
            editSizeX = 1.0
            sizeSpeedX *= -1
        }
        
        for x in 0..<8 {
            for y in 0..<8 {
                for z in 0..<8 {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 0.0)
                }
            }
        }
        
        for x in 0..<Int(editSizeX) {
            for y in 0..<Int(editSizeY) {
                for z in 0..<Int(editSizeZ) {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func sizeYButton(sender: UIButton){
        editSizeY += sizeSpeedY
        if editSizeY > 6.0 {
            editSizeY = 6.0
            sizeSpeedY *= -1
        }
        if editSizeY < 1.0 {
            editSizeY = 1.0
            sizeSpeedY *= -1
        }
        for x in 0..<8 {
            for y in 0..<8 {
                for z in 0..<8 {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 0.0)
                }
            }
        }
        
        for x in 0..<Int(editSizeX) {
            for y in 0..<Int(editSizeY) {
                for z in 0..<Int(editSizeZ) {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func sizeZButton(sender: UIButton){
        editSizeZ += sizeSpeedZ
        if editSizeZ > 6.0 {
            editSizeZ = 6.0
            sizeSpeedZ *= -1
        }
        if editSizeZ < 1.0 {
            editSizeZ = 1.0
            sizeSpeedZ *= -1
        }
        for x in 0..<8 {
            for y in 0..<8 {
                for z in 0..<8 {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 0.0)
                }
            }
        }
        
        for x in 0..<Int(editSizeX) {
            for y in 0..<Int(editSizeY) {
                for z in 0..<Int(editSizeZ) {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    @objc func sizeDButton(sender: UIButton){
        editSizeX = 1.0
        editSizeY = 1.0
        editSizeZ = 1.0
        
        for x in 0..<8 {
            for y in 0..<8 {
                for z in 0..<8 {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 0.0)
                }
            }
        }
        
        for x in 0..<Int(editSizeX) {
            for y in 0..<Int(editSizeY) {
                for z in 0..<Int(editSizeZ) {
                    cursorData[z + y * 8 + x * 64].setColor(r: editColorR, g: editColorG, b: editColorB, a: 1.0)
                }
            }
        }
    }
    
    @objc func cursorDButton(sender: UIButton) {
        for xx in 0..<8 {
            for yy in 0..<8 {
                for zz in 0..<8 {
                    translateDataCursor[zz + yy * 8 + xx * 64].x = 0.0
                    translateDataCursor[zz + yy * 8 + xx * 64].y = 0.0
                    translateDataCursor[zz + yy * 8 + xx * 64].z = 0.0
                }
            }
        }
    }
    
    @objc func cameraDButton(sender: UIButton) {
        eye.x = EYE_X_DEFAULT
        eye.y = EYE_Y_DEFAULT
        eye.z = EYE_Z_DEFAULT
        EYE_X = EYE_X_DEFAULT
        EYE_Y = EYE_Y_DEFAULT
        EYE_Z = EYE_Z_DEFAULT
        cameraAngle = 135.0
    }
    
    @objc func onPinchGesture(_ sender: UIPinchGestureRecognizer) {
        var s: Float = 1.0
        if sender.scale > 1.0 {
            s = 1.05
        }
        if sender.scale < 1.0 {
            s = 0.95
        }
        eye.x *= s
        eye.y *= s
        eye.z *= s
        EYE_X *= s
        EYE_Y *= s
        EYE_Z *= s
    }
    
    
    @objc func didSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            cameraAngle += 30.0
        } else if gesture.direction == .left {
            cameraAngle -= 30.0
            
        }
    }
    
    
    var leftButtonFlag: Bool = false
    var rightButtonFlag: Bool = false
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

    
    
    
    
    
    
    
    override func draw(in view: MTKView, pipelineState: MTLRenderPipelineState, depthStencilState: MTLDepthStencilState) {
        light.x = translateDataCursor[0].x
        light.y = translateDataCursor[0].y
        light.z = translateDataCursor[0].z - 1000.0
        
        
        uniformBufferIndex = (uniformBufferIndex + 1) % maxBuffersInFlight
        uniformBufferOffset = alignedUniformsSize * uniformBufferIndex
        
        
        
        let aspect = Float(UIScreen.main.bounds.size.width) / Float(UIScreen.main.bounds.size.height)
        projectionMatrix = matrix_perspective_right_hand(fovyRadians: radians_from_degrees(fov), aspectRatio:aspect, nearZ: 0.1, farZ: farZ)
        let viewMatrix = matrix_lookAt(eye: eye, target: target, up:float3(0,1,0))
        
        for i in 0..<originalDataCube.count {
            uniformsArrayCube![i] = UnsafeMutableRawPointer(dynamicUniformBufferArrayCube![i].contents() + uniformBufferOffset).bindMemory(to:Uniforms.self, capacity:1)
            uniformsArrayCube![i][0].projectionMatrix = projectionMatrix
            let translateMatrix = matrix4x4_translation(translateDataCube[i].x,translateDataCube[i].y,translateDataCube[i].z)
            uniformsArrayCube![i][0].modelViewMatrix = simd_mul(viewMatrix, translateMatrix)
            uniformsArrayCube![i][0].lightPosition = light
        }
        
        for i in 0..<originalDataCursor.count {
            uniformsArrayCursor![i] = UnsafeMutableRawPointer(dynamicUniformBufferArrayCursor![i].contents() + uniformBufferOffset).bindMemory(to:Uniforms.self, capacity:1)
            uniformsArrayCursor![i][0].projectionMatrix = projectionMatrix
            let translateMatrix = matrix4x4_translation(translateDataCursor[i].x,translateDataCursor[i].y,translateDataCursor[i].z)
            uniformsArrayCursor![i][0].modelViewMatrix = simd_mul(viewMatrix, translateMatrix)
            uniformsArrayCursor![i][0].lightPosition = light
        }
        
        for i in 0..<editCube.count {
            uniformsArrayEdit![i] = UnsafeMutableRawPointer(dynamicUniformBufferArrayEdit![i].contents() + uniformBufferOffset).bindMemory(to:Uniforms.self, capacity:1)
            uniformsArrayEdit![i][0].projectionMatrix = projectionMatrix
            let translateMatrix = matrix4x4_translation(translateDataEdit[i].x,translateDataEdit[i].y,translateDataEdit[i].z)
            uniformsArrayEdit![i][0].modelViewMatrix = simd_mul(viewMatrix, translateMatrix)
            uniformsArrayEdit![i][0].lightPosition = light
        }
        
//        if leftButtonFlag {
//            cameraAngle += 10.0
//        }
//        if rightButtonFlag {
//            cameraAngle -= 10.0
//        }
        let angle = radians_from_degrees(cameraAngle)
        eye.x = cos(angle) * EYE_X + sin(angle) * EYE_Z
        eye.z = sin(angle) * EYE_X - cos(angle) * EYE_Z
        
        
        view.device = MTLCreateSystemDefaultDevice()
        guard let device = view.device else {
            NSLog("Failed to create Metal device")
            return
        }
        guard let drawable = view.currentDrawable else {
            return
        }
        
        let commandQueue = view.device?.makeCommandQueue()
        let commandBuffer = commandQueue?.makeCommandBuffer()
        
        
        
        // let pointsBuffer =
        var vertexBufferCube :[MTLBuffer] = []
        for i in 0..<cubeData.count {
            vertexBufferCube.append(device.makeBuffer(bytes: cubeData[i].vertexData, length: 82 * cubeData[i].vertexData.count, options:[])!)
        }
        var vertexBufferCursor :[MTLBuffer] = []
        for i in 0..<cursorData.count {
            vertexBufferCursor.append(device.makeBuffer(bytes: cursorData[i].vertexData, length: 82 * cursorData[i].vertexData.count, options:[])!)
        }
        var vertexBufferEdit :[MTLBuffer] = []
        for i in 0..<editData.count {
            vertexBufferEdit.append(device.makeBuffer(bytes: editData[i].vertexData, length: 82 * editData[i].vertexData.count, options:[])!)
        }
        
        
        var originalBufferEdit: [MTLBuffer] = []
        var originalBufferCube: [MTLBuffer] = []
        var originalBufferCursor: [MTLBuffer] = []
        
        for data in editCube {
            originalBufferEdit.append( device.makeBuffer(bytes: data, length: 16, options:[])! )
        }
        for data in originalDataCube {
            originalBufferCube.append( device.makeBuffer(bytes: data, length: 16, options:[])! )
        }
        for data in originalDataCursor {
            originalBufferCursor.append( device.makeBuffer(bytes: data, length: 16, options:[])! )
        }
        //            device.makeBuffer(bytes: originalData2, length: 16 * originalData2.count, options:[]),
        //            device.makeBuffer(bytes: originalData3, length: 16 * originalData3.count, options:[]),
        //        ]
        
        //            do {
        //                let renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor[i])
        guard let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(1.0, 1.0, 0.0, 1.0)
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        
        
        
        renderCommandEncoder?.setRenderPipelineState(pipelineState)
        renderCommandEncoder?.setDepthStencilState(depthStencilState)
        
        //                for data in originalBufferPoints {
        //                    renderCommandEncoder?.setVertexBuffer(pointsBuffer, offset: 0, index: 0)
        //                    renderCommandEncoder?.setVertexBuffer(dynamicUniformBufferPoint, offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
        //                    renderCommandEncoder?.setVertexBuffer(data, offset:0, index: BufferIndex.originalPositions.rawValue)
        //    //                renderCommandEncoder?.setCullMode(MTLCullMode.front)
        //                    //            renderCommandEncoder?.setFragmentBuffer(dynamicUniformBuffer, offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
        //                    renderCommandEncoder?.drawPrimitives(type: .point, vertexStart: 0, vertexCount: 64, instanceCount: 64)
        //                }
        var i = 0
        for data in originalBufferCube {
            renderCommandEncoder?.setVertexBuffer(vertexBufferCube[i], offset: 0, index: 0)
            renderCommandEncoder?.setVertexBuffer(dynamicUniformBufferArrayCube![i], offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
            renderCommandEncoder?.setVertexBuffer(data, offset:0, index: BufferIndex.originalPositions.rawValue)
            renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 36, instanceCount: 12)
            i += 1
        }
        
        i = 0
        for data in originalBufferCursor {
            renderCommandEncoder?.setVertexBuffer(vertexBufferCursor[i], offset: 0, index: 0)
            renderCommandEncoder?.setVertexBuffer(dynamicUniformBufferArrayCursor![i], offset:uniformBufferOffset, index: BufferIndex.uniforms.rawValue)
            renderCommandEncoder?.setVertexBuffer(data, offset:0, index: BufferIndex.originalPositions.rawValue)
            renderCommandEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 132, instanceCount: 44)
            i += 1
        }
        
        
        
        renderCommandEncoder?.endEncoding()
        
        
        commandBuffer?.present(_: drawable)
        commandBuffer?.commit()

        
    }
    override func setSize(size: CGSize) {
        windowSize = size
    }

}
