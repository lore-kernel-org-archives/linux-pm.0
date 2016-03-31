From: Wei Ni <wni@nvidia.com>
Subject: [PATCH 8/9] arm64: tegra: set hot trips for Tegra132
Date: Thu, 31 Mar 2016 16:44:07 +0800
Message-ID: <1459413848-5405-9-git-send-email-wni@nvidia.com>
References: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18936 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbcCaIoV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 04:44:21 -0400
In-Reply-To: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Enable throttle function for SOC_THERM.
Set "hot" trips for cpu and gpu thermal zones, which
can trigger the SOC_THERM hardware throttle.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 41 +++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 40fe2bcb55d2..48a0f8858bbb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -729,7 +729,9 @@
 
 	soctherm: thermal-sensor@0,700e2000 {
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
+		throttle-cfgs {
+			throttle_heavy: heavy {
+				priority = <100>;
+				cpu-throt-depth = <85>;
+
+				#cooling-cells = <1>;
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

