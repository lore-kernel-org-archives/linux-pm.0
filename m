From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 09/17] ARM: tegra: add PM domain device nodes to Tegra114 DT
Date: Thu, 12 Mar 2015 20:15:10 +0800
Message-ID: <1426162518-7405-10-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, Vince Hsu <vinceh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Also bind the PM domain provider and consumer together.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 4296b5398bf5..79e1f5cfa53c 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra114-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -36,6 +37,7 @@
 		gr3d@54180000 {
 			compatible = "nvidia,tegra114-gr3d", "nvidia,tegra20-gr3d";
 			reg = <0x54180000 0x00040000>;
+			power-domains = <&pmc TEGRA_POWERGATE_3D>;
 			clocks = <&tegra_car TEGRA114_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
@@ -45,6 +47,7 @@
 			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pmc TEGRA_POWERGATE_DIS>;
 			clocks = <&tegra_car TEGRA114_CLK_DISP1>,
 				 <&tegra_car TEGRA114_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -64,6 +67,7 @@
 			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pmc TEGRA_POWERGATE_DISB>;
 			clocks = <&tegra_car TEGRA114_CLK_DISP2>,
 				 <&tegra_car TEGRA114_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -487,11 +491,48 @@
 		status = "disabled";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra114-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA114_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#power-domain-cells = <1>;
+	};
+
+	dcpd: dc-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "dc-power-domain";
+		domain = <TEGRA_POWERGATE_DIS>;
+		clocks = <&tegra_car TEGRA114_CLK_DISP1>,
+			<&tegra_car TEGRA114_CLK_DSIA>,
+			<&tegra_car TEGRA114_CLK_DSIB>,
+			<&tegra_car TEGRA114_CLK_MIPI_CAL>;
+		resets = <&tegra_car 27>,
+			<&tegra_car 48>,
+			<&tegra_car 82>,
+			<&tegra_car 56>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_DC>;
+	};
+
+	dcb-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "dcb-power-domain";
+		domain = <TEGRA_POWERGATE_DISB>;
+		clocks = <&tegra_car TEGRA114_CLK_DISP2>,
+			<&tegra_car TEGRA114_CLK_HDMI>;
+		resets = <&tegra_car 26>,
+			<&tegra_car 51>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_DCB>;
+		depend-on = <&dcpd>;
+	};
+
+	gr3d-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "gr3d-power-domain";
+		domain = <TEGRA_POWERGATE_3D>;
+		clocks = <&tegra_car TEGRA114_CLK_GR3D>;
+		resets = <&tegra_car 24>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_NV>;
 	};
 
 	fuse@7000f800 {
-- 
2.1.4
