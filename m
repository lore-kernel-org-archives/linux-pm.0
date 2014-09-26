From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: [PATCH v6 1/4] of: Add bindings for nvidia,tegra124-soctherm
Date: Fri, 26 Sep 2014 12:43:10 +0300
Message-ID: <1411724593-4037-2-git-send-email-cyndis@kapsi.fi>
References: <1411724593-4037-1-git-send-email-cyndis@kapsi.fi>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411724593-4037-1-git-send-email-cyndis-/1wQRMveznE@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, juha-matti.tilli-X3B1VOXEql0@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This adds binding documentation and headers for the Tegra124
SOCTHERM device tree node.

Signed-off-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/thermal/tegra-soctherm.txt | 53 ++++++++++++++++++++++
 include/dt-bindings/thermal/tegra124-soctherm.h    | 13 ++++++
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
 create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h

diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
new file mode 100644
index 0000000..ecf3ed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -0,0 +1,53 @@
+Tegra124 SOCTHERM thermal management system
+
+The SOCTHERM IP block contains thermal sensors, support for polled
+or interrupt-based thermal monitoring, CPU and GPU throttling based
+on temperature trip points, and handling external overcurrent
+notifications. It is also used to manage emergency shutdown in an
+overheating situation.
+
+Required properties :
+- compatible : "nvidia,tegra124-soctherm".
+- reg : Should contain 1 entry:
+  - SOCTHERM register set
+- interrupts : Defines the interrupt used by SOCTHERM
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - tsensor
+  - soctherm
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - soctherm
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
+    of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
+    list of valid values when referring to thermal sensors.
+
+
+Example :
+
+	soctherm@0,700e2000 {
+		compatible = "nvidia,tegra124-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+			<&tegra_car TEGRA124_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+
+		#thermal-sensor-cells = <1>;
+	};
+
+Example: referring to thermal sensors :
+
+       thermal-zones {
+                cpu {
+                        polling-delay-passive = <1000>;
+                        polling-delay = <1000>;
+
+                        thermal-sensors =
+                                <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+                };
+	};
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
new file mode 100644
index 0000000..85aaf66
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -0,0 +1,13 @@
+/*
+ * This header provides constants for binding nvidia,tegra124-soctherm.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+#define _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+
+#define TEGRA124_SOCTHERM_SENSOR_CPU 0
+#define TEGRA124_SOCTHERM_SENSOR_MEM 1
+#define TEGRA124_SOCTHERM_SENSOR_GPU 2
+#define TEGRA124_SOCTHERM_SENSOR_PLLX 3
+
+#endif
-- 
2.1.0
