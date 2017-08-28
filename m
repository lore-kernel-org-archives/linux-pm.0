From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v4 4/5] power: bq24190_charger: Add property system-minimum-microvolt
Date: Mon, 28 Aug 2017 14:23:48 -0700
Message-ID: <20170828212349.19037-5-liam@networkimprov.net>
References: <20170828212349.19037-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35563 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbdH1VYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Aug 2017 17:24:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id g13so1046521pfm.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Aug 2017 14:24:23 -0700 (PDT)
In-Reply-To: <20170828212349.19037-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

From: Liam Breck <kernel@networkimprov.net>

Set minimum system voltage limit obtained from device property.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Liam Breck <kernel@networkimprov.net>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/bq24190_charger.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index af4688db..c0b23db8 100644
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
 
@@ -1470,6 +1483,18 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 
 static int bq24190_get_config(struct bq24190_dev_info *bdi)
 {
+	const char * const s = "ti,system-minimum-microvolt";
+	int v;
+
+	if (device_property_read_u32(bdi->dev, s, &v) == 0) {
+		v /= 1000;
+		if (v >= BQ24190_REG_POC_SYS_MIN_MIN
+		 && v <= BQ24190_REG_POC_SYS_MIN_MAX)
+			bdi->sys_min = v;
+		else
+			dev_warn(bdi->dev, "invalid value for %s: %u\n", s, v);
+	}
+
 	return 0;
 }
 
-- 
2.13.2
