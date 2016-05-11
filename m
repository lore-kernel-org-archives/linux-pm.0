From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v5 11/11] arm64: tegra: set hot trips for Tegra210
Date: Wed, 11 May 2016 18:20:26 +0800
Message-ID: <1462962026-19653-12-git-send-email-wni@nvidia.com>
References: <1462962026-19653-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5201 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbcEKKTN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 06:19:13 -0400
In-Reply-To: <1462962026-19653-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Enable throttle function for SOC_THERM.
Set "hot" trips for cpu and gpu thermal zones, which
can trigger the SOC_THERM hardware throttle.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 41 +++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index e55589c8a561..1bcd424d9da9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -808,7 +808,9 @@
 
 	soctherm: thermal-sensor@700e2000 {
 		compatible = "nvidia,tegra210-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x1000>;
+		reg = <0x0 0x700e2000 0x0 0x600 /* SOC_THERM reg_base */
+			0x0 0x60006000 0x0 0x400>; /* CAR reg_base */
+		reg-names = "soctherm-reg", "car-reg";
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA210_CLK_TSENSOR>,
 			<&tegra_car TEGRA210_CLK_SOC_THERM>;
@@ -816,6 +818,15 @@
 		resets = <&tegra_car 78>;
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
+
+		throttle-cfgs {
+			throttle_heavy: heavy {
+				nvidia,priority = <100>;
+				nvidia,cpu-throt-percent = <85>;
+
+				#cooling-cells = <2>;
+			};
+		};
 	};
 
 	thermal-zones {
@@ -832,13 +843,19 @@
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
@@ -876,13 +893,19 @@
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

