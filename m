From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 1/3] dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
Date: Fri, 23 Nov 2018 13:18:37 +0100
Message-ID: <20181123121839.18573-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The thermal controller implementation on Tegra194 is very similar to the
implementation on Tegra186. Add a compatible string for the new
generation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../thermal/nvidia,tegra186-bpmp-thermal.txt      |  3 ++-
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h   | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
index 276387dd6815..e17c07be270b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
@@ -15,7 +15,8 @@ Required properties:
 - compatible:
     Array of strings.
     One of:
-    - "nvidia,tegra186-bpmp-thermal".
+    - "nvidia,tegra186-bpmp-thermal"
+    - "nvidia,tegra194-bpmp-thermal"
 - #thermal-sensor-cells: Cell for sensor index.
     Single-cell integer.
     Must be <1>.
diff --git a/include/dt-bindings/thermal/tegra194-bpmp-thermal.h b/include/dt-bindings/thermal/tegra194-bpmp-thermal.h
new file mode 100644
index 000000000000..aa7fb08135ca
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra194-bpmp-thermal.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for binding nvidia,tegra194-bpmp-thermal.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA194_BPMP_THERMAL_H
+#define _DT_BINDINGS_THERMAL_TEGRA194_BPMP_THERMAL_H
+
+#define TEGRA194_BPMP_THERMAL_ZONE_CPU 2
+#define TEGRA194_BPMP_THERMAL_ZONE_GPU 3
+#define TEGRA194_BPMP_THERMAL_ZONE_AUX 4
+#define TEGRA194_BPMP_THERMAL_ZONE_PLLX 5
+#define TEGRA194_BPMP_THERMAL_ZONE_AO 6
+#define TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX 7
+
+#endif
-- 
2.19.1
