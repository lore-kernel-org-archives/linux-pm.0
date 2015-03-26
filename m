From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 10/13] thermal: Make struct thermal_zone_device_ops const
Date: Thu, 26 Mar 2015 16:53:57 +0100
Message-ID: <1427385240-6086-11-git-send-email-s.hauer@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56366 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbCZPyI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 11:54:08 -0400
In-Reply-To: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>

Now that the of thermal support no longer changes the
thermal_zone_device_ops it can be const again.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/thermal/thermal_core.c | 2 +-
 include/linux/thermal.h        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index acf00b5..dcdf45e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1455,7 +1455,7 @@ static void remove_trip_attrs(struct thermal_zone_device *tz)
  */
 struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_device_ops *ops,
 	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 2f77091..ac2897c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -185,7 +185,7 @@ struct thermal_zone_device {
 	unsigned long emul_temperature;
 	int passive;
 	unsigned int forced_passive;
-	struct thermal_zone_device_ops *ops;
+	const struct thermal_zone_device_ops *ops;
 	const struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	struct list_head thermal_instances;
@@ -317,7 +317,7 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 
 #if IS_ENABLED(CONFIG_THERMAL)
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
-		void *, struct thermal_zone_device_ops *,
+		void *, const struct thermal_zone_device_ops *,
 		const struct thermal_zone_params *, int, int);
 void thermal_zone_device_unregister(struct thermal_zone_device *);
 
@@ -345,7 +345,7 @@ void thermal_notify_framework(struct thermal_zone_device *, int);
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register(
 	const char *type, int trips, int mask, void *devdata,
-	struct thermal_zone_device_ops *ops,
+	const struct thermal_zone_device_ops *ops,
 	const struct thermal_zone_params *tzp,
 	int passive_delay, int polling_delay)
 { return ERR_PTR(-ENODEV); }
-- 
2.1.4

