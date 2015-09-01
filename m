From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 04/13] power: bq24257: Allow manual setting of input current limit
Date: Mon, 31 Aug 2015 21:10:26 -0500
Message-ID: <1441073435-12349-5-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbbIACL0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:26 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

A new device property called "ti,in-ilimit-autoset-disable" is
introduced to allow disabling the D+/D- based auto-detection algorithm
used to determine the input current limit. This feature is also
explicitly disabled on bq25250 devices which don't support D+/D-
charger type detection.

If "ti,in-ilimit-autoset-disable" is set the actual input current limit
can be configured through the "ti,in-limit-current" property.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 98 ++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 21 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 45232bd..229fbce 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -68,6 +68,8 @@ struct bq24257_init_data {
 	u8 ichg;	/* charge current      */
 	u8 vbat;	/* regulation voltage  */
 	u8 iterm;	/* termination current */
+	u8 in_ilimit;	/* input current limit */
+	bool in_ilimit_autoset_disable;	/* auto-detect of input current limit */
 };
 
 struct bq24257_state {
@@ -95,6 +97,8 @@ struct bq24257_device {
 	struct bq24257_state state;
 
 	struct mutex lock; /* protect state data */
+
+	bool in_ilimit_autoset_disable;
 };
 
 static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -183,6 +187,12 @@ static const u32 bq24257_iterm_map[] = {
 
 #define BQ24257_ITERM_MAP_SIZE		ARRAY_SIZE(bq24257_iterm_map)
 
+static const u32 bq24257_iilimit_map[] = {
+	100000, 150000, 500000, 900000, 1500000, 2000000
+};
+
+#define BQ24257_IILIMIT_MAP_SIZE	ARRAY_SIZE(bq24257_iilimit_map)
+
 static int bq24257_field_read(struct bq24257_device *bq,
 			      enum bq24257_fields field_id)
 {
@@ -478,24 +488,35 @@ static void bq24257_handle_state_change(struct bq24257_device *bq,
 	old_state = bq->state;
 	mutex_unlock(&bq->lock);
 
-	if (!new_state->power_good) {			     /* power removed */
-		cancel_delayed_work_sync(&bq->iilimit_setup_work);
-
-		/* activate D+/D- port detection algorithm */
-		ret = bq24257_field_write(bq, F_DPDM_EN, 1);
-		if (ret < 0)
-			goto error;
+	/*
+	 * Handle BQ2425x state changes observing whether the D+/D- based input
+	 * current limit autoset functionality is enabled.
+	 */
+	if (!new_state->power_good) {
+		dev_dbg(bq->dev, "Power removed\n");
+		if (!bq->in_ilimit_autoset_disable) {
+			cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
-		reset_iilimit = true;
-	} else if (!old_state.power_good) {		    /* power inserted */
-		config_iilimit = true;
-	} else if (new_state->fault == FAULT_NO_BAT) {	   /* battery removed */
-		cancel_delayed_work_sync(&bq->iilimit_setup_work);
+			/* activate D+/D- port detection algorithm */
+			ret = bq24257_field_write(bq, F_DPDM_EN, 1);
+			if (ret < 0)
+				goto error;
 
-		reset_iilimit = true;
-	} else if (old_state.fault == FAULT_NO_BAT) {    /* battery connected */
-		config_iilimit = true;
-	} else if (new_state->fault == FAULT_TIMER) { /* safety timer expired */
+			reset_iilimit = true;
+		}
+	} else if (!old_state.power_good) {
+		dev_dbg(bq->dev, "Power inserted\n");
+		config_iilimit = !bq->in_ilimit_autoset_disable;
+	} else if (new_state->fault == FAULT_NO_BAT) {
+		dev_warn(bq->dev, "Battery removed\n");
+		if (!bq->in_ilimit_autoset_disable) {
+			cancel_delayed_work_sync(&bq->iilimit_setup_work);
+			reset_iilimit = true;
+		}
+	} else if (old_state.fault == FAULT_NO_BAT) {
+		dev_warn(bq->dev, "Battery connected\n");
+		config_iilimit = !bq->in_ilimit_autoset_disable;
+	} else if (new_state->fault == FAULT_TIMER) {
 		dev_err(bq->dev, "Safety timer expired! Battery dead?\n");
 	}
 
@@ -580,7 +601,16 @@ static int bq24257_hw_init(struct bq24257_device *bq)
 	bq->state = state;
 	mutex_unlock(&bq->lock);
 
-	if (!state.power_good)
+	if (bq->in_ilimit_autoset_disable) {
+		dev_dbg(bq->dev, "manually setting iilimit = %d\n",
+				bq->init_data.in_ilimit);
+
+		/* program fixed input current limit */
+		ret = bq24257_field_write(bq, F_IILIMIT,
+					  bq->init_data.in_ilimit);
+		if (ret < 0)
+			return ret;
+	} else if (!state.power_good)
 		/* activate D+/D- detection algorithm */
 		ret = bq24257_field_write(bq, F_DPDM_EN, 1);
 	else if (state.fault != FAULT_NO_BAT)
@@ -658,6 +688,7 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	int ret;
 	u32 property;
 
+	/* Required properties */
 	ret = device_property_read_u32(bq->dev, "ti,charge-current", &property);
 	if (ret < 0)
 		return ret;
@@ -681,6 +712,19 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	bq->init_data.iterm = bq24257_find_idx(property, bq24257_iterm_map,
 					       BQ24257_ITERM_MAP_SIZE);
 
+	/* Optional properties */
+	ret = device_property_read_u32(bq->dev, "ti,in-limit-current",
+				       &property);
+
+	if (ret < 0)
+		bq->init_data.in_ilimit = IILIMIT_500;
+	else
+		bq->init_data.in_ilimit = bq24257_find_idx(property,
+				bq24257_iilimit_map, BQ24257_IILIMIT_MAP_SIZE);
+
+	bq->init_data.in_ilimit_autoset_disable = device_property_read_bool(
+			bq->dev, "ti,in-ilimit-autoset-disable");
+
 	return 0;
 }
 
@@ -728,8 +772,6 @@ static int bq24257_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bq);
 
-	INIT_DELAYED_WORK(&bq->iilimit_setup_work, bq24257_iilimit_setup_work);
-
 	if (!dev->platform_data) {
 		ret = bq24257_fw_probe(bq);
 		if (ret < 0) {
@@ -740,6 +782,18 @@ static int bq24257_probe(struct i2c_client *client,
 		return -ENODEV;
 	}
 
+	/*
+	 * The BQ24250 doesn't support the D+/D- based detection for the
+	 * input current limit setting so explicitly disable that feature
+	 * otherwise respect the user configuration.
+	 */
+	bq->in_ilimit_autoset_disable = bq->chip == BQ24250 ?
+			true : bq->init_data.in_ilimit_autoset_disable;
+
+	if (!bq->in_ilimit_autoset_disable)
+		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
+				bq24257_iilimit_setup_work);
+
 	/* we can only check Power Good status by probing the PG pin */
 	ret = bq24257_pg_gpio_probe(bq);
 	if (ret < 0)
@@ -792,7 +846,8 @@ static int bq24257_remove(struct i2c_client *client)
 {
 	struct bq24257_device *bq = i2c_get_clientdata(client);
 
-	cancel_delayed_work_sync(&bq->iilimit_setup_work);
+	if (!bq->in_ilimit_autoset_disable)
+		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
 	power_supply_unregister(bq->charger);
 
@@ -807,7 +862,8 @@ static int bq24257_suspend(struct device *dev)
 	struct bq24257_device *bq = dev_get_drvdata(dev);
 	int ret = 0;
 
-	cancel_delayed_work_sync(&bq->iilimit_setup_work);
+	if (!bq->in_ilimit_autoset_disable)
+		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
 	/* reset all registers to default (and activate standalone mode) */
 	ret = bq24257_field_write(bq, F_RESET, 1);
-- 
1.9.1

