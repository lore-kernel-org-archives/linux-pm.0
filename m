From: Wei Ni <wni@nvidia.com>
Subject: [PATCH V9 08/14] of: add notes of critical trips for soctherm
Date: Tue, 29 Mar 2016 17:17:46 +0800
Message-ID: <1459243066-25468-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, thierry.reding@gmail.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The "critical" type trip in thermal zone can be
set to SOC_THERM hardware, it can trigger shut down
or reset event from hardware.

Signed-off-by: Wei Ni <wni@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
index 6b68cd150405..351a7376baa8 100644
--- a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -26,6 +26,10 @@ Required properties :
     of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
     list of valid values when referring to thermal sensors.
 
+Note:
+- the "critical" type trip points will be set to SOC_THERM hardware as the
+shut down temperature. Once the temperature of this thermal zone is higher
+than it, the system will be shutdown or reset by hardware.
 
 Example :
 
@@ -51,5 +55,13 @@ Example: referring to thermal sensors :
 
                         thermal-sensors =
                                 <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu_shutdown_trip: shutdown-trip {
+					temperature = <102500>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
                 };
 	};
-- 
1.9.1
