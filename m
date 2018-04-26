From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 18/18] thermal: exynos: remove trip reporting to user-space
Date: Thu, 26 Apr 2018 13:51:33 +0200
Message-ID: <1524743493-28113-19-git-send-email-b.zolnierkie@samsung.com>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180426115244epcas2p36d0d44d1a0b2c3c4edff33187046caac@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove trip reporting to user-space - I'm not aware of any user-space
program which relies on it and there is a thermal user-space governor
which does it in proper way nowadays.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index ed02b40..f785e6a 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -216,33 +216,6 @@ struct exynos_tmu_data {
 	void (*tmu_clear_irqs)(struct exynos_tmu_data *data);
 };
 
-static void exynos_report_trigger(struct exynos_tmu_data *p)
-{
-	char data[10], *envp[] = { data, NULL };
-	struct thermal_zone_device *tz = p->tzd;
-	int temp;
-	unsigned int i;
-
-	if (!tz) {
-		pr_err("No thermal zone device defined\n");
-		return;
-	}
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
-	mutex_lock(&tz->lock);
-	/* Find the level for which trip happened */
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
-		tz->ops->get_trip_temp(tz, i, &temp);
-		if (tz->last_temperature < temp)
-			break;
-	}
-
-	snprintf(data, sizeof(data), "%u", i);
-	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, envp);
-	mutex_unlock(&tz->lock);
-}
-
 /*
  * TMU treats temperature as a mapped temperature code.
  * The temperature is converted differently depending on the calibration type.
@@ -814,7 +787,8 @@ static void exynos_tmu_work(struct work_struct *work)
 	if (!IS_ERR(data->clk_sec))
 		clk_disable(data->clk_sec);
 
-	exynos_report_trigger(data);
+	thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
+
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-- 
1.9.1
