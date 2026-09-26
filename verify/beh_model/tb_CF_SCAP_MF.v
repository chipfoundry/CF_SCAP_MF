`timescale 1ns / 1ps

module tb_CF_SCAP_MF;
    integer errors;
    reg vnb_dnwell, sc_gain_hv, phi2, phi1, phi2d, phi1d, vboost, vgnd, vpwr, vfb, boost_en;
    reg [1:0] sc_redc_hv, dft_hv;
    reg [2:0] sc_mode_hv;
    wire dyn_cntrl, vin_inn, vref_inp, vout, in_n, sc_gndVref_hv;

    CF_SCAP_MF u (
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
        .vpwr(vpwr),
        .sc_gndVref_hv(sc_gndVref_hv),
        .vfb(vfb),
        .dft_hv(dft_hv),
        .boost_en(boost_en)
    );

    task expect_bit;
        input got;
        input exp;
        input [8*24-1:0] tag;
        begin
            if (got !== exp) begin
                $display("FAIL %s got=%b exp=%b", tag, got, exp);
                errors = errors + 1;
            end else $display("PASS %s %b", tag, got);
        end
    endtask

    task sample_then_transfer;
        begin
            phi2 = 0;
            phi1 = 1;
            #1;
            phi1 = 0;
            phi2 = 1;
            #1;
            phi2 = 0;
        end
    endtask

    initial begin
        errors = 0;
        vnb_dnwell = 0;
        sc_redc_hv = 0;
        sc_mode_hv = 0;
        sc_gain_hv = 0;
        phi2 = 0;
        phi1 = 0;
        phi2d = 0;
        phi1d = 0;
        vboost = 1;
        vgnd = 0;
        vpwr = 1;
        vfb = 0;
        dft_hv = 0;
        boost_en = 0;
        u.u_core.vin_inn_v = 1.2;
        #1;
        sample_then_transfer;
        expect_bit(vout, 1'b0, "boost off");
        if (u.u_core.vout_v > 0.001) begin
            $display("FAIL vout_v off %g", u.u_core.vout_v);
            errors = errors + 1;
        end else $display("PASS vout_v off %g", u.u_core.vout_v);

        boost_en = 1;
        sample_then_transfer;
        expect_bit(vout, 1'b1, "sampled");
        if (u.u_core.vout_v < 1.19 || u.u_core.vout_v > 1.21) begin
            $display("FAIL vout_v %g", u.u_core.vout_v);
            errors = errors + 1;
        end else $display("PASS vout_v %g", u.u_core.vout_v);

        u.u_core.vin_inn_v = 0.0;
        sample_then_transfer;
        expect_bit(vout, 1'b0, "sampled low");

        boost_en = 0;
        #1;
        expect_bit(vout, 1'b0, "disabled");

        if (errors == 0) $display("CF_SCAP_MF behavioral self-check passed");
        else $display("CF_SCAP_MF behavioral self-check FAILED %0d", errors);
        $finish(errors != 0);
    end
endmodule
