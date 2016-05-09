From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v4 07/11] arm64: tegra: set critical trips for Tegra132
Date: Mon, 9 May 2016 14:54:00 +0800
Message-ID: <1462776844-2152-8-git-send-email-wni@nvidia.com>
References: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13980 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbcEIGwu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 02:52:50 -0400
In-Reply-To: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Set general "critical" trip temperatures for cpu, gpu, mem and pllx
thermal zones on Tegra132, these trips can trigger shut down or reset.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index e41d8e82d7ed..a3889e930010 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
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

