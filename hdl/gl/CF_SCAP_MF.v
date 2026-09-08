// Structural PG wrapper. Analog leaf is CF_SCAP_MF_core.
// Customer rails are vpwr/vgnd; well taps vpb/vnb/vpbe are tied inside.
module CF_SCAP_MF (
    dyn_cntrl,
    vnb_dnwell,
    sc_redc_hv,
    vin_inn,
    vref_inp,
    vout,
    in_n,
    sc_mode_hv,
    sc_gain_hv,
    phi2,
    phi1,
    phi2d,
    phi1d,
    vboost,
    vgnd,
    vpwr,
    sc_gndVref_hv,
    vfb,
    dft_hv,
    boost_en
);
    inout dyn_cntrl;
    input vnb_dnwell;
    input [1:0] sc_redc_hv;
    inout vin_inn;
    inout vref_inp;
    inout vout;
    inout in_n;
    input [2:0] sc_mode_hv;
    input sc_gain_hv;
    input phi2;
    input phi1;
    input phi2d;
    input phi1d;
    input vboost;
    input vgnd;
    input vpwr;
    inout sc_gndVref_hv;
    input vfb;
    input [1:0] dft_hv;
    input boost_en;
    CF_SCAP_MF_core u_core (
        .dyn_cntrl(dyn_cntrl),
        .vnb_dnwell(vnb_dnwell),
        .sc_redc_hv(sc_redc_hv),
        .vin_inn(vin_inn),
        .vref_inp(vref_inp),
        .vout(vout),
        .in_n(in_n),
        .sc_mode_hv(sc_mode_hv),
        .sc_gain_hv(sc_gain_hv),
        .phi2(phi2),
        .phi1(phi1),
        .phi2d(phi2d),
        .phi1d(phi1d),
        .vboost(vboost),
        .vgnd(vgnd),
        .vpb(vpwr),
        .vpwr(vpwr),
        .sc_gndVref_hv(sc_gndVref_hv),
        .vfb(vfb),
        .dft_hv(dft_hv),
        .boost_en(boost_en)
    );
endmodule
