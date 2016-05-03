From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v3 10/11] arm64: tegra: set critical trips for Tegra210
Date: Tue, 3 May 2016 18:13:29 +0800
Message-ID: <1462270410-2425-11-git-send-email-wni@nvidia.com>
References: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462270410-2425-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Set general "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones on Tegra210, these trips can trigger shut down or reset.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 361a40c9fe57..699825ded4e9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -825,6 +825,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu-shutdown-trip {
+					temperature = <102500>;
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
 			polling-delay-passive = <0>;
@@ -832,6 +847,21 @@
 
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
 			polling-delay-passive = <1000>;
@@ -839,6 +869,21 @@
 
 			thermal-sensors =
 				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+
+			trips {
+				gpu-shutdown-trip {
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
 		pllx {
 			polling-delay-passive = <0>;
@@ -846,6 +891,21 @@
 
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
 };
-- 
1.9.1
