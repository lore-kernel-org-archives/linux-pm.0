From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 11/13] thermal: of: make of_thermal_ops const
Date: Thu, 26 Mar 2015 16:53:58 +0100
Message-ID: <1427385240-6086-12-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56501 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbbCZPyd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 11:54:33 -0400
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Now that we no longer modify the ops they can be const again. Also
we no longer have to duplicate them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/of-thermal.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index df14fdd..9b63193 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -365,7 +365,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 	return -EINVAL;
 }
 
-static struct thermal_zone_device_ops of_thermal_ops = {
+static const struct thermal_zone_device_ops of_thermal_ops = {
 	.get_temp = of_thermal_get_temp,
 	.get_trend = of_thermal_get_trend,
 	.set_emul_temp = of_thermal_set_emul_temp,
@@ -539,10 +539,6 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 		return;
 
 	mutex_lock(&tzd->lock);
-	tzd->ops->get_temp = NULL;
-	tzd->ops->get_trend = NULL;
-	tzd->ops->set_emul_temp = NULL;
-
 	tz->ops = NULL;
 	tz->sensor_data = NULL;
 	mutex_unlock(&tzd->lock);
@@ -849,7 +845,6 @@ int __init of_parse_thermal_zones(void)
 {
 	struct device_node *np, *child;
 	struct __thermal_zone *tz;
-	struct thermal_zone_device_ops *ops;
 
 	np = of_find_node_by_name(NULL, "thermal-zones");
 	if (!np) {
@@ -873,29 +868,22 @@ int __init of_parse_thermal_zones(void)
 			continue;
 		}
 
-		ops = kmemdup(&of_thermal_ops, sizeof(*ops), GFP_KERNEL);
-		if (!ops)
-			goto exit_free;
-
 		tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
-		if (!tzp) {
-			kfree(ops);
+		if (!tzp)
 			goto exit_free;
-		}
 
 		/* No hwmon because there might be hwmon drivers registering */
 		tzp->no_hwmon = true;
 
 		zone = thermal_zone_device_register(child->name, tz->ntrips,
 						    0, tz,
-						    ops, tzp,
+						    &of_thermal_ops, tzp,
 						    tz->passive_delay,
 						    tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %s zone %ld\n", child->name,
 			       PTR_ERR(zone));
 			kfree(tzp);
-			kfree(ops);
 			of_thermal_free_zone(tz);
 			/* attempting to build remaining zones still */
 		}
-- 
2.1.4

