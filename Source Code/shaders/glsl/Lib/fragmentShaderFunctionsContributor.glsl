vec3 Absorption(float depth, float light){
    return exp(-SkylightColor / (depth + 0.001) + log(1.00 - light)) + light;
}

vec3 SunBrightness(highp float NdotL, highp float LdotU){
	return smoothstep(0.9985, 0.9986, NdotL) * 10.0 + 
               smoothstep(0.00, 1.00, clamp(1.00 - pow((1.00 - NdotL) / 1.50, 0.10), 0.00, 1.00)) * 3.14 *
			   Absorption(LdotU, LdotU * LdotU);
}

vec3 DrawSky(highp float NdotL, highp float NdotU, highp float LdotU){
	vec3 SkyColor = pow(SkylightColor, sqrt(NdotU)  * vec3(1.00, 1.00, 1.00));
	
	vec3 Sky = SkyColor * Absorption(sqrt(NdotU), LdotU * LdotU);
             Sky = (Sky + SunBrightness(NdotL, LdotU)) * Absorption(LdotU, LdotU * LdotU);
	
	return Sky;
}

vec3 ColorTint(vec4 inColor){
	vec3 grassNewColor = vec3(0.27843137254901960, 0.81176470588235294, 0.20);
	vec3 grassOldColor = vec3(0.74117647058823529, 0.71372549019607843, 0.32941176470588235);
	
	vec3 foliageNewColor = vec3(0.10980392156862745, 0.7450980392156862, 0.00392156862745098);
	vec3 foliageOldColor = vec3(0.67843137254901960, 0.64313725490196078, 0.16470588235294117);
	
	vec3 oldColor = normalize(inColor.rgb);
	
	vec3 outColor;
	
	if(inColor.a < 1e-8){
		outColor = oldColor / dot(oldColor, foliageNewColor) * dot(foliageOldColor, foliageNewColor);
	}else{
		outColor = oldColor / dot(oldColor, grassNewColor) * dot(grassOldColor, grassNewColor);
	}
	if(abs(outColor.r - outColor.g) == 0.00 && abs(outColor.g - outColor.b) == 0.00 && abs(outColor.b - outColor.r) == 0.00){
		outColor = vec3(1.00, 1.00, 1.00);
	}
	
	return outColor;
}

float Luma(vec3 Color){
	return dot(Color, vec3(0.2126, 0.7152, 0.0722));
}

float LumaGB(vec3 Color){
	return dot(Color, vec3(0.2126, 0.00, 0.0722));
}

vec3 ReinHard(vec3 Color){
	return Color / (Color + 1.00);
}

vec3 ToLinear(vec3 Color){
	return pow(Color, vec3(2.20, 2.20, 2.20));
}

vec3 ToGamma(vec3 Color){
	return pow(Color, 1.00 / vec3(2.20, 2.20, 2.20));
}

vec3 ColorProcessing(vec3 Color){
	
	Color = ReinHard(Color);
	Color = ToGamma(Color);
	
	return Color;
}

