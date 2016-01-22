cbuffer ConstantBuffer : register(b0)
{
        float4x4 modelview;
        float4x4 projection;
};

struct VSInput
{
        float4 position : POSITION;
        float2 coord : TEXCOORD0;
};

struct PSInput
{
        float4 position : SV_POSITION;
        float2 coord : TEXCOORD0;
};

Texture2D tex : register(t0);
SamplerState samp : register(s0);

PSInput VS_Texture(VSInput input)
{
        PSInput result;

        float4x4 mvp = mul(projection, modelview);
        result.position = mul(mvp, input.position);
        result.coord = input.coord;

        return result;
}

float4 PS_Texture(PSInput input) : SV_TARGET
{
        return tex.Sample(samp, input.coord);
}
