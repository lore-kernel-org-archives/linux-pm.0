From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] dt-bindings: thermal: Allow multiple devices to share cooling map
Date: Thu,  5 Jul 2018 10:39:23 +0530
Message-ID: <bdd735da9a3c8159756b084ca96b555437057fa4.1530766981.git.viresh.kumar@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530766981.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Allow cooling devices sharing same trip point with same contribution
value to share the cooling map as well. Otherwise the same information
will be duplicated for each device sharing the trip point.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index cc553f0952c5..eb7ee91556a5 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -97,8 +97,8 @@ get assigned to trip points of the zone. The cooling devices are expected
 to be loaded in the target system.
 
 Required properties:
-- cooling-device:	A phandle of a cooling device with its specifier,
-  Type: phandle +	referring to which cooling device is used in this
+- cooling-device:	A list of phandles of cooling devices with their specifiers,
+  Type: phandle +	referring to which cooling devices are used in this
     cooling specifier	binding. In the cooling specifier, the first cell
 			is the minimum cooling state and the second cell
 			is the maximum cooling state used in this map.
@@ -276,12 +276,7 @@ thermal-zones {
 			};
 			map1 {
 				trip = <&cpu_alert1>;
-				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>;
-			};
-			map2 {
-				trip = <&cpu_alert1>;
-				cooling-device =
-				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>, <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 			};
 		};
 	};
-- 
2.18.0.rc1.242.g61856ae69a2c
