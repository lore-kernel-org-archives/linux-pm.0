From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 05/13] thermal: inline only once used function
Date: Thu, 26 Mar 2015 16:53:52 +0100
Message-ID: <1427385240-6086-6-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Inline update_temperature into its only caller to make the code
more readable.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index ebca854..6d0fdad 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -431,11 +431,15 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-static void update_temperature(struct thermal_zone_device *tz)
+void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
+	int count;
 	unsigned long temp;
 	int ret;
 
+	if (!tz->ops->get_temp)
+		return;
+
 	ret = thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
@@ -451,16 +455,6 @@ static void update_temperature(struct thermal_zone_device *tz)
 	trace_thermal_temperature(tz);
 	dev_dbg(&tz->device, "last_temperature=%lu, current_temperature=%lu\n",
 				tz->last_temperature, tz->temperature);
-}
-
-void thermal_zone_device_update(struct thermal_zone_device *tz)
-{
-	int count;
-
-	if (!tz->ops->get_temp)
-		return;
-
-	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
 		handle_thermal_trip(tz, count);
-- 
2.1.4
