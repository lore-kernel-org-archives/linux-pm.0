From: Milo Kim <milo.kim@ti.com>
Subject: [PATCH 1/2] power:lp8727_charger: use the private data instead of updating I2C device platform data
Date: Tue, 25 Aug 2015 15:07:07 +0900
Message-ID: <1440482828-7004-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbbHYGHg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2015 02:07:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Milo Kim <milo.kim@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Currently, lp8727 charger driver parses the DT and copies values into the
'cl->dev.platform_data' if 'of_node' exists.
This may have architectural issue. Platform data is configurable through
the DT or I2C board info inside the platform area.
However, lp8727 driver changes this configuration when it is loaded.

The driver should get data from the platform side and use the private
data, 'lp8727_chg->pdata' instead of changing the original platform data.

_probe() procedure is changed as follows.
  1. lp8727_parse_dt() returns the pointer of lp8727_platform_data.
     The driver uses this allocated platform data. So it should keep
     original platform data, 'dev->platform_data'.
  2. In _probe(), check the return value of lp8727_parse_dt().
     If an error is found, then exit as PTR_ERR(pdata).
  3. If 'of_node' is not found, then the driver just gets the platform data
     from the I2C device structure.
  4. Map the platform data to private data structure.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <milo.kim@ti.com>
---
 drivers/power/lp8727_charger.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/power/lp8727_charger.c b/drivers/power/lp8727_charger.c
index 7e741f1..30dc265 100644
--- a/drivers/power/lp8727_charger.c
+++ b/drivers/power/lp8727_charger.c
@@ -508,7 +508,7 @@ out:
 	return param;
 }
 
-static int lp8727_parse_dt(struct device *dev)
+static struct lp8727_platform_data *lp8727_parse_dt(struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct device_node *child;
@@ -517,11 +517,11 @@ static int lp8727_parse_dt(struct device *dev)
 
 	/* If charging parameter is not defined, just skip parsing the dt */
 	if (of_get_child_count(np) == 0)
-		goto out;
+		return NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	of_property_read_u32(np, "debounce-ms", &pdata->debounce_msec);
 
@@ -535,29 +535,30 @@ static int lp8727_parse_dt(struct device *dev)
 			pdata->usb = lp8727_parse_charge_pdata(dev, child);
 	}
 
-	dev->platform_data = pdata;
-out:
-	return 0;
+	return pdata;
 }
 #else
-static int lp8727_parse_dt(struct device *dev)
+static struct lp8727_platform_data *lp8727_parse_dt(struct device *dev)
 {
-	return 0;
+	return NULL;
 }
 #endif
 
 static int lp8727_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 {
 	struct lp8727_chg *pchg;
+	struct lp8727_platform_data *pdata;
 	int ret;
 
 	if (!i2c_check_functionality(cl->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -EIO;
 
 	if (cl->dev.of_node) {
-		ret = lp8727_parse_dt(&cl->dev);
-		if (ret)
-			return ret;
+		pdata = lp8727_parse_dt(&cl->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	} else {
+		pdata = dev_get_platdata(&cl->dev);
 	}
 
 	pchg = devm_kzalloc(&cl->dev, sizeof(*pchg), GFP_KERNEL);
@@ -566,7 +567,7 @@ static int lp8727_probe(struct i2c_client *cl, const struct i2c_device_id *id)
 
 	pchg->client = cl;
 	pchg->dev = &cl->dev;
-	pchg->pdata = cl->dev.platform_data;
+	pchg->pdata = pdata;
 	i2c_set_clientdata(cl, pchg);
 
 	mutex_init(&pchg->xfer_lock);
-- 
1.9.1

