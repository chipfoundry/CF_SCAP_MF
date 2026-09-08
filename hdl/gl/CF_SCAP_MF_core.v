// Empty blackbox stub for hierarchical integration LVS.
module CF_SCAP_MF_core (
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
    vpb,
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
    input vpb;
    input vpwr;
    inout sc_gndVref_hv;
    input vfb;
    input [1:0] dft_hv;
    input boost_en;
endmodule
