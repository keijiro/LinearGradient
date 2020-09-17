using UnityEngine;
using UnityEngine.Rendering;

namespace Klak.Chromatics {

public static class LinearGradientExtensions
{
    static Vector4 [] _tempArray = new Vector4[12];

    static Vector4 [] LoadToTempArray(Gradient gradient)
    {
        if (gradient == null) return _tempArray;

        var ckeys = gradient.colorKeys;
        var akeys = gradient.alphaKeys;
        var aimax = akeys.Length - 1;

        var i = 0;

        for (; i < ckeys.Length; i++)
        {
            var c = ckeys[i].color;
            var t = ckeys[i].time;
            _tempArray[i] = new Vector4(c.r, c.g, c.b, t);
        }

        for (; i < 8; i++)
            _tempArray[i] = _tempArray[i - 1];

        for (var ai = 0; ai < 8;)
        {
            var i0 = Mathf.Min(ai++, aimax);
            var i1 = Mathf.Min(ai++, aimax);
            _tempArray[i++] = new Vector4(akeys[i0].alpha, akeys[i0].time,
                                          akeys[i1].alpha, akeys[i1].time);
        }

        // Special case:
        // Offset the first key by 10 when the gradient mode is set to Fixed.
        if (gradient.mode == GradientMode.Fixed)
            _tempArray[0] += new Vector4(0, 0, 0, 10);

        return _tempArray;
    }

    public static void SetLinearGradient
      (this Material material, string name, Gradient gradient)
        => material.SetVectorArray(Shader.PropertyToID(name),
                                   LoadToTempArray(gradient));

    public static void SetLinearGradient
      (this Material material, int id, Gradient gradient)
        => material.SetVectorArray(id, LoadToTempArray(gradient));

    public static void SetLinearGradient
      (this MaterialPropertyBlock block, string name, Gradient gradient)
        => block.SetVectorArray(Shader.PropertyToID(name),
                                LoadToTempArray(gradient));

    public static void SetLinearGradient
      (this MaterialPropertyBlock block, int id, Gradient gradient)
        => block.SetVectorArray(id, LoadToTempArray(gradient));

    public static void SetGlobalLinearGradient
      (this CommandBuffer cmd, string name, Gradient gradient)
        => cmd.SetGlobalVectorArray(Shader.PropertyToID(name),
                                    LoadToTempArray(gradient));

    public static void SetGlobalLinearGradient
      (this CommandBuffer cmd, int id, Gradient gradient)
        => cmd.SetGlobalVectorArray(id, LoadToTempArray(gradient));
}

} // namespace Klak.Chromatics
