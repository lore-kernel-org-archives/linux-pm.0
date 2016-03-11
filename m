From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V7 12/12] arm: tegra: set critical trips for Tegra124
Date: Fri, 11 Mar 2016 11:11:44 +0800
Message-ID: <1457665904-30184-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Set "critical" trips for cpu and gpu thermal zones,
which can trigger shut down or reset.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index e4eac1f01e64..442fcf0cb394 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -996,6 +996,14 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu_shutdown_trip: shutdown-trip {
+					temperature = <103000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		mem {
@@ -1012,6 +1020,14 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+
+			trips {
+				gpu_shutdown_trip: shutdown-trip {
+					temperature = <101000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
 		};
 
 		pllx {
-- 
1.9.1
