From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 2/5] thermal: fair_share: use the weight from the thermal instance
Date: Thu, 22 Jan 2015 17:27:02 +0000
Message-ID: <1421947625-19708-3-git-send-email-javi.merino@arm.com>
References: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41134 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbbAVR1z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jan 2015 12:27:55 -0500
In-Reply-To: <1421947625-19708-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Punit.Agrawal@arm.com, Kapileshwar.Singh@arm.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

The fair share governor is not usable with thermal zones that use the
bind op and don't populate thermal_zone_parameters, the majority of
them.  Now that the weight is in the thermal instance, we can use that
in the fair share governor to allow every thermal zone to trivially use
this governor.  Furthermore, this simplifies the code.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/fair_share.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
index c3b25187b467..9e392d34ac9f 100644
--- a/drivers/thermal/fair_share.c
+++ b/drivers/thermal/fair_share.c
@@ -88,24 +88,13 @@ static long get_target_state(struct thermal_zone_device *tz,
  */
 static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
 {
-	const struct thermal_zone_params *tzp;
-	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
-	int i;
 	int cur_trip_level = get_trip_level(tz);
 
-	if (!tz->tzp || !tz->tzp->tbp)
-		return -EINVAL;
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct thermal_cooling_device *cdev = instance->cdev;
 
-	tzp = tz->tzp;
-
-	for (i = 0; i < tzp->num_tbps; i++) {
-		if (!tzp->tbp[i].cdev)
-			continue;
-
-		cdev = tzp->tbp[i].cdev;
-		instance = get_thermal_instance(tz, cdev, trip);
-		if (!instance)
+		if (instance->trip != trip)
 			continue;
 
 		instance->target = get_target_state(tz, cdev,
-- 
1.9.1

