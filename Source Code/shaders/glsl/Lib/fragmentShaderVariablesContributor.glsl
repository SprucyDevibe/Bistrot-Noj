struct Lights{
	vec3 Sunlight;
	vec3 Envlight;
	vec3 Pointlight;
} Lighting;

vec3 SunlightColor = vec3(1.00, 1.00, 1.00);
vec3 SkylightColor = vec3(0.20, 0.43, 1.13);
vec3 TorchlightColor = vec3(1.15, 0.58, 0.25);

vec3 SunDirection = normalize(vec3(1000.0, 1000.0, 0.00));
vec3 UpDirection = normalize(vec3(0.00, 1000.0, 0.00));
