From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] power: supply: max17042_battery: Always fall back to default platform-data
Date: Mon, 22 Jan 2018 18:42:18 +0100
Message-ID: <20180122174218.2492-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbeAVRmV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Jan 2018 12:42:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

It is possible to have CONFIG_OF enabled on x86 builds, where we have no
firmware provided max17042_platform_data. The CONFIG_OF implementation of
max17042_get_pdata would return NULL in this case, causing the probe to
fail.

Instead always fallback to the default platform-data, as used on x86 sofar,
when there is no firmware provided pdata, independent of CONFIG_OF.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 102b3f71e9a4..35dde81b1c9b 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -886,16 +886,13 @@ static void max17042_init_worker(struct work_struct *work)
 
 #ifdef CONFIG_OF
 static struct max17042_platform_data *
-max17042_get_pdata(struct max17042_chip *chip)
+max17042_get_of_pdata(struct max17042_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
 	struct device_node *np = dev->of_node;
 	u32 prop;
 	struct max17042_platform_data *pdata;
 
-	if (!np)
-		return dev->platform_data;
-
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
@@ -920,7 +917,8 @@ max17042_get_pdata(struct max17042_chip *chip)
 
 	return pdata;
 }
-#else
+#endif
+
 static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
 	/*
 	 * Some firmwares do not set FullSOCThr, Enable End-of-Charge Detection
@@ -930,15 +928,12 @@ static struct max17042_reg_data max17047_default_pdata_init_regs[] = {
 };
 
 static struct max17042_platform_data *
-max17042_get_pdata(struct max17042_chip *chip)
+max17042_get_default_pdata(struct max17042_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
 	struct max17042_platform_data *pdata;
 	int ret, misc_cfg;
 
-	if (dev->platform_data)
-		return dev->platform_data;
-
 	/*
 	 * The MAX17047 gets used on x86 where we might not have pdata, assume
 	 * the firmware will already have initialized the fuel-gauge and provide
@@ -971,7 +966,21 @@ max17042_get_pdata(struct max17042_chip *chip)
 
 	return pdata;
 }
+
+static struct max17042_platform_data *
+max17042_get_pdata(struct max17042_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+
+#ifdef CONFIG_OF
+	if (dev->of_node)
+		return max17042_get_of_pdata(chip);
 #endif
+	if (dev->platform_data)
+		return dev->platform_data;
+
+	return max17042_get_default_pdata(chip);
+}
 
 static const struct regmap_config max17042_regmap_config = {
 	.reg_bits = 8,
-- 
2.14.3
