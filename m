From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/4] power: supply: sc2731_charger: Add one work to charge/discharge
Date: Mon, 12 Nov 2018 18:52:35 +0800
Message-ID: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

Since the USB notifier context is atomic, we can not start or stop charging
in atomic context. Thus this patch adds one work to help to charge or
discharge.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 525a820..393ba98 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -57,9 +57,11 @@ struct sc2731_charger_info {
 	struct usb_phy *usb_phy;
 	struct notifier_block usb_notify;
 	struct power_supply *psy_usb;
+	struct work_struct work;
 	struct mutex lock;
 	bool charging;
 	u32 base;
+	u32 limit;
 };
 
 static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
@@ -318,22 +320,21 @@ static int sc2731_charger_property_is_writeable(struct power_supply *psy,
 	.property_is_writeable	= sc2731_charger_property_is_writeable,
 };
 
-static int sc2731_charger_usb_change(struct notifier_block *nb,
-				     unsigned long limit, void *data)
+static void sc2731_charger_work(struct work_struct *data)
 {
 	struct sc2731_charger_info *info =
-		container_of(nb, struct sc2731_charger_info, usb_notify);
-	int ret = 0;
+		container_of(data, struct sc2731_charger_info, work);
+	int ret;
 
 	mutex_lock(&info->lock);
 
-	if (limit > 0) {
+	if (info->limit > 0) {
 		/* set current limitation and start to charge */
-		ret = sc2731_charger_set_current_limit(info, limit);
+		ret = sc2731_charger_set_current_limit(info, info->limit);
 		if (ret)
 			goto out;
 
-		ret = sc2731_charger_set_current(info, limit);
+		ret = sc2731_charger_set_current(info, info->limit);
 		if (ret)
 			goto out;
 
@@ -350,7 +351,19 @@ static int sc2731_charger_usb_change(struct notifier_block *nb,
 
 out:
 	mutex_unlock(&info->lock);
-	return ret;
+}
+
+static int sc2731_charger_usb_change(struct notifier_block *nb,
+				     unsigned long limit, void *data)
+{
+	struct sc2731_charger_info *info =
+		container_of(nb, struct sc2731_charger_info, usb_notify);
+
+	info->limit = limit;
+
+	schedule_work(&info->work);
+
+	return NOTIFY_OK;
 }
 
 static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
@@ -432,6 +445,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 	info->dev = &pdev->dev;
+	INIT_WORK(&info->work, sc2731_charger_work);
 
 	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!info->regmap) {
-- 
1.7.9.5
