#ifndef ORGANIC_INCLUDED
#define ORGANIC_INCLUDED

float2x2 Get2DRotationMatrix(float angle)
{
    float c = cos(angle);
    float s = sin(angle);

    return float2x2(c, -s, s, c);
}

void GetAnimatedOrganicFractal_float(float scale, float scaleMultStep, float rotationStep, int iterations,float2 uv , float uvAnimationSpeed, float rippleStrength, float rippleMaxFrequency, float rippleSpeed, float brightness, out float Out)
{
    uv = float2(uv - 0.5) * 2.0;

    float2 n, q;
    float invertedRadialGradient = pow(length(uv), 2.0);

    float output = 0.0;
    float2x2 rotationMatrix = Get2DRotationMatrix(rotationStep);

    float t = _Time.y;
    float uvTime = t * uvAnimationSpeed;

    float ripples = sin((t * rippleSpeed) - (invertedRadialGradient * rippleMaxFrequency)) * rippleStrength;

    for (int i = 0; i < iterations; i++)
    {
        uv = mul(rotationMatrix, uv);
        n = mul(rotationMatrix, n);

        float2 animatedUV = (uv * scale) + uvTime;

        q = animatedUV + ripples + i + n;
        output += dot(cos(q) / scale, float2(brightness, brightness));

        n -= sin(q);

        scale *= scaleMultStep;
    }

    Out = output;
}

half2x2 Get2DRotationMatrix(half angle)
{
    half c = cos(angle);
    half s = sin(angle);

    return half2x2(c, -s, s, c);
}

void GetAnimatedOrganicFractal_half(half scale, half scaleMultStep, half rotationStep, int iterations, half2 uv, half uvAnimationSpeed, half rippleStrength, half rippleMaxFrequency, half rippleSpeed, half brightness, out half Out)
{
    uv = half2(uv - 0.5) * 2.0;

    half2 n, q;
    half invertedRadialGradient = pow(length(uv), 2.0);

    half output = 0.0;
    half2x2 rotationMatrix = Get2DRotationMatrix(rotationStep);

    half t = _Time.y;
    half uvTime = t * uvAnimationSpeed;

    half ripples = sin((t * rippleSpeed) - (invertedRadialGradient * rippleMaxFrequency)) * rippleStrength;

    for (int i = 0; i < iterations; i++)
    {
        uv = mul(rotationMatrix, uv);
        n = mul(rotationMatrix, n);

        half2 animatedUV = (uv * scale) + uvTime;

        q = animatedUV + ripples + i + n;
        output += dot(cos(q) / scale, half2(brightness, brightness));

        n -= sin(q);

        scale *= scaleMultStep;
    }

    Out = output;
}
#endif