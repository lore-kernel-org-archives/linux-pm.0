From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 05/13] power: bq24257: Add SW-based approach for Power Good determination
Date: Mon, 31 Aug 2015 21:10:27 -0500
Message-ID: <1441073435-12349-6-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbbIACLl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:41 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

A new device property called "ti,pg-gpio-disable" is introduced to
allow disabling the GPIO-based Power Good implementation, and
replacing it with a SW-only alternative. This is helpful for devices
which don't have a dedicated PG pin such as bq25250.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 46 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 229fbce..2d396c3 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -70,6 +70,7 @@ struct bq24257_init_data {
 	u8 iterm;	/* termination current */
 	u8 in_ilimit;	/* input current limit */
 	bool in_ilimit_autoset_disable;	/* auto-detect of input current limit */
+	bool pg_gpio_disable; /* use of a dedicated pin for Power Good */
 };
 
 struct bq24257_state {
@@ -99,6 +100,7 @@ struct bq24257_device {
 	struct mutex lock; /* protect state data */
 
 	bool in_ilimit_autoset_disable;
+	bool pg_gpio_disable;
 };
 
 static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -356,7 +358,26 @@ static int bq24257_get_chip_state(struct bq24257_device *bq,
 
 	state->fault = ret;
 
-	state->power_good = !gpiod_get_value_cansleep(bq->pg);
+	if (bq->pg_gpio_disable)
+		/*
+		 * If we have a chip without a dedicated power-good GPIO or
+		 * some other explicit bit that would provide this information
+		 * assume the power is good if there is no supply related
+		 * fault - and not good otherwise. There is a possibility for
+		 * other errors to mask that power in fact is not good but this
+		 * is probably the best we can do here.
+		 */
+		switch (state->fault) {
+		case FAULT_INPUT_OVP:
+		case FAULT_INPUT_UVLO:
+		case FAULT_INPUT_LDO_LOW:
+			state->power_good = false;
+			break;
+		default:
+			state->power_good = true;
+		}
+	else
+		state->power_good = !gpiod_get_value_cansleep(bq->pg);
 
 	return 0;
 }
@@ -725,6 +746,9 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
 	bq->init_data.in_ilimit_autoset_disable = device_property_read_bool(
 			bq->dev, "ti,in-ilimit-autoset-disable");
 
+	bq->init_data.pg_gpio_disable = device_property_read_bool(
+			bq->dev, "ti,pg-gpio-disable");
+
 	return 0;
 }
 
@@ -794,10 +818,22 @@ static int bq24257_probe(struct i2c_client *client,
 		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
 				bq24257_iilimit_setup_work);
 
-	/* we can only check Power Good status by probing the PG pin */
-	ret = bq24257_pg_gpio_probe(bq);
-	if (ret < 0)
-		return ret;
+	/*
+	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so we
+	 * explicitly disable this feature for this device and instead use
+	 * a SW-based approach to determine the PG state. Note that the most
+	 * reliable way to determine the PG state is through the use of the
+	 * dedicated PG pin so on devices where it is available using that pin
+	 * should be the method of choice.
+	 */
+	bq->pg_gpio_disable = bq->chip == BQ24250 ?
+			true : bq->init_data.pg_gpio_disable;
+
+	if (!bq->pg_gpio_disable) {
+		ret = bq24257_pg_gpio_probe(bq);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* reset all registers to defaults */
 	ret = bq24257_field_write(bq, F_RESET, 1);
-- 
1.9.1

