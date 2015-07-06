From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/4] thermal: remove unnecessary call to thermal_zone_device_set_polling
Date: Mon,  6 Jul 2015 09:46:15 +0200
Message-ID: <1436168777-10463-3-git-send-email-s.hauer@pengutronix.de>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59194 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbGFHqp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 03:46:45 -0400
In-Reply-To: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

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
index 34ce9e4..aa0a661 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1848,9 +1848,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
-	if (!tz->ops->get_temp)
-		thermal_zone_device_set_polling(tz, 0);
-
 	thermal_zone_device_update(tz);
 
 	return tz;
-- 
2.1.4

