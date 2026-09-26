`timescale 1ns / 1ps

// Ideal functional model of analog leaf CF_SCAP_MF_core.
// Drop this file in place of hdl/gl/CF_SCAP_MF_core.v for simulation.
// Do not add it to OpenLane VERILOG_FILES.
//
// Analog values are Verilog real backdoors (1-bit pins stay digital):
//   vin_inn_v, vref_inp_v, vout_v, in_n_v, vfb_v, dyn_cntrl_v, sc_gndVref_hv_v
//
// Assumed protocol (ideal, not silicon-verified):
//   * boost_en high enables the array. vboost stays a supply input and is not generated.
//   * phi1 high samples vin_inn_v into held_v
//   * phi2 high, with phi1 low, copies held_v onto vout_v
//   * boost_en low forces vout_v to 0
// There is no gain table. Mode, gain, reduce, DFT, and delayed clocks are not modeled.

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

    localparam real V_PRESENT = 0.05;

    real vin_inn_v;
    real vref_inp_v;
    real vout_v;
    real in_n_v;
    real vfb_v;
    real dyn_cntrl_v;
    real sc_gndVref_hv_v;
    real held_v;

    initial begin
        vin_inn_v = 0.0;
        vref_inp_v = 0.0;
        vout_v = 0.0;
        in_n_v = 0.0;
        vfb_v = 0.0;
        dyn_cntrl_v = 0.0;
        sc_gndVref_hv_v = 0.0;
        held_v = 0.0;
    end

    always @(*) begin
        if (boost_en !== 1'b1) begin
            vout_v = 0.0;
        end else if (phi1 === 1'b1) begin
            held_v = vin_inn_v;
        end else if (phi2 === 1'b1) begin
            vout_v = held_v;
        end
    end

    assign vout = (boost_en === 1'b1 && vout_v > V_PRESENT) ? 1'b1 : 1'b0;
endmodule
