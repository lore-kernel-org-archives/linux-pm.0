From: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 01/19] thermal: allow registering without .get_temp
Date: Tue, 25 Mar 2014 18:49:14 +0800
Message-ID: <1395744572-20014-2-git-send-email-alex.shi@linaro.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40144 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaCYKtu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 06:49:50 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so277491pab.10
        for <linux-pm@vger.kernel.org>; Tue, 25 Mar 2014 03:49:50 -0700 (PDT)
In-Reply-To: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linaro.org>

From: Eduardo Valentin <eduardo.valentin@ti.com>

This patch changes the thermal core driver to allow
registration of thermal zones without the .get_temp callback.

The idea behind this change is to allow lazy registration
of sensor callbacks.

The thermal zone will be disabled whenever the ops
does not contain a .get_temp callback. The sysfs interface
will be returning -EINVAL on any temperature read operation.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
(cherry picked from commit 81bd4e1cebed5efb85bd94a15342ee4d6965a416)

Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 drivers/thermal/thermal_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..818cd78 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -388,7 +388,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long *temp)
 	enum thermal_trip_type type;
 #endif
 
-	if (!tz || IS_ERR(tz))
+	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
 	mutex_lock(&tz->lock);
@@ -441,6 +441,9 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
 {
 	int count;
 
+	if (!tz->ops->get_temp)
+		return;
+
 	update_temperature(tz);
 
 	for (count = 0; count < tz->trips; count++)
@@ -1621,7 +1624,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
 		return ERR_PTR(-EINVAL);
 
-	if (!ops || !ops->get_temp)
+	if (!ops)
 		return ERR_PTR(-EINVAL);
 
 	if (trips > 0 && !ops->get_trip_type)
@@ -1723,6 +1726,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
 
 	INIT_DELAYED_WORK(&(tz->poll_queue), thermal_zone_device_check);
 
+	if (!tz->ops->get_temp)
+		thermal_zone_device_set_polling(tz, 0);
+
 	thermal_zone_device_update(tz);
 
 	if (!result)
-- 
1.8.1.2

