#ifndef _KLAK_LINEAR_GRADIENT_
#define _KLAK_LINEAR_GRADIENT_

//
// Note: The time parameter of the first key is offset by 10 when the gradient
// mode is set to Fixed.
//

typedef float4 LinearGradient[12];

float3 SampleLinearGradientColor(float4 grad[12], float x)
{
    float3 c = grad[0].xyz;
    float k0 = grad[0].w;

    float f = k0 > 1 ? 1e+5 : 1; // Gradient mode multiplier
    k0 = frac(k0);

    c = lerp(c, grad[1].xyz, saturate(f * (x - k0       ) / (grad[1].w - k0       )));
    c = lerp(c, grad[2].xyz, saturate(f * (x - grad[1].w) / (grad[2].w - grad[1].w)));
    c = lerp(c, grad[3].xyz, saturate(f * (x - grad[2].w) / (grad[3].w - grad[2].w)));
    c = lerp(c, grad[4].xyz, saturate(f * (x - grad[3].w) / (grad[4].w - grad[3].w)));
    c = lerp(c, grad[5].xyz, saturate(f * (x - grad[4].w) / (grad[5].w - grad[4].w)));
    c = lerp(c, grad[6].xyz, saturate(f * (x - grad[5].w) / (grad[6].w - grad[5].w)));
    c = lerp(c, grad[7].xyz, saturate(f * (x - grad[6].w) / (grad[7].w - grad[6].w)));
    return c;
}

float SampleLinearGradientAlpha(float4 grad[12], float x)
{
    float f = grad[0].w > 1 ? 1e+5 : 1; // Gradient mode multiplier

    float a = grad[8].x;
    a = lerp(a, grad[ 8].z, saturate(f * (x - grad[ 8].y) / (grad[ 8].w - grad[ 8].y)));
    a = lerp(a, grad[ 9].x, saturate(f * (x - grad[ 8].w) / (grad[ 9].y - grad[ 8].w)));
    a = lerp(a, grad[ 9].z, saturate(f * (x - grad[ 9].y) / (grad[ 9].w - grad[ 9].y)));
    a = lerp(a, grad[10].x, saturate(f * (x - grad[ 9].w) / (grad[10].y - grad[ 9].w)));
    a = lerp(a, grad[10].z, saturate(f * (x - grad[10].y) / (grad[10].w - grad[10].y)));
    a = lerp(a, grad[11].x, saturate(f * (x - grad[10].w) / (grad[11].y - grad[10].w)));
    a = lerp(a, grad[11].z, saturate(f * (x - grad[11].y) / (grad[11].w - grad[11].y)));
    return a;
}

float4 SampleLinearGradient(float4 grad[12], float x)
{
    return float4(SampleLinearGradientColor(grad, x),
                  SampleLinearGradientAlpha(grad, x));
}

#endif
