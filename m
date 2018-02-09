From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/10] dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
Date: Fri,  9 Feb 2018 14:28:10 +0530
Message-ID: <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1518166039.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1518166039.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The "cooling-min-level" and "cooling-max-level" properties are not
parsed by any part of kernel currently and the max cooling state of a
CPU cooling device is found by referring to the cpufreq table instead.

Remove the unused bindings.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 1719d47a5e2f..cc553f0952c5 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -55,8 +55,7 @@ of heat dissipation). For example a fan's cooling states correspond to
 the different fan speeds possible. Cooling states are referred to by
 single unsigned integers, where larger numbers mean greater heat
 dissipation. The precise set of cooling states associated with a device
-(as referred to by the cooling-min-level and cooling-max-level
-properties) should be defined in a particular device's binding.
+should be defined in a particular device's binding.
 For more examples of cooling devices, refer to the example sections below.
 
 Required properties:
@@ -69,15 +68,6 @@ For more examples of cooling devices, refer to the example sections below.
 			See Cooling device maps section below for more details
 			on how consumers refer to cooling devices.
 
-Optional properties:
-- cooling-min-level:	An integer indicating the smallest
-  Type: unsigned	cooling state accepted. Typically 0.
-  Size: one cell
-
-- cooling-max-level:	An integer indicating the largest
-  Type: unsigned	cooling state accepted.
-  Size: one cell
-
 * Trip points
 
 The trip node is a node to describe a point in the temperature domain
@@ -226,8 +216,6 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
-		cooling-min-level = <0>;
-		cooling-max-level = <3>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 	...
@@ -241,8 +229,6 @@ cpus {
 	 */
 	fan0: fan@48 {
 		...
-		cooling-min-level = <0>;
-		cooling-max-level = <9>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 };
-- 
2.15.0.194.g9af6a3dea062

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
