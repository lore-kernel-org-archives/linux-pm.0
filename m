From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v3] arm64: dts: ls1088a: add one more thermal zone node
Date: Mon,  4 Mar 2019 15:50:50 +0800
Message-ID: <20190304075050.33432-1-andy.tang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawnguo@kernel.org
Cc: leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, edubezval@gmail.com, Yuantian Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core cluster
sensor is used to monitor the temperature of core and SoC platform is for
platform. The current dts only support the first sensor.
This patch adds the second sensor node to dts to enable it.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
v3:
	- use more descriptive name for each zone
v2:
	- Add more information about sensors to description
PS: In order to keep consistency to the first thermal-zone node, there will
be "WARNING: line over 80 characters" warnings.

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   43 +++++++++++++++++++++--
 1 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 661137f..54f973b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -129,19 +129,19 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		core_cluster_thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
 
 			trips {
-				cpu_alert: cpu-alert {
+				core_cluster_alert: core_cluster-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu-crit {
+				core_cluster_crit: core_cluster-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -150,7 +150,42 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&core_cluster_alert>;
+					cooling-device =
+						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		platform-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+
+			trips {
+				platform_alert: platform-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				platform_crit: platform-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&platform_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-- 
1.7.1
