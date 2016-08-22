From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v7 6/8] Documentation: bindings: add dt documentation for rk3399 dmc
Date: Mon, 22 Aug 2016 11:36:22 +0800
Message-ID: <1471836984-6316-7-git-send-email-hl@rock-chips.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, myungjoo.ham@samsung.com
Cc: tixy@linaro.org, mark.rutland@arm.com, typ@rock-chips.com, linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the documentation for rockchip rk3399 dmc driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
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
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
new file mode 100644
index 0000000..b787abb
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -0,0 +1,85 @@
+* Rockchip rk3399 DMC(Dynamic Memory Controller) device
+
+Required properties:
+- compatible: Must be "rockchip,rk3399-dmc".
+- devfreq-events: Node to get DDR loading, Refer to
+		  Documentation/devicetree/bindings/devfreq/rockchip-dfi.txt
+- interrupts: The interrupt number to the CPU. The interrupt specifier format
+	      depends on the interrupt controller. It should be DCF interrupts,
+	      when DDR dvfs finish, it will happen.
+- clocks: Phandles for clock specified in "clock-names" property
+- clock-names : The name of clock used by the DFI, must be "pclk_ddr_mon";
+- operating-points-v2: Refer to Documentation/devicetree/bindings/power/opp.txt
+		       for details.
+- center-supply: DMC supply node.
+- status: Marks the node enabled/disabled.
+
+Optional properties:
+- ddr_timing:  DDR timing need to pass to arm trust firmware
+- upthreshold: The upthreshold to simpleondeamnd policy
+- downdifferential: The downdifferential to simpleondeamnd policy
+
+Example:
+
+	ddr_timing: ddr_timing {
+		compatible = "rockchip,ddr-timing";
+		ddr3_speed_bin = <21>;
+		pd_idle = <0>;
+		sr_idle = <0>;
+		sr_mc_gate_idle = <0>;
+		srpd_lite_idle  = <0>;
+		standby_idle = <0>;
+		dram_dll_dis_freq = <300>;
+		phy_dll_dis_freq = <125>;
+
+		ddr3_odt_dis_freq = <333>;
+		ddr3_drv = <DDR3_DS_40ohm>;
+		ddr3_odt = <DDR3_ODT_120ohm>;
+		phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
+		phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
+		phy_ddr3_odt = <PHY_DRV_ODT_240>;
+
+		lpddr3_odt_dis_freq = <333>;
+		lpddr3_drv = <LP3_DS_34ohm>;
+		lpddr3_odt = <LP3_ODT_240ohm>;
+		phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
+		phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
+		phy_lpddr3_odt = <PHY_DRV_ODT_240>;
+
+		lpddr4_odt_dis_freq = <333>;
+		lpddr4_drv = <LP4_PDDS_60ohm>;
+		lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
+		lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
+		phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
+		phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
+		phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
+		phy_lpddr4_odt = <PHY_DRV_ODT_60>;
+	};
+
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
+		ddr_timing = <&ddr_timing>;
+		operating-points-v2 = <&dmc_opp_table>;
+		center-supply = <&ppvar_centerlogic>;
+		upthreshold = <15>;
+		downdifferential = <10>;
+		status = "disabled";
+	};
+
-- 
2.6.6
