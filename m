From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v4 09/11] arm64: tegra: add soctherm node for Tegra210
Date: Mon, 9 May 2016 14:54:02 +0800
Message-ID: <1462776844-2152-10-git-send-email-wni@nvidia.com>
References: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3311 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbcEIGwz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 02:52:55 -0400
In-Reply-To: <1462776844-2152-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>

Adds soctherm node for Tegra210, and add cpu,
gpu, mem, pllx as thermal-zones. Set critical
trip temperatures for them.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 76fe31faa1a5..97d75149a1ac 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/memory/tegra210-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
 
 / {
 	compatible = "nvidia,tegra210";
@@ -804,4 +805,47 @@
 				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		interrupt-parent = <&gic>;
 	};
+
+	soctherm: thermal-sensor@700e2000 {
+		compatible = "nvidia,tegra210-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA210_CLK_TSENSOR>,
+			<&tegra_car TEGRA210_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+		#thermal-sensor-cells = <1>;
+	};
+
+	thermal-zones {
+		cpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <0>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+		};
+		mem {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+		};
+		gpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <0>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+		};
+		pllx {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+		};
+	};
 };
-- 
1.9.1

