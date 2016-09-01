From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH 3/5] Documentation: bindings: add dt documentation for rk3399 dmc
Date: Fri,  2 Sep 2016 06:31:23 +0800
Message-ID: <1472769085-20715-4-git-send-email-hl@rock-chips.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33952 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcIAWbj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 18:31:39 -0400
In-Reply-To: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>

This patch adds the documentation for rockchip rk3399 dmc driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v8:
- add ddr timing properties

Changes in v7:
-None

Changes in v6:
-Add more detail in Documentation

Changes in v5:
-None

Changes in v4:
-None

Changes in v3:
-None

Changes in v2:
-None 

Changes in v1:
-None

 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 173 +++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
new file mode 100644
index 0000000..1f39b5cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -0,0 +1,173 @@
+* Rockchip rk3399 DMC(Dynamic Memory Controller) device
+
+Required properties:
+- compatible:		 Must be "rockchip,rk3399-dmc".
+- devfreq-events:	 Node to get DDR loading, Refer to
+			 Documentation/devicetree/bindings/devfreq/
+			 rockchip-dfi.txt
+- interrupts:		 The interrupt number to the CPU. The interrupt
+			 specifier format depends on the interrupt controller.
+			 It should be DCF interrupts, when DDR dvfs finish,
+			 it will happen.
+- clocks:		 Phandles for clock specified in "clock-names" property
+- clock-names :		 The name of clock used by the DFI, must be
+			 "pclk_ddr_mon";
+- operating-points-v2:	 Refer to Documentation/devicetree/bindings/power/opp.txt
+			 for details.
+- center-supply:	 DMC supply node.
+- status:		 Marks the node enabled/disabled.
+
+Following properties are ddr timing:
+
+- dram_speed_bin :	 Value is defined at include/dt-bindings/clock/ddr.h,
+			 it select ddr3 cl-trp-trcd type, default value
+			 "DDR3_DEFAULT".it must selected according to
+			 "Speed Bin" in ddr3 datasheet, DO NOT use smaller
+			 "Speed Bin" than ddr3 exactly is.
+
+- pd_idle :		 Config the PD_IDLE value, defined the power-down idle
+			 period, memories are places into power-down mode if
+			 bus is idle for PD_IDLE DFI clocks.
+
+- sr_idle :		 Configure the SR_IDLE value, defined the selfrefresh
+			 idle period, memories are places into self-refresh
+			 mode if bus is idle for SR_IDLE*1024 DFI clocks
+			 (DFI clocks freq is half of dram's clocks), defaule
+			 value is "0".
+
+- sr_mc_gate_idle :	 Defined the self-refresh with memory and controller
+			 clock gating idle period, memories are places into
+			 self-refresh mode and memory controller clock arg
+			 gating if bus is idle for sr_mc_gate_idle*1024 DFI
+			 clocks.
+
+- srpd_lite_idle :	 Defined the self-refresh power down idle period,
+			 memories are places into self-refresh power down
+			 mode if bus is idle for srpd_lite_idle*1024 DFI
+			 clocks. This parameter is for LPDDR4 only.
+
+- standby_idle :	 Defined the standby idle period, memories are places
+			 into self-refresh than controller, pi, phy and dram
+			 clock will gating if bus is idle for
+			 standby_idle * DFI clocks.
+
+- dram_dll_disb_freq :	 It's defined the DDR3 dll bypass frequency in MHz
+			 when ddr freq less than DRAM_DLL_DISB_FREQ, ddr3
+			 dll will bypssed note: if dll was bypassed, the
+			 odt also stop working.
+
+- phy_dll_disb_freq :	 Defined the PHY dll bypass frequency in MHz (Mega Hz),
+			 when ddr freq less than DRAM_DLL_DISB_FREQ, phy dll
+			 will bypssed. note: phy dll and phy odt are
+			 independent
+
+- ddr3_odt_disb_freq :	 When dram type is DDR3, this parameter defined the
+			 odt disable frequency in MHz (Mega Hz), when ddr
+			 frequency less then ddr3_odt_disb_freq, the odt
+			 on dram side and controller side are both disabled.
+
+- ddr3_drv :		 When dram type is DDR3, this parameter define the
+			 dram side driver stength in ohm, default value is
+			 DDR3_DS_40ohm.
+
+- ddr3_odt :		 When dram type is DDR3, this parameter define the
+			 dram side ODT stength in ohm, default value is
+			 DDR3_ODT_120ohm.
+
+- phy_ddr3_ca_drv :	 When dram type is DDR3, this parameter define the phy
+			 side CA line(incluing command line, address line and
+			 clock line) driver strength. default value is
+			 PHY_DRV_ODT_40.
+
+- phy_ddr3_dq_drv :	 When dram type is DDR3, this parameter define the phy
+			 side DQ line(incluing DQS/DQ/DM line) driver strength.
+			 default value is PHY_DRV_ODT_40.
+
+- phy_ddr3_odt : 	 When dram type is DDR3, this parameter define the
+			 phy side odt strength, default value is
+			 PHY_DRV_ODT_240.
+
+- lpddr3_odt_disb_freq : When dram type is LPDDR3, this parameter defined then
+			 odt disable frequency in MHz (Mega Hz), when ddr
+			 frequency less then ddr3_odt_disb_freq, the odt on
+			 dram side and controller side are both disabled.
+
+- lpddr3_drv :		 When dram type is LPDDR3, this parameter define the
+			 dram side driver stength in ohm, default value is
+			 LP3_DS_34ohm.
+
+- lpddr3_odt :		 When dram type is LPDDR3, this parameter define the
+			 dram side ODT stength in ohm, default value is
+			 LP3_ODT_240ohm.
+
+- phy_lpddr3_ca_drv :	 When dram type is LPDDR3, this parameter define the
+			 phy side CA line(incluing command line, address line
+			 and clock line) driver strength. default value is
+			 PHY_DRV_ODT_40.
+
+- phy_lpddr3_dq_drv :	 When dram type is LPDDR3, this parameter define the
+			 phy side DQ line(incluing DQS/DQ/DM line) driver
+			 strength. default value is PHY_DRV_ODT_40.
+
+- phy_lpddr3_odt : 	 When dram type is LPDDR3, this parameter define the phy
+			 side odt strength, default value is PHY_DRV_ODT_240.
+
+- lpddr4_odt_disb_freq : When dram type is LPDDR4, this parameter defined the
+			 odt disable frequency in MHz (Mega Hz), when ddr
+			 frequency less then ddr3_odt_disb_freq, the odt on
+			 dram side and controller side are both disabled.
+
+- lpddr4_drv :		 When dram type is LPDDR4, this parameter define the
+			 dram side driver stength in ohm, default value is
+			 LP4_PDDS_60ohm.
+
+- lpddr4_dq_odt : 	 When dram type is LPDDR4, this parameter define the
+			 dram side ODT on dqs/dq line stength in ohm, default
+			 value is LP4_DQ_ODT_40ohm.
+
+- lpddr4_ca_odt :	 When dram type is LPDDR4, this parameter define the
+			 dram side ODT on ca line stength in ohm, default value
+			 is LP4_CA_ODT_40ohm.
+
+- phy_lpddr4_ca_drv :	 When dram type is LPDDR4, this parameter define the
+			 phy side  CA line(incluing command address line)
+			 driver strength. default value is PHY_DRV_ODT_40.
+
+- phy_lpddr4_ck_cs_drv : When dram type is LPDDR4, this parameter define the
+			 phy side clock line and cs line driver strength.
+			 default value is PHY_DRV_ODT_80.
+
+- phy_lpddr4_dq_drv :	 When dram type is LPDDR4, this parameter define the
+			 phy side DQ line(incluing DQS/DQ/DM line) driver
+			 strength. default value is PHY_DRV_ODT_80.
+
+- phy_lpddr4_odt :	 When dram type is LPDDR4, this parameter define the
+			 phy side odt strength, default value is PHY_DRV_ODT_60.
+
+Example:
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		devfreq-events = <&dfi>;
+		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_DDRCLK>;
+		clock-names = "dmc_clk";
+		operating-points-v2 = <&dmc_opp_table>;
+		center-supply = <&ppvar_centerlogic>;
+		upthreshold = <15>;
+		downdifferential = <10>;
+		status = "disabled";
+	};
+
-- 
2.6.6

