From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 1/4] arm64: tegra: Add BPMP thermal sensor to Tegra186
Date: Fri, 16 Jun 2017 14:28:22 +0300
Message-ID: <20170616112825.31025-1-mperttunen@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This adds the thermal sensor device provided by the BPMP, and the
relevant thermal sensors to the Tegra186 device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 5e62e68ac053..5c19ea74da24 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/power/tegra186-powergate.h>
 #include <dt-bindings/reset/tegra186-reset.h>
+#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
 
 / {
 	compatible = "nvidia,tegra186";
@@ -444,6 +445,53 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		bpmp_thermal: thermal {
+			compatible = "nvidia,tegra186-bpmp-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		a57 {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_CPU>;
+		};
+
+		denver {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AUX>;
+		};
+
+		gpu {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_GPU>;
+		};
+
+		pll {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_PLLX>;
+		};
+
+		always_on {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AO>;
+		};
 	};
 
 	timer {
-- 
2.13.1
