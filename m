From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] Thermal: update documentation for thermal_zone_device_register
Date: Thu, 25 Apr 2013 00:59:22 +0800
Message-ID: <1366822762-1290-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18840 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753407Ab3DXQ7Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Apr 2013 12:59:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, Zhang Rui <rui.zhang@intel.com>

Update kernel Documentation for thermal_zone_device_register.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/thermal/sysfs-api.txt |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index bb42266..a71bd5b 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -31,15 +31,17 @@ temperature) and throttle appropriate devices.
 1. thermal sysfs driver interface functions
 
 1.1 thermal zone device interface
-1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *name,
+1.1.1 struct thermal_zone_device *thermal_zone_device_register(char *type,
 		int trips, int mask, void *devdata,
-		struct thermal_zone_device_ops *ops)
+		struct thermal_zone_device_ops *ops,
+		const struct thermal_zone_params *tzp,
+		int passive_delay, int polling_delay))
 
     This interface function adds a new thermal zone device (sensor) to
     /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
     thermal cooling devices registered at the same time.
 
-    name: the thermal zone name.
+    type: the thermal zone type.
     trips: the total number of trip points this thermal zone supports.
     mask: Bit string: If 'n'th bit is set, then trip point 'n' is writeable.
     devdata: device private data
@@ -57,6 +59,12 @@ temperature) and throttle appropriate devices.
 			will be fired.
 	.set_emul_temp: set the emulation temperature which helps in debugging
 			different threshold temperature points.
+    tzp: thermal zone platform parameters.
+    passive_delay: number of milliseconds to wait between polls when
+	performing passive cooling.
+    polling_delay: number of milliseconds to wait between polls when checking
+	whether trip points have been crossed (0 for interrupt driven systems).
+
 
 1.1.2 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
-- 
1.7.9.5

