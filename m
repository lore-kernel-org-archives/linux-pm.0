From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 11/12] of: Add bindings of OC hw throttle for Tegra soctherm
Date: Thu, 21 Feb 2019 18:18:46 +0800
Message-ID: <1550744327-4677-12-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add OC HW throttle configuration for soctherm in DT.
It is used to describe the OCx throttle events.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index cf6d0be56b7a..f02f38527a6b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -64,6 +64,20 @@ Required properties :
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
+      Optional properties: The following properties are T210 specific and
+      valid only for OCx throttle events.
+      - nvidia,count-threshold: Specifies the number of OC events that are
+        required for triggering an interrupt. Interrupts are not triggered if
+        the property is missing. A value of 0 will interrupt on every OC alarm.
+      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
+        signal. If present, this means assert low, otherwise assert high.
+      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
+        expires (which means the OC event has not occurred for a long time),
+        the counter is cleared and filter is rearmed. Default value is 0.
+      - nvidia,throttle-period-us: Specifies the number of uSec for which
+        throttling is engaged after the OC event is deasserted. Default value
+        is 0.
+
 Optional properties:
 - nvidia,thermtrips : When present, this property specifies the temperature at
   which the soctherm hardware will assert the thermal trigger signal to the
@@ -134,6 +148,17 @@ Example :
 			 * arbiter will select the highest priority as the final throttle
 			 * settings to skip cpu pulse.
 			 */
+
+			throttle_oc1: oc1 {
+				nvidia,priority = <50>;
+				nvidia,polarity-active-low;
+				nvidia,count-threshold = <100>;
+				nvidia,alarm-filter = <5100000>;
+				nvidia,throttle-period-us = <0>;
+				nvidia,cpu-throt-percent = <75>;
+				nvidia,gpu-throt-level =
+						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+                        };
 		};
 	};
 
-- 
2.7.4
