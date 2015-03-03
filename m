From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 1/2] thermal: core: Add Kconfig option to enable writable trips
Date: Tue,  3 Mar 2015 10:43:03 +0000
Message-ID: <1425379384-17000-2-git-send-email-punit.agrawal@arm.com>
References: <1425379384-17000-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:34417 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754819AbbCCKnA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 05:43:00 -0500
In-Reply-To: <1425379384-17000-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, Punit Agrawal <punit.agrawal@arm.com>

Add a Kconfig option to allow system integrators to control whether
userspace tools can change trip temperatures. This option overrides
the thermal zone setup in the driver code and must be enabled for
platform specified writable trips to come into effect.

The original behaviour of requiring root privileges to change trip
temperatures remains unchanged.

Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 drivers/thermal/Kconfig        | 11 +++++++++++
 drivers/thermal/thermal_core.c |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index af40db0..5d2d39b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -42,6 +42,17 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_WRITABLE_TRIPS
+	bool "Enable writable trip points"
+	help
+	  This option allows the system integrator to choose whether
+	  trip temperatures can be changed from userspace. The
+	  writable trips need to be specified when setting up the
+	  thermal zone but the choice here takes precedence.
+
+	  Say 'Y' here if you would like to allow userspace tools to
+	  change trip temperatures.
+
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..15111c1 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1378,7 +1378,8 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
-		if (mask & (1 << indx)) {
+		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
+		    mask & (1 << indx)) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
-- 
2.1.4

