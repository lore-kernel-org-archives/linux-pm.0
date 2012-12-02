From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 15/34] Thermal: Add documentation for platform layer data
Date: Sun,  2 Dec 2012 22:44:49 +0800
Message-ID: <1354459508-3707-15-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:34443 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab2LBOpj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:39 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Durgadoss R <durgadoss.r@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Durgadoss R <durgadoss.r@intel.com>

This patch adds documentation for thermal_bind_params
and thermal_zone_params structures. Also, adds details
on EXPORT_SYMBOL APIs.

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   64 +++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index ca1a1a3..88c0233 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -112,6 +112,29 @@ temperature) and throttle appropriate devices.
     trip: indicates which trip point the cooling devices is associated with
 	  in this thermal zone.
 
+1.4 Thermal Zone Parameters
+1.4.1 struct thermal_bind_params
+    This structure defines the following parameters that are used to bind
+    a zone with a cooling device for a particular trip point.
+    .cdev: The cooling device pointer
+    .weight: The 'influence' of a particular cooling device on this zone.
+             This is on a percentage scale. The sum of all these weights
+             (for a particular zone) cannot exceed 100.
+    .trip_mask:This is a bit mask that gives the binding relation between
+               this thermal zone and cdev, for a particular trip point.
+               If nth bit is set, then the cdev and thermal zone are bound
+               for trip point n.
+    .match: This call back returns success(0) if the 'tz and cdev' need to
+	    be bound, as per platform data.
+1.4.2 struct thermal_zone_params
+    This structure defines the platform level parameters for a thermal zone.
+    This data, for each thermal zone should come from the platform layer.
+    This is an optional feature where some platforms can choose not to
+    provide this data.
+    .governor_name: Name of the thermal governor used for this zone
+    .num_tbps: Number of thermal_bind_params entries for this zone
+    .tbp: thermal_bind_params entries
+
 2. sysfs attributes structure
 
 RO	read only value
@@ -126,6 +149,7 @@ if hwmon is compiled in or built as a module.
     |---type:			Type of the thermal zone
     |---temp:			Current temperature
     |---mode:			Working mode of the thermal zone
+    |---policy:			Thermal governor used for this zone
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
     |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
@@ -187,6 +211,10 @@ mode
 			  charge of the thermal management.
 	RW, Optional
 
+policy
+	One of the various thermal governors used for a particular zone.
+	RW, Required
+
 trip_point_[0-*]_temp
 	The temperature above which trip point will be fired.
 	Unit: millidegree Celsius
@@ -264,6 +292,7 @@ If the processor is listed in _PSL method, and the fan is listed in _AL0
     |---type:			acpitz
     |---temp:			37000
     |---mode:			enabled
+    |---policy:			step_wise
     |---trip_point_0_temp:	100000
     |---trip_point_0_type:	critical
     |---trip_point_1_temp:	80000
@@ -305,3 +334,38 @@ to a thermal_zone_device when it registers itself with the framework. The
 event will be one of:{THERMAL_AUX0, THERMAL_AUX1, THERMAL_CRITICAL,
 THERMAL_DEV_FAULT}. Notification can be sent when the current temperature
 crosses any of the configured thresholds.
+
+5. Export Symbol APIs:
+
+5.1: get_tz_trend:
+This function returns the trend of a thermal zone, i.e the rate of change
+of temperature of the thermal zone. Ideally, the thermal sensor drivers
+are supposed to implement the callback. If they don't, the thermal
+framework calculated the trend by comparing the previous and the current
+temperature values.
+
+5.2:get_thermal_instance:
+This function returns the thermal_instance corresponding to a given
+{thermal_zone, cooling_device, trip_point} combination. Returns NULL
+if such an instance does not exist.
+
+5.3:notify_thermal_framework:
+This function handles the trip events from sensor drivers. It starts
+throttling the cooling devices according to the policy configured.
+For CRITICAL and HOT trip points, this notifies the respective drivers,
+and does actual throttling for other trip points i.e ACTIVE and PASSIVE.
+The throttling policy is based on the configured platform data; if no
+platform data is provided, this uses the step_wise throttling policy.
+
+5.4:thermal_cdev_update:
+This function serves as an arbitrator to set the state of a cooling
+device. It sets the cooling device to the deepest cooling state if
+possible.
+
+5.5:thermal_register_governor:
+This function lets the various thermal governors to register themselves
+with the Thermal framework. At run time, depending on a zone's platform
+data, a particular governor is used for throttling.
+
+5.6:thermal_unregister_governor:
+This function unregisters a governor from the thermal framework.
-- 
1.7.7.6

