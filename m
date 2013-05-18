From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 1/3] Thermal: core: Ask .get_trip_temp() to register thermal
 zone device.
Date: Sat, 18 May 2013 18:50:26 +0900
Message-ID: <1368870627-1143-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39383 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab3ERJui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 May 2013 05:50:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Dinel Kachhap <amit.kachhap@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

This patch adds a requirement needing .get_trip_temp() callback
function for registering thermal zone device. This function is
used when thermal zone is updated and essential where thermal core
handles thermal trip based only polling way not hw interrupt.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/thermal/thermal_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..f753f48 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1624,7 +1624,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (!ops || !ops->get_temp)
 		return ERR_PTR(-EINVAL);
 
-	if (trips > 0 && !ops->get_trip_type)
+	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
-- 
1.7.9.5

