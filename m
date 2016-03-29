From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V9 14/14] arm: tegra: set critical trips for Tegra124
Date: Tue, 29 Mar 2016 17:18:55 +0800
Message-ID: <1459243135-25764-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Set general "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones for all Tegra124 platform, these trips can trigger
shut down or reset.
Tegra124 Jetson TK1 was already set "critical" trips before, so it
can overwrite the general values.

Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
