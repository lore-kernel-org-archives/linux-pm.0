From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v2 01/12] of: Add bindings of thermtrip for Tegra soctherm
Date: Thu, 21 Feb 2019 18:18:36 +0800
Message-ID: <1550744327-4677-2-git-send-email-wni@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Add optional property "nvidia,thermtrips".
If present, these trips will be used as HW shutdown trips,
and critical trips will be used as SW shutdown trips.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.txt    | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index b6c0ae53d4dc..ab66d6feab4b 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -55,10 +55,21 @@ Required properties :
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
         See ./thermal.txt for a description of this property.
 
+Optional properties:
+- nvidia,thermtrips : When present, this property specifies the temperature at
+  which the soctherm hardware will assert the thermal trigger signal to the
+  Power Management IC, which can be configured to reset or shutdown the device.
+  It is an array of pairs where each pair represents a tsensor id followed by a
+  temperature in milli Celcius. In the absence of this property the critical
+  trip point will be used for thermtrip temperature.
+
 Note:
-- the "critical" type trip points will be set to SOC_THERM hardware as the
-shut down temperature. Once the temperature of this thermal zone is higher
-than it, the system will be shutdown or reset by hardware.
+- the "critical" type trip points will be used to set the temperature at which
+the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
+property is missing. When the thermtrips property is present, the breach of a
+critical trip point is reported back to the thermal framework to implement
+software shutdown.
+
 - the "hot" type trip points will be set to SOC_THERM hardware as the throttle
 temperature. Once the the temperature of this thermal zone is higher
 than it, it will trigger the HW throttle event.
@@ -79,6 +90,9 @@ Example :
 
 		#thermal-sensor-cells = <1>;
 
+		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
+				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
 		throttle-cfgs {
 			/*
 			 * When the "heavy" cooling device triggered,
-- 
2.7.4
