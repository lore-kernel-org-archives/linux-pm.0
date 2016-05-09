From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 04/11] arm: tegra: set critical trips for Tegra124
Date: Mon, 9 May 2016 14:53:57 +0800
Message-ID: <1462776844-2152-5-git-send-email-wni@nvidia.com>
References: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462776844-2152-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
index 941f36263c8f..40ad62c9c62e 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -2049,44 +2049,32 @@
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
index ea4811870de2..08c7f85ea2c8 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -1149,6 +1149,21 @@
 
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
@@ -1157,6 +1172,21 @@
 
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
@@ -1165,6 +1195,21 @@
 
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
@@ -1173,6 +1218,21 @@
 
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
