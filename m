From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] thermal: Default OF created trip points to writable
Date: Tue, 10 Feb 2015 18:21:46 +0000
Message-ID: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:44858 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752198AbbBJSVX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Feb 2015 13:21:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

When registering a thermal zone from device tree, default the trip
points to writable. By default, only the root user can change these.

This allows the trip points to be tweaked after the system has
booted.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
Hi Eduardo,

We've been using this patch internally and haven't run into any
 issues. Without these changes there is no way to change trip points
 from a running system.

Comments welcome.

Cheers,
Punit

 drivers/thermal/of-thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 668fb1b..b7ad5c0 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
 	for_each_child_of_node(np, child) {
 		struct thermal_zone_device *zone;
 		struct thermal_zone_params *tzp;
+		int i, mask = 0;
 
 		/* Check whether child is enabled or not */
 		if (!of_device_is_available(child))
@@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
 		/* No hwmon because there might be hwmon drivers registering */
 		tzp->no_hwmon = true;
 
+		for (i = 0; i < tz->ntrips; i++)
+			mask |= 1 << i;
+
 		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    0, tz,
+						    mask, tz,
 						    ops, tzp,
 						    tz->passive_delay,
 						    tz->polling_delay);
-- 
2.1.4

