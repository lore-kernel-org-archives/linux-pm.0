From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v3 08/11] arm64: tegra: set hot trips for Tegra132
Date: Tue, 3 May 2016 18:13:27 +0800
Message-ID: <1462270410-2425-9-git-send-email-wni@nvidia.com>
References: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Enable throttle function for SOC_THERM.
Set "hot" trips for cpu and gpu thermal zones, which
can trigger the SOC_THERM hardware throttle.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 41 +++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 92df892f5f23..ee101cb52f70 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -729,7 +729,9 @@
 
 	soctherm: thermal-sensor@700e2000 {
 		compatible = "nvidia,tegra132-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x600>;
+		reg = <0x0 0x700e2000 0x0 0x600 /* 0: SOC_THERM reg_base */
+			0x0 0x70040000 0x0 0x200>; /* 2: CCROC reg_base */
+		reg-names = "soctherm-reg", "ccroc-reg";
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
 			<&tegra_car TEGRA124_CLK_SOC_THERM>;
@@ -737,6 +739,15 @@
 		resets = <&tegra_car 78>;
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
+
+		nvidia,throttle-cfgs {
+			throttle_heavy: nvidia,heavy {
+				nvidia,priority = <100>;
+				nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
+
+				#cooling-cells = <2>;
+			};
+		};
 	};
 
 	thermal-zones {
@@ -753,13 +764,19 @@
 					hysteresis = <1000>;
 					type = "critical";
 				};
+
+				cpu_throttle_trip: throttle-trip {
+					temperature = <102000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
-				/*
-				 * There are currently no cooling maps,
-				 * because there are no cooling devices.
-				 */
+				map0 {
+					trip = <&cpu_throttle_trip>;
+					cooling-device = <&throttle_heavy 1 1>;
+				};
 			};
 		};
 		mem {
@@ -797,13 +814,19 @@
 					hysteresis = <1000>;
 					type = "critical";
 				};
+
+				gpu_throttle_trip: throttle-trip {
+					temperature = <99000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
 			};
 
 			cooling-maps {
-				/*
-				 * There are currently no cooling maps,
-				 * because there are no cooling devices.
-				 */
+				map0 {
+					trip = <&gpu_throttle_trip>;
+					cooling-device = <&throttle_heavy 1 1>;
+				};
 			};
 		};
 		pllx {
-- 
1.9.1
