From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 04/12] of: Add bindings of gpu hw throttle for Tegra soctherm
Date: Thu, 21 Feb 2019 18:18:39 +0800
Message-ID: <1550744327-4677-5-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add "nvidia,gpu-throt-level" property to set gpu hw
throttle level.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt       | 17 +++++++++++++++--
 include/dt-bindings/thermal/tegra124-soctherm.h         |  8 ++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index ab66d6feab4b..cf6d0be56b7a 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -52,6 +52,15 @@ Required properties :
         Must set as following values:
         TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
         TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
+      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
+        It is the level of pulse skippers, which used to throttle clock
+        frequencies. It indicates gpu clock throttling depth and can be
+        programmed to any of the following values which represent a throttling
+        percentage:
+        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
+        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
+        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
+        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
@@ -96,22 +105,26 @@ Example :
 		throttle-cfgs {
 			/*
 			 * When the "heavy" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 85% depth
+			 * the HW will skip cpu clock's pulse in 85% depth,
+			 * skip gpu clock's pulse in 85% level
 			 */
 			throttle_heavy: heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
 
 				#cooling-cells = <1>;
 			};
 
 			/*
 			 * When the "light" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 50% depth
+			 * the HW will skip cpu clock's pulse in 50% depth,
+			 * skip gpu clock's pulse in 50% level
 			 */
 			throttle_light: light {
 				nvidia,priority = <80>;
 				nvidia,cpu-throt-percent = <50>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
 
 				#cooling-cells = <1>;
 			};
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
index c15e8b709a0d..444c7bdde146 100644
--- a/include/dt-bindings/thermal/tegra124-soctherm.h
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -12,9 +12,9 @@
 #define TEGRA124_SOCTHERM_SENSOR_PLLX 3
 #define TEGRA124_SOCTHERM_SENSOR_NUM 4
 
-#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  0
-#define TEGRA_SOCTHERM_THROT_LEVEL_MED  1
-#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 2
-#define TEGRA_SOCTHERM_THROT_LEVEL_NONE -1
+#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
+#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
+#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
+#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
 
 #endif
-- 
2.7.4
