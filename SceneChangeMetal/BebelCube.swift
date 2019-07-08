//
//  BebelCube.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

class BebelCube {
    
    var vertexData = [
        // vertex ////////
        Vertex2(position: [xlp, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysp, zlp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xsp, ylp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xlp, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysp, zlm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xlm, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xsp, ylm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xlp, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xlm, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xsm, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xlm, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlp, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xlp, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        
        Vertex2(position: [xsm, ylm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xlm, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlm, 1.0], color: white_edge, normal: [1.0, 1.0, 1.0]),
        // vertex ////////
        
        // edge /////////
        Vertex2(position: [xsp, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlp, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlp, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlp, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsp, ylp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsp, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        
        Vertex2(position: [xlm, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsm, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlm, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsm, ylp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlm, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsm, ylp, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        
        Vertex2(position: [xlp, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsp, ylm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsp, ylm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsp, ylm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlp, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlp, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        
        Vertex2(position: [xsm, ylm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlm, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlm, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xlm, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsm, ylm, zsm, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        Vertex2(position: [xsm, ylm, zsp, 1.0], color: white_edge, normal: [1.0, 1.0, 0.0]),
        
        Vertex2(position: [xsp, ysp, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylp, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylp, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylp, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        
        Vertex2(position: [xlp, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsp, ysp, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlp, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlp, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        
        Vertex2(position: [xsp, ysp, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlp, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlp, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlp, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        
        Vertex2(position: [xsp, ylm, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysm, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylm, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylm, zsp, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        
        Vertex2(position: [xsp, ysm, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylm, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylm, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ylm, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        
        Vertex2(position: [xlm, ysp, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlm, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlm, ysm, zsm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlm, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        
        Vertex2(position: [xsm, ysp, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlm, ysp, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlm, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xlm, ysm, zsp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsm, ysm, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlp, 1.0], color: white_edge, normal: [1.0, 0.0, 1.0]),
        
        Vertex2(position: [xsp, ylp, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysp, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylp, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ysp, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsm, ylp, zsm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        Vertex2(position: [xsp, ysp, zlm, 1.0], color: white_edge, normal: [0.0, 1.0, 1.0]),
        
        // face ////////
        Vertex2(position: [ 1.0,  1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [-1.0,  1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [ 1.0, -1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [ 1.0, -1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [-1.0,  1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [-1.0, -1.0, zlp, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        
        
        Vertex2(position: [-1.0, ylp,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [ 1.0, ylp,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [ 1.0, ylp, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [-1.0, ylp,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [ 1.0, ylp, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [-1.0, ylp, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        
        Vertex2(position: [xlp,  1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlp,  1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlp, -1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlp,  1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlp, -1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlp, -1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        
        Vertex2(position: [-1.0,  1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [ 1.0,  1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [ 1.0, -1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [-1.0,  1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [ 1.0, -1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        Vertex2(position: [-1.0, -1.0, zlm, 0.0], color: white_face, normal: [0.0, 0.0, 1.0]),
        
        Vertex2(position: [ 1.0, ylm,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [-1.0, ylm,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [ 1.0, ylm, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [ 1.0, ylm, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [-1.0, ylm,  1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        Vertex2(position: [-1.0, ylm, -1.0, 0.0], color: white_face, normal: [0.0, 1.0, 0.0]),
        
        Vertex2(position: [xlm,  1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlm,  1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlm, -1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlm, -1.0,  1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlm,  1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        Vertex2(position: [xlm, -1.0, -1.0, 0.0], color: white_face, normal: [1.0, 0.0, 0.0]),
        
        
        ]
    
    init(r:Float,g:Float,b:Float,a:Float,sx:Float,sy:Float,sz:Float) {
        for i in 0..<vertexData.count - 36 {
            vertexData[i].color[0] = r
            vertexData[i].color[1] = g
            vertexData[i].color[2] = b
            vertexData[i].color[3] = a
            vertexData[i].position[0] *= sx
            vertexData[i].position[1] *= sy
            vertexData[i].position[2] *= sz
        }
        for i in (vertexData.count - 36)..<vertexData.count {
            vertexData[i].color[0] = r
            vertexData[i].color[1] = g
            vertexData[i].color[2] = b
            vertexData[i].color[3] = 0.0
            vertexData[i].position[0] *= sx
            vertexData[i].position[1] *= sy
            vertexData[i].position[2] *= sz
        }
        
    }
    func setColor(r:Float,g:Float,b:Float,a:Float) {
        for i in 0..<vertexData.count - 36 {
            vertexData[i].color[0] = r
            vertexData[i].color[1] = g
            vertexData[i].color[2] = b
            vertexData[i].color[3] = a
        }
    }
    func setSize(size:Float) {
        for i in 0..<vertexData.count {
            vertexData[i].position[0] *= size
            vertexData[i].position[1] *= size
            vertexData[i].position[2] *= size
        }
    }
    
}
