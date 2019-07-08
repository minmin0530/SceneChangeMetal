//
//  Shaders.metal
//  SceneChangeMetal
//
//  Created by Yoshiki Izumi on 2019/07/04.
//  Copyright © 2019 Yoshiki Izumi. All rights reserved.
//

// File for Metal kernel and shader functions

#include <metal_stdlib>
#include <simd/simd.h>

// Including header shawhite_edge between this Metal shader code and Swift/C code executing Metal API commands
#import "ShaderTypes.h"

using namespace metal;


//struct Vertex {
//    float4 position [[attribute(VertexAttributePosition)]];
//    float4 color [[attribute(VertexAttributeColor)]];
//};
struct InOut {
    float4 position [[position]];
    float4 color;
    float3 normal;
};

struct InOut2 {
    float4 position [[position]];
    float pointSize [[point_size]];
    float4 color;
    float3 normal;
    float3 light;
};

vertex InOut2 vertex_func(constant InOut *vertices [[buffer(0)]],
                          uint vid [[vertex_id]],
                          constant Uniforms & uniforms [[ buffer(1) ]],
                          constant OriginalPositions & origins [[ buffer(2) ]]
                          ) {
    InOut2 out;
    out.position = uniforms.projectionMatrix * uniforms.modelViewMatrix * (vertices[vid].position + float4(origins.position, 1.0));
    out.color = vertices[vid].color;
    out.normal = ( uniforms.projectionMatrix * uniforms.modelViewMatrix * float4(vertices[vid].normal, 1.0) ).xyz;
    out.light = uniforms.lightPosition;
    out.pointSize = 8.0;
    return out;//vertices[vid];
}

vertex InOut2 vertex_func2(constant InOut *vertices [[buffer(0)]],
                           uint vid [[vertex_id]],
                           constant Uniforms & uniforms [[ buffer(1) ]],
                           constant OriginalPositions & origins [[ buffer(2) ]]
                           ) {
    InOut2 out;
    out.position = uniforms.projectionMatrix * uniforms.modelViewMatrix * (vertices[vid].position + float4(origins.position, 1.0));
    out.color = vertices[vid].color;
    out.normal = ( uniforms.projectionMatrix * uniforms.modelViewMatrix * float4(vertices[vid].normal, 1.0) ).xyz;
    out.light = uniforms.lightPosition;
    return out;//vertices[vid];
}

fragment float4 fragment_func(InOut2 vert [[stage_in]]) {
    // float4 outColor = float4(vert.color.r, vert.color.g, vert.color.b, 1);
    float3 lightColor = float3(0.5, 0.5, 0.5);
    //    float3 light = normalize(vert.light);
    float3 halfway = normalize(vert.light.xyz + vert.position.xyz);
    //    float specular = pow(max(dot(vert.normal, halfway), 0.0), 5);
    
    float directional = max(dot(normalize(vert.light) , vert.normal), 0.0);
    // directional = directional / normalize(vert.light);
    //    directional *= 5;
    float3 vLighting = vert.color.rgb;// + (lightColor * (directional ));
    if (vert.color.a == 0.0) {
        discard_fragment();
    }
    return float4(vLighting, vert.color.a);
    
    
    
    
    //    return vert.color;
}


fragment float4 fragment_func2(InOut2 vert [[stage_in]]) {
    // float4 outColor = float4(vert.color.r, vert.color.g, vert.color.b, 1);
    float3 lightColor = float3(0.5, 0.5, 0.5);
    //    float3 light = normalize(vert.light);
    float3 halfway = normalize(vert.light.xyz + vert.position.xyz);
    //    float specular = pow(max(dot(vert.normal, halfway), 0.0), 5);
    
    float directional = max(dot(normalize(vert.light) , vert.normal), 0.0);
    // directional = directional / normalize(vert.light);
    //    directional *= 5;
    float3 vLighting = vert.color.rgb;// + (lightColor * (directional ));
    if (vert.color.a == 0.0) {
        discard_fragment();
    }
    
    return float4(vLighting, vert.color.a);
    
    
    
    
    //    return vert.color;
}
/*
 typedef struct
 {
 float3 position [[attribute(VertexAttributePosition)]];
 float2 texCoord [[attribute(VertexAttributeTexcoord)]];
 } Vertex;
 
 typedef struct
 {
 float4 position [[position]];
 float2 texCoord;
 } ColorInOut;
 
 vertex ColorInOut vertexShader(Vertex in [[stage_in]],
 constant Uniforms & uniforms [[ buffer(BufferIndexUniforms) ]])
 {
 ColorInOut out;
 
 float4 position = float4(in.position, 1.0);
 out.position = uniforms.projectionMatrix * uniforms.modelViewMatrix * position;
 out.texCoord = in.texCoord;
 
 return out;
 }
 
 fragment float4 fragmentShader(ColorInOut in [[stage_in]],
 constant Uniforms & uniforms [[ buffer(BufferIndexUniforms) ]],
 texture2d<half> colorMap     [[ texture(TextureIndexColor) ]])
 {
 constexpr sampler colorSampler(mip_filter::linear,
 mag_filter::linear,
 min_filter::linear);
 
 half4 colorSample   = colorMap.sample(colorSampler, in.texCoord.xy);
 
 return float4(colorSample);
 }
 */
