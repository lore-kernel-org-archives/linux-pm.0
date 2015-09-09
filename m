From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 04/13] power: bq24257: Add SW-based approach for Power Good determination
Date: Tue, 8 Sep 2015 19:12:28 -0500
Message-ID: <1441757557-7266-5-git-send-email-dannenberg@ti.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59817 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbbIIANn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 20:13:43 -0400
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

A software-based approach for determining the charger's input voltage
"Power Good" state is introduced for devices like the bq24250 which
don't have a dedicated hardware pin for that purpose. This SW-based
approach is also used for other devices (with dedicated PG pin) as a
fall back solution if that pin is not configured to be used through
"pg-gpios".

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 49 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index d83898f..e309ae8 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -103,6 +103,7 @@ struct bq24257_device {
 	struct mutex lock; /* protect state data */
 
 	bool in_ilimit_autoset_disable;
+	bool pg_gpio_disable;
 };
 
 static bool bq24257_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -356,7 +357,26 @@ static int bq24257_get_chip_state(struct bq24257_device *bq,
 
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
@@ -676,7 +696,7 @@ static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
 {
 	bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN);
 	if (IS_ERR(bq->pg)) {
-		dev_err(bq->dev, "could not probe PG pin\n");
+		dev_info(bq->dev, "could not probe PG pin\n");
 		return PTR_ERR(bq->pg);
 	}
 
@@ -808,10 +828,27 @@ static int bq24257_probe(struct i2c_client *client,
 		INIT_DELAYED_WORK(&bq->iilimit_setup_work,
 				bq24257_iilimit_setup_work);
 
-	/* we can only check Power Good status by probing the PG pin */
-	ret = bq24257_pg_gpio_probe(bq);
-	if (ret < 0)
-		return ret;
+	/*
+	 * The BQ24250 doesn't have a dedicated Power Good (PG) pin so we
+	 * explicitly disable this feature for this device and instead use
+	 * a SW-based approach to determine the PG state.
+	 */
+	if (bq->chip == BQ24250)
+		bq->pg_gpio_disable = true;
+
+	/*
+	 * For devices that do have a dedicated PG pin go ahead and probe it,
+	 * using the SW-based approach as a fall back solution. Note that the
+	 * use of the dedicated pin is preferred.
+	 */
+	if (!bq->pg_gpio_disable) {
+		ret = bq24257_pg_gpio_probe(bq);
+		if (ret < 0) {
+			dev_info(bq->dev,
+				"using SW-based power-good detection\n");
+			bq->pg_gpio_disable = true;
+		}
+	}
 
 	/* reset all registers to defaults */
 	ret = bq24257_field_write(bq, F_RESET, 1);
-- 
1.9.1

