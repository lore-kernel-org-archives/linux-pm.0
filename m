From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 7/9] arm64: tegra: set hot trips for Tegra210
Date: Wed, 27 Apr 2016 11:25:52 +0800
Message-ID: <1461727554-15065-8-git-send-email-wni@nvidia.com>
References: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Enable throttle function for SOC_THERM.
Set "hot" trips for cpu and gpu thermal zones, which
can trigger the SOC_THERM hardware throttle.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 41 +++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index e3cca58a4c86..332771ab38e8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -804,7 +804,9 @@
 
 	soctherm: thermal-sensor@0,700e2000 {
 		compatible = "nvidia,tegra210-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x1000>;
+		reg = <0x0 0x700e2000 0x0 0x600 /* SOC_THERM reg_base */
+			0x0 0x60006000 0x0 0x400>; /* CAR reg_base */
+		reg-names = "soctherm-reg", "car-reg";
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_TSENSOR>,
 			<&tegra_car TEGRA210_CLK_SOC_THERM>;
@@ -812,6 +814,15 @@
 		resets = <&tegra_car 78>;
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
+
+		throttle-cfgs {
+			throttle_heavy: heavy {
+				priority = <100>;
+				cpu-throt-depth = <85>;
+
+				#cooling-cells = <2>;
+			};
+		};
 	};
 
 	thermal-zones {
@@ -828,13 +839,19 @@
 					hysteresis = <0>;
 					type = "critical";
 				};
+
+				cpu_throttle_trip: throttle-trip {
+					temperature = <98500>;
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
@@ -872,13 +889,19 @@
 					hysteresis = <0>;
 					type = "critical";
 				};
+
+				gpu_throttle_trip: throttle-trip {
+					temperature = <100000>;
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
