From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 04/13] thermal: remove useless call to thermal_zone_device_set_polling
Date: Tue, 28 Apr 2015 10:25:54 +0200
Message-ID: <1430209563-647-5-git-send-email-s.hauer@pengutronix.de>
References: <1430209563-647-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430209563-647-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

When the thermal zone has no get_temp callback then thermal_zone_device_register()
calls thermal_zone_device_set_polling() with a polling delay of 0. This
only cancels the poll_queue. Since the poll_queue hasn't been scheduled this
is a no-op. Remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cecebac..ad1d3c9 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1571,9 +1571,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
-	if (!tz->ops->get_temp)
-		thermal_zone_device_set_polling(tz, 0);
-
 	thermal_zone_device_update(tz);
 
 	return tz;
-- 
2.1.4
