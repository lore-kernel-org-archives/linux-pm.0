From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v3 10/10] power: bq24257: Add platform data based initialization
Date: Fri, 11 Sep 2015 15:26:42 -0500
Message-ID: <1442003202-1430-11-git-send-email-dannenberg@ti.com>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59722 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbbIKU2P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 16:28:15 -0400
In-Reply-To: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

The patch adds a way to setup and initialize the device through the use
of platform data with configuration options equivalent to when using
device firmware (DT or ACPI) for systems where this is not available.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c       | 119 ++++++++++++++++++++++++++++++----
 include/linux/power/bq24257_charger.h |  30 +++++++++
 2 files changed, 138 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/power/bq24257_charger.h

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 6d73736..6d16d60 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -27,10 +27,13 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <linux/acpi.h>
 #include <linux/of.h>
 
+#include <linux/power/bq24257_charger.h>
+
 #define BQ24257_REG_1			0x00
 #define BQ24257_REG_2			0x01
 #define BQ24257_REG_3			0x02
@@ -884,28 +887,114 @@ static int bq24257_power_supply_init(struct bq24257_device *bq)
 
 static int bq24257_irq_probe(struct bq24257_device *bq)
 {
+	struct bq24257_platform_data *pdata = bq->client->dev.platform_data;
 	struct gpio_desc *stat_irq;
+	int ret;
+
+	if (!pdata) {
+		stat_irq = devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0,
+						GPIOD_IN);
+		if (IS_ERR(stat_irq)) {
+			dev_err(bq->dev, "could not probe stat_irq pin\n");
+			return PTR_ERR(stat_irq);
+		}
+	} else {
+		if (!gpio_is_valid(pdata->stat_gpio)) {
+			dev_err(bq->dev, "invalid stat_irq pin\n");
+			return -EINVAL;
+		}
 
-	stat_irq = devm_gpiod_get_index(bq->dev, BQ24257_STAT_IRQ, 0, GPIOD_IN);
-	if (IS_ERR(stat_irq)) {
-		dev_err(bq->dev, "could not probe stat_irq pin\n");
-		return PTR_ERR(stat_irq);
+		ret = devm_gpio_request_one(bq->dev, pdata->stat_gpio,
+					    GPIOD_IN, BQ24257_STAT_IRQ);
+		if (ret) {
+			dev_err(bq->dev, "stat_irq pin request failed\n");
+			return ret;
+		}
+
+		stat_irq = gpio_to_desc(pdata->stat_gpio);
+		if (!stat_irq) {
+			dev_err(bq->dev,
+				"could not get stat_irq pin descriptor\n");
+			return -EINVAL;
+		}
 	}
 
+	dev_dbg(bq->dev, "probed stat_irq pin = %d", desc_to_gpio(stat_irq));
+
 	return gpiod_to_irq(stat_irq);
 }
 
 static int bq24257_pg_gpio_probe(struct bq24257_device *bq)
 {
-	bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0, GPIOD_IN);
-	if (IS_ERR(bq->pg)) {
-		dev_info(bq->dev, "could not probe PG pin\n");
-		return PTR_ERR(bq->pg);
+	struct bq24257_platform_data *pdata = bq->client->dev.platform_data;
+	int ret;
+
+	if (!pdata) {
+		bq->pg = devm_gpiod_get_index(bq->dev, BQ24257_PG_GPIO, 0,
+					      GPIOD_IN);
+		if (IS_ERR(bq->pg)) {
+			dev_info(bq->dev, "could not probe PG pin\n");
+			return PTR_ERR(bq->pg);
+		}
+	} else {
+		if (!gpio_is_valid(pdata->pg_gpio)) {
+			dev_info(bq->dev, "invalid PG pin\n");
+			return -EINVAL;
+		}
+
+		ret = devm_gpio_request_one(bq->dev, pdata->pg_gpio,
+					    GPIOD_IN, BQ24257_PG_GPIO);
+		if (ret) {
+			dev_info(bq->dev, "PG pin request failed\n");
+			return ret;
+		}
+
+		bq->pg = gpio_to_desc(pdata->pg_gpio);
+		if (!bq->pg) {
+			dev_info(bq->dev, "could not get PG pin descriptor\n");
+			return -EINVAL;
+		}
 	}
 
+	dev_dbg(bq->dev, "probed PG pin = %d", desc_to_gpio(bq->pg));
+
 	return 0;
 }
 
