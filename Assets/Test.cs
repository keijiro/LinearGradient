using UnityEngine;
using Klak.Chromatics;

[ExecuteInEditMode]
sealed class Test : MonoBehaviour
{
    [SerializeField] Gradient _gradient = null;

    MaterialPropertyBlock _overrides;

    void Update()
    {
        if (_overrides == null) _overrides = new MaterialPropertyBlock();
        _overrides.SetLinearGradient("_Gradient1", _gradient);
        GetComponent<Renderer>().SetPropertyBlock(_overrides);
    }
}
