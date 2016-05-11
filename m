From: Michele Di Giorgio <michele.digiorgio@arm.com>
Subject: [PATCH] thermal: check validity get_trip_hyst function pointer in bang-bang governor
Date: Wed, 11 May 2016 10:49:07 +0100
Message-ID: <1462960147-9175-1-git-send-email-michele.digiorgio@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57254 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751129AbcEKJyl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2016 05:54:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Michele Di Giorgio <michele.digiorgio@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Peter Feuerer <peter@piie.net>

Bang-bang thermal governor uses trip point hysteresis to make decisions.
Hysteresis is a required property in the device tree for trip points, but it is
an optional thermal zone device operation. Hence, we need to check whether the
function pointer is valid or not.

If it is not available, we assume the hysteresis to be zero. Consequently, a
highly varying temperature will make the governor continuosly switch a cooling
device ON and OFF.

CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
CC: Peter Feuerer <peter@piie.net>
Signed-off-by: Michele Di Giorgio <michele.digiorgio@arm.com>
---
Using trip_hyst == 0 makes the governor work sensibly but may cause oscillations
of the control signals of a cooling device. An alternative to this could be to
fail the registration of the thermal governor.

Another way would be to set the default value of the hysteresis to x% of the
trip temperature, to make the governor less sensitive to highly varying inputs.

 drivers/thermal/gov_bang_bang.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
index 39d1519..bb118a1 100644
--- a/drivers/thermal/gov_bang_bang.c
+++ b/drivers/thermal/gov_bang_bang.c
@@ -29,7 +29,13 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 	struct thermal_instance *instance;
 
 	tz->ops->get_trip_temp(tz, trip, &trip_temp);
-	tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
+
+	if (!tz->ops->get_trip_hyst) {
+		pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
+				"running with default hysteresis zero\n", tz->type);
+		trip_hyst = 0;
+	} else
+		tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
 
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
 				trip, trip_temp, tz->temperature,
-- 
1.9.1

