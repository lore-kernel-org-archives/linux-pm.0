From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 2/9] arm64: tegra: use tegra132-soctherm for Tegra132
Date: Wed, 27 Apr 2016 11:25:47 +0800
Message-ID: <1461727554-15065-3-git-send-email-wni@nvidia.com>
References: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461727554-15065-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The Tegra132 has the specific settings for soctherm,
so change to use campatible "nvidia,tegra132-soctherm" for it.
And adds cpu, gpu, mem and pllx thermal zones.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 36 ++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 2013f8916084..e41d8e82d7ed 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
 
 / {
 	compatible = "nvidia,tegra132", "nvidia,tegra124";
@@ -727,8 +728,8 @@
 	};
 
 	soctherm: thermal-sensor@700e2000 {
-		compatible = "nvidia,tegra124-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x1000>;
+		compatible = "nvidia,tegra132-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x600>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
 			<&tegra_car TEGRA124_CLK_SOC_THERM>;
@@ -738,6 +739,37 @@
 		#thermal-sensor-cells = <1>;
 	};
 
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
+
 	ahub@70300000 {
 		compatible = "nvidia,tegra124-ahub";
 		reg = <0x0 0x70300000 0x0 0x200>,
-- 
1.9.1
