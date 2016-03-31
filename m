From: Wei Ni <wni@nvidia.com>
Subject: [PATCH 3/9] arm64: tegra: set critical trips for Tegra132
Date: Thu, 31 Mar 2016 16:44:02 +0800
Message-ID: <1459413848-5405-4-git-send-email-wni@nvidia.com>
References: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459413848-5405-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Set general "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones on Tegra132, these trips can trigger shut down or reset.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 62 +++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index bd5010a7cba4..40fe2bcb55d2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -729,7 +729,7 @@
 
 	soctherm: thermal-sensor@0,700e2000 {
 		compatible = "nvidia,tegra132-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x1000>;
+		reg = <0x0 0x700e2000 0x0 0x600>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
 			<&tegra_car TEGRA124_CLK_SOC_THERM>;
@@ -746,6 +746,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu_shutdown_trip {
+					temperature = <105000>;
+					hysteresis = <1000>;
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
 			polling-delay-passive = <0>;
@@ -753,6 +768,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+
+			trips {
+				mem_shutdown_trip {
+					temperature = <101000>;
+					hysteresis = <1000>;
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
 			polling-delay-passive = <1000>;
@@ -760,6 +790,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+
+			trips {
+				gpu_shutdown_trip {
+					temperature = <101000>;
+					hysteresis = <1000>;
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
 			polling-delay-passive = <0>;
@@ -767,6 +812,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+
+			trips {
+				pllx_shutdown_trip {
+					temperature = <105000>;
+					hysteresis = <1000>;
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
