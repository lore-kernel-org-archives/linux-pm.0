From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 05/11] arm: tegra: set hot trips for Tegra124
Date: Mon, 9 May 2016 14:53:58 +0800
Message-ID: <1462776844-2152-6-git-send-email-wni@nvidia.com>
References: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462776844-2152-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Enable throttle function for SOC_THERM.
Set "hot" trips for cpu and gpu thermal zones, which
can trigger the SOC_THERM hardware throttle.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra124.dtsi | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 08c7f85ea2c8..d37547412b3e 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -846,7 +846,9 @@
 
 	soctherm: thermal-sensor@0,700e2000 {
 		compatible = "nvidia,tegra124-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x1000>;
+		reg = <0x0 0x700e2000 0x0 0x600 /* SOC_THERM reg_base */
+			0x0 0x60006000 0x0 0x400>; /* CAR reg_base */
+		reg-names = "soctherm-reg", "car-reg";
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
 			<&tegra_car TEGRA124_CLK_SOC_THERM>;
@@ -854,6 +856,15 @@
 		resets = <&tegra_car 78>;
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
+
+		throttle-cfgs {
+			throttle_heavy: nvidia,heavy {
+				nvidia,priority = <100>;
+				nvidia,cpu-throt-percent = <85>;
+
+				#cooling-cells = <2>;
+			};
+		};
 	};
 
 	dfll: clock@0,70110000 {
@@ -1156,13 +1167,18 @@
 					hysteresis = <0>;
 					type = "critical";
 				};
+				cpu_throttle_trip: throttle-trip {
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
+					trip = <&cpu_throttle_trip>;
+					cooling-device = <&throttle_heavy 1 1>;
+				};
 			};
 		};
 
@@ -1202,13 +1218,18 @@
 					hysteresis = <0>;
 					type = "critical";
 				};
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
 
-- 
1.9.1
