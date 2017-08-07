From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v2 4/5] power: bq24190_charger: Add property system-minimum-microvolt
Date: Mon,  7 Aug 2017 12:54:19 -0700
Message-ID: <20170807195420.20767-5-liam@networkimprov.net>
References: <20170807195420.20767-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33099 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbdHGTyo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 15:54:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so1257762pgb.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2017 12:54:44 -0700 (PDT)
In-Reply-To: <20170807195420.20767-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Set minimum system voltage limit obtained from device property.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
---
 drivers/power/supply/bq24190_charger.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2ab580bf..f20d2c68 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -43,6 +43,8 @@
 #define BQ24190_REG_POC_CHG_CONFIG_OTG			0x2
 #define BQ24190_REG_POC_SYS_MIN_MASK		(BIT(3) | BIT(2) | BIT(1))
 #define BQ24190_REG_POC_SYS_MIN_SHIFT		1
+#define BQ24190_REG_POC_SYS_MIN_MIN			3000
+#define BQ24190_REG_POC_SYS_MIN_MAX			3700
 #define BQ24190_REG_POC_BOOST_LIM_MASK		BIT(0)
 #define BQ24190_REG_POC_BOOST_LIM_SHIFT		0
 
@@ -159,6 +161,7 @@ struct bq24190_dev_info {
 	char				model_name[I2C_NAME_SIZE];
 	bool				initialized;
 	bool				irq_event;
+	u16				sys_min;
 	struct mutex			f_reg_lock;
 	u8				f_reg;
 	u8				ss_reg;
@@ -530,6 +533,16 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 	if (ret < 0)
 		return ret;
 
+	if (bdi->sys_min) {
+		v = bdi->sys_min / 100 - 30; // manual section 9.5.1.2, table 9
+		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					 BQ24190_REG_POC_SYS_MIN_MASK,
+					 BQ24190_REG_POC_SYS_MIN_SHIFT,
+					 v);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1471,11 +1484,21 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 static int bq24190_get_config(struct bq24190_dev_info *bdi)
 {
 #ifdef CONFIG_OF
+	const char * const s = "ti,system-minimum-microvolt";
 	int v;
 
 	if (!bdi->dev->of_node)
 		return -EINVAL;
 
+	if (device_property_read_u32(bdi->dev, s, &v) == 0) {
+		v /= 1000;
+		if (v >= BQ24190_REG_POC_SYS_MIN_MIN
+		 && v <= BQ24190_REG_POC_SYS_MIN_MAX)
+			bdi->sys_min = v;
+		else
+			dev_warn(bdi->dev, "invalid value for %s: %u\n", s, v);
+	}
+
 #endif
 	return 0;
 }
-- 
2.13.2
