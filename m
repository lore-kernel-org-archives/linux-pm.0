From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH] power: supply: ltc2941-battery-gauge: Add charge empty and
 full properties
Date: Wed, 17 Jan 2018 20:48:54 +0100
Message-ID: <20180117194607.GA7563@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:56614 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeAQTtK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 14:49:10 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993497AbeAQTtBbi7u- (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jan 2018 20:49:01 +0100
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>

Add properties for charge empty and charge full thresholds.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 59 +++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index 08e4fd9ee607..523373ea9cbd 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -34,6 +34,10 @@ enum ltc294x_reg {
 	LTC294X_REG_CONTROL		= 0x01,
 	LTC294X_REG_ACC_CHARGE_MSB	= 0x02,
 	LTC294X_REG_ACC_CHARGE_LSB	= 0x03,
+	LTC294X_REG_CHARGE_THR_HIGH_MSB	= 0x04,
+	LTC294X_REG_CHARGE_THR_HIGH_LSB	= 0x05,
+	LTC294X_REG_CHARGE_THR_LOW_MSB	= 0x06,
+	LTC294X_REG_CHARGE_THR_LOW_LSB	= 0x07,
 	LTC294X_REG_VOLTAGE_MSB		= 0x08,
 	LTC294X_REG_VOLTAGE_LSB		= 0x09,
 	LTC2942_REG_TEMPERATURE_MSB	= 0x0C,
@@ -178,21 +182,22 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
 	return ret;
 }
 
-static int ltc294x_read_charge_register(const struct ltc294x_info *info)
-{
+static int ltc294x_read_charge_register(const struct ltc294x_info *info,
+					enum ltc294x_reg reg)
+ {
 	int ret;
 	u8 datar[2];
 
-	ret = ltc294x_read_regs(info->client,
-		LTC294X_REG_ACC_CHARGE_MSB, &datar[0], 2);
+	ret = ltc294x_read_regs(info->client, reg, &datar[0], 2);
 	if (ret < 0)
 		return ret;
 	return (datar[0] << 8) + datar[1];
 }
 
-static int ltc294x_get_charge_now(const struct ltc294x_info *info, int *val)
+static int ltc294x_get_charge(const struct ltc294x_info *info,
+				enum ltc294x_reg reg, int *val)
 {
-	int value = ltc294x_read_charge_register(info);
+	int value = ltc294x_read_charge_register(info, reg);
 
 	if (value < 0)
 		return value;
@@ -244,10 +249,29 @@ static int ltc294x_set_charge_now(const struct ltc294x_info *info, int val)
 	return ret < 0 ? ret : 0;
 }
 
+static int ltc294x_set_charge_thr(const struct ltc294x_info *info,
+					enum ltc294x_reg reg, int val)
+{
+	u8 dataw[2];
+	s32 value;
+
+	value = convert_uAh_to_bin(info, val);
+	/* Direction depends on how sense+/- were connected */
+	if (info->Qlsb < 0)
+		value += 0xFFFF;
+	if ((value < 0) || (value > 0xFFFF)) /* input validation */
+		return -EINVAL;
+
+	/* Set new charge value */
+	dataw[0] = I16_MSB(value);
+	dataw[1] = I16_LSB(value);
+	return ltc294x_write_regs(info->client, reg, &dataw[0], 2);
+}
+
 static int ltc294x_get_charge_counter(
 	const struct ltc294x_info *info, int *val)
 {
-	int value = ltc294x_read_charge_register(info);
+	int value = ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARGE_MSB);
 
 	if (value < 0)
 		return value;
@@ -335,8 +359,15 @@ static int ltc294x_get_property(struct power_supply *psy,
 	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (prop) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_HIGH_MSB,
+						&val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
+		return ltc294x_get_charge(info, LTC294X_REG_CHARGE_THR_LOW_MSB,
+						&val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		return ltc294x_get_charge_now(info, &val->intval);
+		return ltc294x_get_charge(info, LTC294X_REG_ACC_CHARGE_MSB,
+						&val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		return ltc294x_get_charge_counter(info, &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -357,6 +388,12 @@ static int ltc294x_set_property(struct power_supply *psy,
 	struct ltc294x_info *info = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		return ltc294x_set_charge_thr(info,
+			LTC294X_REG_CHARGE_THR_HIGH_MSB, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
+		return ltc294x_set_charge_thr(info,
+			LTC294X_REG_CHARGE_THR_LOW_MSB, val->intval);
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		return ltc294x_set_charge_now(info, val->intval);
 	default:
@@ -368,6 +405,8 @@ static int ltc294x_property_is_writeable(
 	struct power_supply *psy, enum power_supply_property psp)
 {
 	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
 		return 1;
 	default:
@@ -377,7 +416,7 @@ static int ltc294x_property_is_writeable(
 
 static void ltc294x_update(struct ltc294x_info *info)
 {
-	int charge = ltc294x_read_charge_register(info);
+	int charge = ltc294x_read_charge_register(info, LTC294X_REG_ACC_CHARGE_MSB);
 
 	if (charge != info->charge) {
 		info->charge = charge;
@@ -396,6 +435,8 @@ static void ltc294x_work(struct work_struct *work)
 
 static enum power_supply_property ltc294x_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_EMPTY,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_TEMP,
-- 
2.15.1