+static void bq24257_pdata_probe(struct bq24257_device *bq,
+				struct bq24257_platform_data *pdata)
+{
+	bq->init_data.ichg = bq24257_find_idx(pdata->ichg,
+					      bq24257_ichg_map,
+					      BQ24257_ICHG_MAP_SIZE);
+
+	bq->init_data.vbat = bq24257_find_idx(pdata->vbat,
+					      bq24257_vbat_map,
+					      BQ24257_VBAT_MAP_SIZE);
+
+	bq->init_data.iterm = bq24257_find_idx(pdata->iterm,
+					       bq24257_iterm_map,
+					       BQ24257_ITERM_MAP_SIZE);
+
+	bq->init_data.in_ilimit = bq24257_find_idx(pdata->in_ilimit,
+						   bq24257_iilimit_map,
+						   BQ24257_IILIMIT_MAP_SIZE);
+
+	bq->init_data.vovp = bq24257_find_idx(pdata->vovp,
+					      bq24257_vovp_map,
+					      BQ24257_VOVP_MAP_SIZE);
+
+	bq->init_data.vindpm = bq24257_find_idx(pdata->vindpm,
+						bq24257_vindpm_map,
+						BQ24257_VINDPM_MAP_SIZE);
+
+	bq->init_data.timer2x_enable = pdata->timer2x_enable;
+
+	bq->in_ilimit_autoset_disable = pdata->in_ilimit_autoset_disable;
+
+	bq->pg_gpio_disable = pdata->pg_gpio_disable;
+}
+
 static int bq24257_fw_probe(struct bq24257_device *bq)
 {
 	int ret;
@@ -988,6 +1077,7 @@ static int bq24257_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct device *dev = &client->dev;
 	const struct acpi_device_id *acpi_id;
+	struct bq24257_platform_data *pdata = client->dev.platform_data;
 	struct bq24257_device *bq;
 	int ret;
 	int i;
@@ -1037,14 +1127,15 @@ static int bq24257_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, bq);
 
-	if (!dev->platform_data) {
+	if (!pdata) {
 		ret = bq24257_fw_probe(bq);
 		if (ret < 0) {
 			dev_err(dev, "Cannot read device properties.\n");
 			return ret;
 		}
 	} else {
-		return -ENODEV;
+		dev_dbg(dev, "init using platform data\n");
+		bq24257_pdata_probe(bq, pdata);
 	}
 
 	/*
@@ -1101,7 +1192,13 @@ static int bq24257_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq <= 0)
+	/*
+	 * When using device firmware we either take the IRQ specified directly
+	 * or probe for a pin named BQ24257_STAT_IRQ. In case of using platform
+	 * data always run the IRQ pin probe function to finish IRQ and GPIO
+	 * setup based on the stat pin specified in the platform data.
+	 */
+	if (client->irq <= 0 || pdata)
 		client->irq = bq24257_irq_probe(bq);
 
 	if (client->irq < 0) {
diff --git a/include/linux/power/bq24257_charger.h b/include/linux/power/bq24257_charger.h
new file mode 100644
index 0000000..7fc505b
--- /dev/null
+++ b/include/linux/power/bq24257_charger.h
@@ -0,0 +1,30 @@
+/*
+ * Platform data for the TI bq24257 battery charger driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _BQ24257_CHARGER_H_
+#define _BQ24257_CHARGER_H_
+
+#include <asm/types.h>
+#include <linux/types.h>
+
+struct bq24257_platform_data {
+	u32 ichg;				       /* charge current (uA) */
+	u32 vbat;				   /* regulation voltage (uV) */
+	u32 iterm;				  /* termination current (uA) */
+	u32 in_ilimit;				  /* input current limit (uA) */
+	u32 vovp;		      /* over voltage protection voltage (uV) */
+	u32 vindpm;			 /* VDMP input threshold voltage (uV) */
+	bool in_ilimit_autoset_disable;	/* auto-detect of input current limit */
+	bool pg_gpio_disable;	     /* use of a dedicated pin for Power Good */
+	bool timer2x_enable;		      /* slow down safety timer by 2x */
+
+	int stat_gpio;				  /* stat_int (interrupt) pin */
+	int pg_gpio;					    /* power good pin */
+};
+
+#endif
-- 
1.9.1

