From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 17/19] ARM: tegra: Add PM domain device nodes to Tegra124 DT
Date: Mon, 13 Jul 2015 13:39:55 +0100
Message-ID: <1436791197-32358-18-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4723 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbGMMlU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:41:20 -0400
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add tegra124 pm-domains provider and consumer nodes.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 80 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 87318a72f615..3573bb079791 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/memory/tegra124-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra124-car.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
@@ -40,6 +41,8 @@
 			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
 			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
 
+		power-domains = <&pd_pcie>;
+
 		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
 			 <&tegra_car TEGRA124_CLK_AFI>,
 			 <&tegra_car TEGRA124_CLK_PLL_E>,
@@ -99,6 +102,7 @@
 			compatible = "nvidia,tegra124-dc";
 			reg = <0x0 0x54200000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_dc>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP1>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -114,6 +118,7 @@
 			compatible = "nvidia,tegra124-dc";
 			reg = <0x0 0x54240000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_dcb>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP2>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -141,6 +146,7 @@
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x0 0x54540000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_sor>;
 			clocks = <&tegra_car TEGRA124_CLK_SOR0>,
 				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>,
 				 <&tegra_car TEGRA124_CLK_PLL_DP>,
@@ -155,6 +161,7 @@
 			compatible = "nvidia,tegra124-dpaux";
 			reg = <0x0 0x545c0000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pd_sor>;
 			clocks = <&tegra_car TEGRA124_CLK_DPAUX>,
 				 <&tegra_car TEGRA124_CLK_PLL_DP>;
 			clock-names = "dpaux", "parent";
@@ -184,6 +191,7 @@
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "stall", "nonstall";
+		power-domains = <&pd_gpu>;
 		clocks = <&tegra_car TEGRA124_CLK_GPU>,
 			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
 		clock-names = "gpu", "pwr";
@@ -573,6 +581,76 @@
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+
+		pm-domains {
+			pd_gpu: gpu-power-domain {
+				clocks = <&tegra_car TEGRA124_CLK_GPU>,
+					 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
+				resets = <&tegra_car 184>;
+				nvidia,powergate = <TEGRA_POWERGATE_EXT>;
+				nvidia,swgroups = <&mc TEGRA_SWGROUP_GPU>;
+				#nvidia,swgroup-cells = <1>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_pcie: pcie-power-domain {
+				clocks = <&tegra_car TEGRA124_CLK_PCIE>,
+					 <&tegra_car TEGRA124_CLK_AFI>;
+				resets = <&tegra_car 70>,
+					 <&tegra_car 72>;
+				nvidia,powergate = <TEGRA_POWERGATE_PCIE>;
+				nvidia,swgroups = <&mc TEGRA_SWGROUP_AFI>;
+				#nvidia,swgroup-cells = <1>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sata: sata-power-domain {
+				clocks = <&tegra_car TEGRA124_CLK_SATA>,
+					 <&tegra_car TEGRA124_CLK_SATA_OOB>,
+					 <&tegra_car TEGRA124_CLK_CML1>;
+				resets = <&tegra_car 124>,
+					 <&tegra_car 123>,
+					 <&tegra_car 129>;
+				nvidia,powergate = <TEGRA_POWERGATE_SATA>;
+				nvidia,swgroups = <&mc TEGRA_SWGROUP_SATA>;
+				#nvidia,swgroup-cells = <1>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sor: sor-power-domain {
+				clocks = <&tegra_car TEGRA124_CLK_SOR0>,
+					 <&tegra_car TEGRA124_CLK_DSIA>,
+					 <&tegra_car TEGRA124_CLK_DSIB>,
+					 <&tegra_car TEGRA124_CLK_HDMI>,
+					 <&tegra_car TEGRA124_CLK_MIPI_CAL>,
+					 <&tegra_car TEGRA124_CLK_DPAUX>;
+				resets = <&tegra_car 182>,
+					 <&tegra_car 48>,
+					 <&tegra_car 82>,
+					 <&tegra_car 51>,
+					 <&tegra_car 56>;
+				nvidia,powergate = <TEGRA_POWERGATE_SOR>;
+				#power-domain-cells = <0>;
+
+				pd_dc: dc-power-domain {
+					clocks = <&tegra_car TEGRA124_CLK_DISP1>;
+					resets = <&tegra_car 27>;
+					nvidia,powergate = <TEGRA_POWERGATE_DIS>;
+					nvidia,swgroups = <&mc TEGRA_SWGROUP_DC>;
+					#nvidia,swgroup-cells = <1>;
+					#power-domain-cells = <0>;
+
+					pd_dcb: dcb-power-domain {
+						clocks = <&tegra_car TEGRA124_CLK_DISP2>;
+						resets = <&tegra_car 26>;
+						nvidia,powergate = <TEGRA_POWERGATE_DISB>;
+						nvidia,swgroups = <&mc TEGRA_SWGROUP_DCB>;
+						#nvidia,swgroup-cells = <1>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
 	};
 
 	fuse@0,7000f800 {
@@ -621,6 +699,8 @@
 			<&tegra_car 129>;
 		reset-names = "sata", "sata-oob", "sata-cold";
 
+		power-domains = <&pd_sata>;
+
 		phys = <&padctl TEGRA_XUSB_PADCTL_SATA>;
 		phy-names = "sata-phy";
 
-- 
2.1.4

