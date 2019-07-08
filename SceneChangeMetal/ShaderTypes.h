//
//  ShaderTypes.h
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

//
//  Header containing types and enum constants shared between Metal shaders and Swift/ObjC source
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#ifdef __METAL_VERSION__
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define NSInteger metal::int32_t
#else
#import <Foundation/Foundation.h>
#endif

#include <simd/simd.h>

typedef NS_ENUM(NSInteger, BufferIndex)
{
    BufferIndexMeshPositions = 0,
    //    BufferIndexMeshGenerics  = 1,
    BufferIndexUniforms      = 1,
    
    BufferIndexOriginalPositions = 2,
};

typedef NS_ENUM(NSInteger, VertexAttribute)
{
    VertexAttributePosition  = 0,
    VertexAttributeColor  = 1,
};

typedef NS_ENUM(NSInteger, TextureIndex)
{
    TextureIndexColor    = 0,
};

typedef struct
{
    matrix_float4x4 projectionMatrix;
    matrix_float4x4 modelViewMatrix;
    vector_float3   lightPosition;
} Uniforms;

typedef struct
{
    vector_float3 position;
} OriginalPositions;

#endif /* ShaderTypes_h */

