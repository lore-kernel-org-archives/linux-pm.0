From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 10/17] ARM: tegra: Add the DFLL to Tegra124 device tree
Date: Wed, 13 May 2015 17:58:44 +0300
Message-ID: <1431529131-16710-11-git-send-email-mikko.perttunen@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The DFLL clocksource is a separate IP block from the usual
clock-and-reset controller, so it gets its own device tree node.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Acked-by: Michael Turquette <mturquette@linaro.org>
---
 arch/arm/boot/dts/tegra124.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 01a9f74..5b8177a 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
 #include "skeleton.dtsi"
@@ -702,6 +703,30 @@
 		#thermal-sensor-cells = <1>;
 	};
 
+	dfll: clock@0,70110000 {
+		compatible = "nvidia,tegra124-dfll";
+		reg = <0 0x70110000 0 0x100>, /* DFLL control */
+		      <0 0x70110000 0 0x100>, /* I2C output control */
+		      <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+		      <0 0x70110200 0 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA124_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA124_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		resets = <&tegra_car TEGRA124_RST_DFLL_DVCO>;
+		reset-names = "dvco";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		nvidia,sample-rate = <12500>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <10>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		status = "disabled";
+	};
+
 	ahub@0,70300000 {
 		compatible = "nvidia,tegra124-ahub";
 		reg = <0x0 0x70300000 0x0 0x200>,
-- 
2.3.0
