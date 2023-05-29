vec4 effect(vec4 color, Image image, vec2 uvs, vec2 sc) {
    vec4 pixel = Texel(image, uvs);

    if (pixel.a > 0) {
        return vec4(1,1,1,1);
    }

    return vec4(0,0,0,0);
}