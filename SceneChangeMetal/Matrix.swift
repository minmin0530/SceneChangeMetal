//
//  Matrix.swift
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

import simd

// Generic matrix math utility functions
func matrix4x4_rotation(radians: Float, axis: float3) -> matrix_float4x4 {
    let unitAxis = normalize(axis)
    let ct = cosf(radians)
    let st = sinf(radians)
    let ci = 1 - ct
    let x = unitAxis.x, y = unitAxis.y, z = unitAxis.z
    return matrix_float4x4.init(columns:(vector_float4(    ct + x * x * ci, y * x * ci + z * st, z * x * ci - y * st, 0),
                                         vector_float4(x * y * ci - z * st,     ct + y * y * ci, z * y * ci + x * st, 0),
                                         vector_float4(x * z * ci + y * st, y * z * ci - x * st,     ct + z * z * ci, 0),
                                         vector_float4(                  0,                   0,                   0, 1)))
}

func matrix4x4_translation(_ translationX: Float, _ translationY: Float, _ translationZ: Float) -> matrix_float4x4 {
    return matrix_float4x4.init(columns:(vector_float4(1, 0, 0, 0),
                                         vector_float4(0, 1, 0, 0),
                                         vector_float4(0, 0, 1, 0),
                                         vector_float4(translationX, translationY, translationZ, 1)))
}

func matrix_perspective_right_hand(fovyRadians fovy: Float, aspectRatio: Float, nearZ: Float, farZ: Float) -> matrix_float4x4 {
    let ys = 1 / tanf(fovy * 0.5)
    let xs = ys / aspectRatio
    let zs = farZ / (nearZ - farZ)
    return matrix_float4x4.init(columns:(vector_float4(xs,  0, 0,   0),
                                         vector_float4( 0, ys, 0,   0),
                                         vector_float4( 0,  0, zs, -1),
                                         vector_float4( 0,  0, zs * nearZ, 0)))
}

func matrix_lookAt(eye: float3, target: float3, up: float3) -> matrix_float4x4 {
    var m = [
        Float(1.0), Float(0.0), Float(0.0), Float(0.0),
        Float(0.0), Float(1.0), Float(0.0), Float(0.0),
        Float(0.0), Float(0.0), Float(1.0), Float(0.0),
        Float(0.0), Float(0.0), Float(0.0), Float(1.0),
    ]
    var l = Float(0.0)
    var t = [Float(0.0), Float(0.0), Float(0.0)]
    t[0] = eye[0] - target[0]
    t[1] = eye[1] - target[1]
    t[2] = eye[2] - target[2]
    var tt = t[0]*t[0]+t[1]*t[1]+t[2]*t[2]
    l = sqrt(tt)
    m[ 2] = t[0] / l
    m[ 6] = t[1] / l;
    m[10] = t[2] / l;
    
    
    t[0] = up[1] * m[10] - up[2] * m[ 6];
    t[1] = up[2] * m[ 2] - up[0] * m[10];
    t[2] = up[0] * m[ 6] - up[1] * m[ 2];
    tt = t[0]*t[0]+t[1]*t[1]+t[2]*t[2]
    l = sqrt(tt);
    m[0] = t[0] / l;
    m[4] = t[1] / l;
    m[8] = t[2] / l;
    
    
    m[1] = m[ 6] * m[8] - m[10] * m[4];
    m[5] = m[10] * m[0] - m[ 2] * m[8];
    m[9] = m[ 2] * m[4] - m[ 6] * m[0];
    
    m[12] = -(eye[0] * m[0] + eye[1] * m[4] + eye[2] * m[ 8]);
    m[13] = -(eye[0] * m[1] + eye[1] * m[5] + eye[2] * m[ 9]);
    m[14] = -(eye[0] * m[2] + eye[1] * m[6] + eye[2] * m[10]);
    
    return matrix_float4x4.init(columns:(vector_float4(m[0], m[1], m[2], m[3]),
                                         vector_float4(m[4], m[5], m[6], m[7]),
                                         vector_float4(m[8], m[9], m[10], m[11]),
                                         vector_float4(m[12], m[13], m[14], m[15])))
}

func radians_from_degrees(_ degrees: Float) -> Float {
    return (degrees / 180) * .pi
}
