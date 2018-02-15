From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] power: supply: axp288_fuel_gauge: Remove polling from the driver
Date: Thu, 15 Feb 2018 15:00:37 +0100
Message-ID: <20180215140037.6097-2-hdegoede@redhat.com>
References: <20180215140037.6097-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032283AbeBOOAk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Feb 2018 09:00:40 -0500
In-Reply-To: <20180215140037.6097-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Userspace class/power_supply consumers such as upower, already know some
supplies need to be polled to get up2date info. Doing this in the kernel
and then waking up userspace just causes unnecessary wakeups and i2c
transfers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index e58aad011eb7..c5a24aee901c 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -24,7 +24,6 @@
 #include <linux/regmap.h>
 #include <linux/jiffies.h>
 #include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -88,7 +87,6 @@
 #define FG_LOW_CAP_CRIT_THR			4   /* 4 perc */
 #define FG_LOW_CAP_SHDN_THR			0   /* 0 perc */
 
-#define STATUS_MON_DELAY_JIFFIES    (HZ * 60)   /*60 sec */
 #define NR_RETRY_CNT    3
 #define DEV_NAME	"axp288_fuel_gauge"
 
@@ -128,7 +126,6 @@ struct axp288_fg_info {
 	struct mutex lock;
 	int status;
 	int max_volt;
-	struct delayed_work status_monitor;
 	struct dentry *debug_file;
 };
 
@@ -592,16 +589,6 @@ static int fuel_gauge_property_is_writeable(struct power_supply *psy,
 	return ret;
 }
 
-static void fuel_gauge_status_monitor(struct work_struct *work)
-{
-	struct axp288_fg_info *info = container_of(work,
-		struct axp288_fg_info, status_monitor.work);
-
-	fuel_gauge_get_status(info);
-	power_supply_changed(info->bat);
-	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
-}
-
 static irqreturn_t fuel_gauge_thread_handler(int irq, void *dev)
 {
 	struct axp288_fg_info *info = dev;
@@ -764,7 +751,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 
 	mutex_init(&info->lock);
-	INIT_DELAYED_WORK(&info->status_monitor, fuel_gauge_status_monitor);
 
 	for (i = 0; i < IIO_CHANNEL_NUM; i++) {
 		/*
@@ -824,7 +810,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 	fuel_gauge_create_debugfs(info);
 	fuel_gauge_init_irq(info);
-	schedule_delayed_work(&info->status_monitor, STATUS_MON_DELAY_JIFFIES);
 
 	return 0;
 
@@ -847,7 +832,6 @@ static int axp288_fuel_gauge_remove(struct platform_device *pdev)
 	struct axp288_fg_info *info = platform_get_drvdata(pdev);
 	int i;
 
-	cancel_delayed_work_sync(&info->status_monitor);
 	power_supply_unregister(info->bat);
 	fuel_gauge_remove_debugfs(info);
 
-- 
2.14.3
