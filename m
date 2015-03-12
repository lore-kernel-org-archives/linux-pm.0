From: Vince Hsu <vinceh@nvidia.com>
Subject: [PATCH v2 08/17] ARM: tegra: add PM domain device nodes to Tegra30 DT
Date: Thu, 12 Mar 2015 20:15:09 +0800
Message-ID: <1426162518-7405-9-git-send-email-vinceh@nvidia.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index db4810df142c..bec1b17fdcab 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -2,6 +2,7 @@
 #include <dt-bindings/gpio/tegra-gpio.h>
 #include <dt-bindings/memory/tegra30-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -36,6 +37,7 @@
 			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchable memory */
 			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable memory */
 
+		power-domains = <&pmc TEGRA_POWERGATE_PCIE>;
 		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
 			 <&tegra_car TEGRA30_CLK_AFI>,
 			 <&tegra_car TEGRA30_CLK_PLL_E>,
@@ -149,6 +151,14 @@
 		gr3d@54180000 {
 			compatible = "nvidia,tegra30-gr3d";
 			reg = <0x54180000 0x00040000>;
+			/*
+			 * Actually the gr3d has two power domains, but the
+			 * generic power domain doesn't support multiple
+			 * domain provider for one device yet. So we claim
+			 * the gr3d is powered by the domain 3D1 here, and
+			 * let the 3D1 depend on 3D below.
+			 */
+			power-domains = <&pmc TEGRA_POWERGATE_3D1>;
 			clocks = <&tegra_car TEGRA30_CLK_GR3D
 				  &tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
@@ -613,11 +623,44 @@
 		status = "disabled";
 	};
 
-	pmc@7000e400 {
+	pmc: pmc@7000e400 {
 		compatible = "nvidia,tegra30-pmc";
 		reg = <0x7000e400 0x400>;
 		clocks = <&tegra_car TEGRA30_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#power-domain-cells = <1>;
+	};
+
+	gr3dpd: gr3d-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "gr3d-power-domain";
+		domain = <TEGRA_POWERGATE_3D>;
+		clocks = <&tegra_car TEGRA30_CLK_GR3D>;
+		resets = <&tegra_car 24>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_NV>;
+	};
+
+	gr3d2-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "gr3d2-power-domain";
+		domain = <TEGRA_POWERGATE_3D1>;
+		clocks = <&tegra_car TEGRA30_CLK_GR3D2>;
+		resets = <&tegra_car 98>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_NV2>;
+		depend-on = <&gr3dpd>;
+	};
+
+	pcie-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "pcie-power-domain";
+		domain = <TEGRA_POWERGATE_PCIE>;
+		clocks = <&tegra_car TEGRA30_CLK_AFI>,
+			 <&tegra_car TEGRA30_CLK_PCIE>,
+			 <&tegra_car TEGRA30_CLK_CML0>;
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_AFI>;
 	};
 
 	mc: memory-controller@7000f000 {
-- 
2.1.4
