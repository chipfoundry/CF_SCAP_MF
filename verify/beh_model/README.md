# CF_SCAP_MF behavioral model

Ideal functional model for digital simulation. It is **not** SPICE-accurate
and it is **not** silicon-verified. Do not add this file to OpenLane
`VERILOG_FILES`.

## Files

| File | Replaces |
|---|---|
| `CF_SCAP_MF_core.v` | `hdl/gl/CF_SCAP_MF_core.v` |

Keep the customer wrap in `hdl/gl/CF_SCAP_MF.v`. Do **not** compile the empty
`hdl/gl/CF_SCAP_MF_core.v` stub in the same sim (duplicate module name).

```bash
./verify/beh_model/run_tb.sh
```

## Behavior

Ideal switched-capacitor sample. `boost_en` high enables the array. `phi1` high samples `vin_inn_v` into `held_v`. `phi2` high, with `phi1` low, copies `held_v` onto `vout_v` and drives `vout` when that voltage is above 0.05 V. `boost_en` low forces `vout_v` to 0. `vboost` is a supply input and is not generated. Mode, gain, reduce, DFT, and delayed clocks are not modeled. There is no gain table.
