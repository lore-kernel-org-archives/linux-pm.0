From: Fabio Estevam <festevam@gmail.com>
Subject: [RFC] thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
Date: Tue, 27 Dec 2016 11:00:40 -0200
Message-ID: <1482843640-25255-1-git-send-email-festevam@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36580 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbcL0NAl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 08:00:41 -0500
Received: by mail-qk0-f196.google.com with SMTP id h201so27888268qke.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 05:00:40 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux@roeck-us.net, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

Booting Linux on a mx6q based board leads to the following warning:

(NULL device *): hwmon_device_register() is deprecated. Please convert the
driver to use hwmon_device_register_with_info().

,so do as suggested.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/thermal/thermal_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 541af59..22397dd 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -165,7 +165,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
-	hwmon->device = hwmon_device_register(NULL);
+	hwmon->device = hwmon_device_register_with_info(NULL, NULL, NULL,
+							NULL, NULL);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
-- 
2.7.4

