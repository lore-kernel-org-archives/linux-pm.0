From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 07/13] power: bq24257: Add VINDPM voltage threshold setting support
Date: Mon, 31 Aug 2015 21:10:29 -0500
Message-ID: <1441073435-12349-8-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58210 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbbIACLp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:45 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

A new optional device property called "ti,vindpm-voltage" is introduced
to allow configuring the input voltage threshold for the devices'
dynamic power path management feature. In short, it can be used to
prevent the input voltage from dropping below a certain value as current
is drawn to charge the battery or supply the system.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index c6bb2b5..2271a88 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -70,6 +70,7 @@ struct bq24257_init_data {
 	u8 iterm;	/* termination current */
 	u8 in_ilimit;	/* input current limit */
 	u8 vovp;	/* over voltage protection voltage */
+	u8 vindpm;	/* VDMP input threshold voltage */
 	bool in_ilimit_autoset_disable;	/* auto-detect of input current limit */
 	bool pg_gpio_disable; /* use of a dedicated pin for Power Good */
 };
@@ -203,6 +204,13 @@ static const u32 bq24257_vovp_map[] = {
 
 #define BQ24257_VOVP_MAP_SIZE		ARRAY_SIZE(bq24257_vovp_map)
 
+static const u32 bq24257_vindpm_map[] = {
+	4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
+	4760000
+};
+
+#define BQ24257_VINDPM_MAP_SIZE		ARRAY_SIZE(bq24257_vindpm_map)
+
 static int bq24257_field_read(struct bq24257_device *bq,
 			      enum bq24257_fields field_id)
 {
@@ -433,6 +441,17 @@ enum bq24257_vovp {
 	VOVP_10500
 };
 
+enum bq24257_vindpm {
+	VINDPM_4200,
+	VINDPM_4280,
+	VINDPM_4360,
+	VINDPM_4440,
+	VINDPM_4520,
+	VINDPM_4600,
+	VINDPM_4680,
+	VINDPM_4760
+};
+
 enum bq24257_port_type {
 	PORT_TYPE_DCP,		/* Dedicated Charging Port */
 	PORT_TYPE_CDP,		/* Charging Downstream Port */
@@ -615,7 +634,8 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 		{F_ICHG, bq->init_data.ichg},
 		{F_VBAT, bq->init_data.vbat},
 		{F_ITERM, bq->init_data.iterm},
-		{F_VOVP, bq->init_data.vovp}
+		{F_VOVP, bq->init_data.vovp},
+		{F_VINDPM, bq->init_data.vindpm}
 	};
 
 	/*
@@ -649,6 +669,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 		/* program fixed input current limit */
 		ret = bq24257_field_write(bq, F_IILIMIT,
 					  bq->init_data.in_ilimit);
+
 		if (ret < 0)
 			return ret;
 	} else if (!state.power_good)
@@ -696,10 +717,23 @@ static ssize_t bq24257_show_ovp_voltage(struct device *dev,
 			bq24257_vovp_map[bq->init_data.vovp]);
 }
 
+static ssize_t bq24257_show_vindpm_voltage(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			bq24257_vindpm_map[bq->init_data.vindpm]);
+}
+
 static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
+static DEVICE_ATTR(vindpm_voltage, S_IRUGO, bq24257_show_vindpm_voltage, NULL);
 
 static struct attribute *bq24257_charger_attr[] = {
 	&dev_attr_ovp_voltage.attr,
+	&dev_attr_vindpm_voltage.attr,
 	NULL,
 };
 
@@ -792,6 +826,14 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 		bq->init_data.vovp = bq24257_find_idx(property,
 				bq24257_vovp_map, BQ24257_VOVP_MAP_SIZE);
 
+	ret = device_property_read_u32(bq->dev, "ti,vindpm-voltage",
+				       &property);
+	if (ret < 0)
+		bq->init_data.vindpm = VINDPM_4360;
+	else
+		bq->init_data.vindpm = bq24257_find_idx(property,
+				bq24257_vindpm_map, BQ24257_VINDPM_MAP_SIZE);
+
 	bq->init_data.in_ilimit_autoset_disable = device_property_read_bool(
 			bq->dev, "ti,in-ilimit-autoset-disable");
 
-- 
1.9.1

