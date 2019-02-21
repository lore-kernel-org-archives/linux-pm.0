From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 03/12] arm64: dts: tegra210: set thermtrip
Date: Thu, 21 Feb 2019 18:18:38 +0800
Message-ID: <1550744327-4677-4-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Set "nvidia,thermtrips" property, it used to set
HW shutdown temperatures.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 6574396d2257..582d56820bbb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1410,6 +1410,9 @@
 		reset-names = "soctherm";
 		#thermal-sensor-cells = <1>;
 
+		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
+				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
 		throttle-cfgs {
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
@@ -1429,8 +1432,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu-shutdown-trip {
-					temperature = <102500>;
+				cpu-critical-trip {
+					temperature = <102000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1457,7 +1460,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				mem-shutdown-trip {
+				mem-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
@@ -1479,8 +1482,8 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu-shutdown-trip {
-					temperature = <103000>;
+				gpu-critical-trip {
+					temperature = <102500>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -1507,7 +1510,7 @@
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
 
 			trips {
-				pllx-shutdown-trip {
+				pllx-critical-trip {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
-- 
2.7.4
