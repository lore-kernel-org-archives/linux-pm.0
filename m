From: Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH v5] arm64: dts: ls1088a: add one more thermal zone node
Date: Thu, 11 Apr 2019 16:32:36 +0800
Message-ID: <20190411083236.9377-1-andy.tang@nxp.com>
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
v5:
	- update the thermal zone name due to the length limitation
	- remove cooling map in platform zone
v4:
	- use hyphen instead of underscore in node name
v3:
	- use more descriptive name for each zone
v2:
	- Add more information about sensors to description
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   28 ++++++++++++++++++++---
 1 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index de93b42..de39672 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -129,19 +129,19 @@
 	};
 
 	thermal-zones {
-		cpu_thermal: cpu-thermal {
+		core-cluster {
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 			thermal-sensors = <&tmu 0>;
 
 			trips {
-				cpu_alert: cpu-alert {
+				core_cluster_alert: core-cluster-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_crit: cpu-crit {
+				core_cluster_crit: core-cluster-crit {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "critical";
@@ -150,7 +150,7 @@
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu_alert>;
+					trip = <&core_cluster_alert>;
 					cooling-device =
 						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -163,6 +163,26 @@
 				};
 			};
 		};
+
+		platform {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&tmu 1>;
+
+			trips {
+				platform-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				platform-crit {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
 	};
 
 	timer {
-- 
1.7.1
