From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v5 6/8] Documentation: bindings: add dt documentation for rk3399 dmc
Date: Wed, 10 Aug 2016 11:26:42 +0800
Message-ID: <1470799604-12877-7-git-send-email-hl@rock-chips.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the documentation for rockchip rk3399 dmc driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
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

 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
new file mode 100644
index 0000000..90e9581
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -0,0 +1,35 @@
+* Rockchip rk3399 dmc device
+
+Required properties:
+- compatible: Must be "rockchip,rk3399-dmc".
+- devfreq-events: Node to get ddr loading, Refer to
+		  Documentation/devicetree/bindings/devfreq/rockchip-dif.txt
+- interrupts: The interrupt number to the cpu. The interrupt specifier format
+	      depends on the interrupt controller. 
+- clocks: Phandles for clock specified in "clock-names" property
+- clock-names : The name of clock used by the DFI, must be "pclk_ddr_mon";
+- operating-points-v2: Refer to Documentation/devicetree/bindings/power/opp.txt
+		       for details.
+- center-supply: Dmc supply node.
+- status: Marks the node enabled/disabled.
+
+Optional properties:
+- ddr_timing: ddr timing need to pass to arm trust firmware
+- upthreshold: the upthreshold to simpleondeamnd policy
+- downdifferential: The downdifferential to simpleondeamnd policy
+
+Example:
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
1.9.1
