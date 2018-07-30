From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH] thermal: of-thermal: disable passive polling when thermal zone is disabled
Date: Tue, 31 Jul 2018 00:56:49 +0800
Message-ID: <1532969809-8300-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com, nitin.garg@nxp.com
List-Id: linux-pm@vger.kernel.org

When thermal zone is in passive mode, disabling its mode from
sysfs is NOT taking effect at all, it is still polling the
temperature of the disabled thermal zone and handling all thermal
trips, it makes user confused. The disabling operation should
disable the thermal zone behavior completely, for both active and
passive mode, this patch clears the passive_delay when thermal
zone is disabled and restores it when it is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/of-thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a830..4f28165 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -260,10 +260,13 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 
 	mutex_lock(&tz->lock);
 
-	if (mode == THERMAL_DEVICE_ENABLED)
+	if (mode == THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay = data->polling_delay;
-	else
+		tz->passive_delay = data->passive_delay;
+	} else {
 		tz->polling_delay = 0;
+		tz->passive_delay = 0;
+	}
 
 	mutex_unlock(&tz->lock);
 
-- 
2.7.4
