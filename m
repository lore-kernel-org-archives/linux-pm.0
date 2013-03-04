From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH 2/2] thermal: exynos_thermal: return a proper error code while thermal_zone_device_register fail.
Date: Mon,  4 Mar 2013 11:52:48 -0500
Message-ID: <1362415968-2210-2-git-send-email-devendra.aaru@gmail.com>
References: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64361 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab3CDQxF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 11:53:05 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so3201605pbc.15
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2013 08:53:04 -0800 (PST)
In-Reply-To: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

we are returning EINVAL while the thermal_zone_device_register function fail.
instead we can use the return value from the thermal_zone_device_register by
using PTR_ERR.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/thermal/exynos_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index e04ebd8..46568c0 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -476,7 +476,7 @@ static int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 
 	if (IS_ERR(th_zone->therm_dev)) {
 		pr_err("Failed to register thermal zone device\n");
-		ret = -EINVAL;
+		ret = PTR_ERR(th_zone->therm_dev);
 		goto err_unregister;
 	}
 	th_zone->mode = THERMAL_DEVICE_ENABLED;
-- 
1.8.1.2

