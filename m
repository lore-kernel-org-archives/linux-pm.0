From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] pm2301_charger: Use common error handling code in three
 functions
Date: Wed, 1 Nov 2017 11:03:51 +0100
Message-ID: <c9e362be-6937-45af-f597-6d085b39c02d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:54643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751306AbdKAKD4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Nov 2017 06:03:56 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 1 Nov 2017 10:56:29 +0100

* Add jump targets so that two error messages are stored only once
  at the end of these function implementations.

* Replace ten calls of the function "dev_err" by goto statements.

* Adjust 12 condition checks.

* Replace string literals by references to two global constant variables
  in five functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/pm2301_charger.c | 94 ++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 78561b6884fc..3c9c0fe87246 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -112,6 +112,9 @@ static const struct i2c_device_id pm2xxx_ident[] = {
 	{ }
 };
 
+static char const read_failure[] = "%s pm2xxx read failed\n";
+static char const write_failure[] = "%s pm2xxx write failed\n";
+
 static void set_lpn_pin(struct pm2xxx_charger *pm2)
 {
 	if (!pm2->ac.charger_connected && gpio_is_valid(pm2->lpn_pin)) {
@@ -181,20 +184,20 @@ static int pm2xxx_charging_disable_mngt(struct pm2xxx_charger *pm2)
 
 	/* Disable SW EOC ctrl */
 	ret = pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG, PM2XXX_SWCTRL_HW);
-	if (ret < 0) {
-		dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-		return ret;
-	}
+	if (ret)
+		goto report_write_failure;
 
 	/* Disable charging */
 	ret = pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG2,
 			(PM2XXX_CH_AUTO_RESUME_DIS | PM2XXX_CHARGER_DIS));
-	if (ret < 0) {
-		dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-		return ret;
-	}
+	if (ret)
+		goto report_write_failure;
 
 	return 0;
+
+report_write_failure:
+	dev_err(pm2->dev, write_failure, __func__);
+	return ret;
 }
 
 static int pm2xxx_charger_batt_therm_mngt(struct pm2xxx_charger *pm2, int val)
@@ -244,10 +247,9 @@ static int pm2xxx_charger_vbat_lsig_mngt(struct pm2xxx_charger *pm2, int val)
 		/* Enable SW EOC ctrl */
 		ret = pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG,
 							PM2XXX_SWCTRL_SW);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-			return ret;
-		}
+		if (ret)
+			goto report_write_failure;
+
 		break;
 
 	case PM2XXX_INT1_ITVBATLOWF:
@@ -255,10 +257,9 @@ static int pm2xxx_charger_vbat_lsig_mngt(struct pm2xxx_charger *pm2, int val)
 		/* Disable SW EOC ctrl */
 		ret = pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG,
 							PM2XXX_SWCTRL_HW);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-			return ret;
-		}
+		if (ret)
+			goto report_write_failure;
+
 		break;
 
 	default:
@@ -266,6 +267,10 @@ static int pm2xxx_charger_vbat_lsig_mngt(struct pm2xxx_charger *pm2, int val)
 	}
 
 	return 0;
+
+report_write_failure:
+	dev_err(pm2->dev, write_failure, __func__);
+	return ret;
 }
 
 static int pm2xxx_charger_bat_disc_mngt(struct pm2xxx_charger *pm2, int val)
@@ -513,8 +518,8 @@ static int pm2xxx_charger_get_ac_cv(struct pm2xxx_charger *pm2)
 	if (pm2->ac.charger_connected && pm2->ac.charger_online) {
 
 		ret = pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT4, &val);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
+		if (ret) {
+			dev_err(pm2->dev, read_failure, __func__);
 			goto out;
 		}
 
@@ -748,45 +753,34 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 		}
 
 		ret = pm2xxx_reg_read(pm2, PM2XXX_BATT_CTRL_REG8, &val);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
-			goto error_occured;
-		}
+		if (ret)
+			goto report_read_failure;
+
 		val &= ~PM2XXX_CH_VOLT_MASK;
 		val |= volt_index;
 		ret = pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG8, val);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-			goto error_occured;
-		}
+		if (ret)
+			goto report_write_failure;
 
 		ret = pm2xxx_reg_read(pm2, PM2XXX_BATT_CTRL_REG6, &val);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
-			goto error_occured;
-		}
+		if (ret)
+			goto report_read_failure;
+
 		val &= ~PM2XXX_DIR_CH_CC_CURRENT_MASK;
 		val |= curr_index;
 		ret = pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG6, val);
-		if (ret < 0) {
-			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
-			goto error_occured;
-		}
+		if (ret)
+			goto report_write_failure;
 
 		if (!pm2->bat->enable_overshoot) {
 			ret = pm2xxx_reg_read(pm2, PM2XXX_LED_CTRL_REG, &val);
-			if (ret < 0) {
-				dev_err(pm2->dev, "%s pm2xxx read failed\n",
-								__func__);
-				goto error_occured;
-			}
+			if (ret)
+				goto report_read_failure;
+
 			val |= PM2XXX_ANTI_OVERSHOOT_EN;
 			ret = pm2xxx_reg_write(pm2, PM2XXX_LED_CTRL_REG, val);
-			if (ret < 0) {
-				dev_err(pm2->dev, "%s pm2xxx write failed\n",
-								__func__);
-				goto error_occured;
-			}
+			if (ret)
+				goto report_write_failure;
 		}
 
 		ret = pm2xxx_charging_enable_mngt(pm2);
@@ -820,6 +814,14 @@ static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
 
 error_occured:
 	return ret;
+
+report_read_failure:
+	dev_err(pm2->dev, read_failure, __func__);
+	return ret;
+
+report_write_failure:
+	dev_err(pm2->dev, write_failure, __func__);
+	return ret;
 }
 
 static int pm2xxx_charger_watchdog_kick(struct ux500_charger *charger)
@@ -884,8 +886,8 @@ static void pm2xxx_charger_check_main_thermal_prot_work(
 
 	/* Check if die temp warning is still active */
 	ret = pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT5, &val);
-	if (ret < 0) {
-		dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
+	if (ret) {
+		dev_err(pm2->dev, read_failure, __func__);
 		return;
 	}
 	if (val & (PM2XXX_INT5_S_ITTHERMALWARNINGRISE
-- 
2.14.3
