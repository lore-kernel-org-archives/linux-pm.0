From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v5 06/11] power: bq24257: Use managed power supply register
Date: Fri, 18 Sep 2015 16:39:54 -0500
Message-ID: <1442612399-341-7-git-send-email-dannenberg@ti.com>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56809 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754430AbbIRVkz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Sep 2015 17:40:55 -0400
In-Reply-To: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

Use the devm_* managed version of the function to register the power
supply and remove the associated unregister function.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 135cfd4..6ef61ae 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -675,8 +675,10 @@ static int bq24257_power_supply_init(struct bq24257_device *bq)
 	psy_cfg.supplied_to = bq24257_charger_supplied_to;
 	psy_cfg.num_supplicants = ARRAY_SIZE(bq24257_charger_supplied_to);
 
-	bq->charger = power_supply_register(bq->dev, &bq24257_power_supply_desc,
-					    &psy_cfg);
+	bq->charger = devm_power_supply_register(bq->dev,
+						 &bq24257_power_supply_desc,
+						 &psy_cfg);
+
 	if (IS_ERR(bq->charger))
 		return PTR_ERR(bq->charger);
 
@@ -906,8 +908,6 @@ static int bq24257_remove(struct i2c_client *client)
 	if (bq->iilimit_autoset_enable)
 		cancel_delayed_work_sync(&bq->iilimit_setup_work);
 
-	power_supply_unregister(bq->charger);
-
 	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
 
 	return 0;
-- 
1.9.1

