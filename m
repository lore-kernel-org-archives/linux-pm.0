From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 RESEND 14/14] arm: tegra: set critical trips for Tegra124
Date: Tue, 29 Mar 2016 18:29:24 +0800
Message-ID: <1459247364-1139-15-git-send-email-wni@nvidia.com>
References: <1459247364-1139-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:7282 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756673AbcC2KfH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 06:35:07 -0400
In-Reply-To: <1459247364-1139-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Set general "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones for all Tegra124 platform, these trips can trigger
shut down or reset.
Tegra124 Jetson TK1 was already set "critical" trips before, so it
can overwrite the general values.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 18 ++--------
 arch/arm/boot/dts/tegra124.dtsi           | 60 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 66b4451eb2ca..0e24ecd71ac7 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1931,44 +1931,32 @@
 	thermal-zones {
 		cpu {
 			trips {
-				trip@0 {
+				cpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/* There are currently no cooling maps because there are no cooling devices */
-			};
 		};
 
 		mem {
 			trips {
-				trip@0 {
+				mem-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/* There are currently no cooling maps because there are no cooling devices */
-			};
 		};
 
 		gpu {
 			trips {
-				trip@0 {
+				gpu-shutdown-trip {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
-
-			cooling-maps {
-				/* There are currently no cooling maps because there are no cooling devices */
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 68669f791c8b..076a384848ba 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -996,6 +996,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu-shutdown-trip {
+					temperature = <103000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
 		};
 
 		mem {
@@ -1004,6 +1019,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+
+			trips {
+				mem-shutdown-trip {
+					temperature = <103000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
 		};
 
 		gpu {
@@ -1012,6 +1042,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+
+			trips {
+				gpu-shutdown-trip {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
 		};
 
 		pllx {
@@ -1020,6 +1065,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+
+			trips {
+				pllx-shutdown-trip {
+					temperature = <103000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
 		};
 	};
 
-- 
1.9.1

