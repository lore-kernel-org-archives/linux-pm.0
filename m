From: Vinay Simha BN <simhavcs@gmail.com>
Subject: [PATCH 4/4] power: smb347-charger: Summit SMB345 charger IC
Date: Wed,  7 Sep 2016 15:50:13 +0530
Message-ID: <1473243615-29746-4-git-send-email-simhavcs@gmail.com>
References: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473243615-29746-1-git-send-email-simhavcs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Vinay Simha BN <simhavcs@gmail.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Summit microelectronics SMB345 charger chip added.

Cc: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
---
 .../bindings/power/supply/smb347_charger.txt       |  21 +++-
 drivers/power/supply/smb347-charger.c              | 123 ++++++++++-----------
 2 files changed, 81 insertions(+), 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
index 91570a5..939a86d 100644
--- a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
@@ -2,7 +2,8 @@ smb347_charger bindings
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 [Required porperties]
-- compatible : "summit,smb347"
+- compatible : "summit,smb345"
+	       "summit,smb347"
 - reg : Slave address for i2c interface
 # At least one of followings should be set
   - enable-usb-charging
@@ -39,6 +40,24 @@ smb347_charger bindings
 		<2> : Voltage compensation
 
 Example:
+	smb345@6a {
+		compatible = "summit,smb345";
+		reg = <0x6a>;
+		status = "okay";
+		interrupt-parent = <&tlmm_pinmux>;
+		interrupts = <23 IRQ_TYPE_EDGE_BOTH>;
+
+		max-chg-curr = <1800000>;
+		usb-curr-limit = <450000>;
+
+		chip-temp-thershold = <110>;
+
+		enable-usb-charging;
+		enable-otg-charging;
+
+		enable-chg-ctrl = <0>;  /* SW (i2c interface) */
+	};
+
 	smb347@7f {
 		compatible = "summit,smb347";
 		reg = <0x7f>;
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 472f5e2..c1a9b73 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -124,6 +124,7 @@
 
 /**
  * struct smb347_charger - smb347 charger instance
+ * @id: smb charger id
  * @lock: protects concurrent access to online variables
  * @dev: pointer to device
  * @regmap: pointer to driver regmap
@@ -136,6 +137,7 @@
  * @pdata: pointer to platform data
  */
 struct smb347_charger {
+	int                     id;
 	struct mutex		lock; /* protects concurrent access */
 	struct device		*dev;
 	struct regmap		*regmap;
@@ -148,58 +150,46 @@ struct smb347_charger {
 	const struct smb347_charger_platform_data *pdata;
 };
 
+enum smb_charger_chipid {
+	SMB345,
+	SMB347,
+	NUM_CHIP_TYPES,
+};
+
 /* Fast charge current in uA */
-static const unsigned int fcc_tbl[] = {
-	700000,
-	900000,
-	1200000,
-	1500000,
-	1800000,
-	2000000,
-	2200000,
-	2500000,
+static const unsigned int fcc_tbl[NUM_CHIP_TYPES][8] = {
+	[SMB345] = { 200000, 450000, 600000, 900000,
+			1300000, 1500000, 1800000, 2000000 },
+	[SMB347] = { 700000, 900000, 1200000, 1500000,
+			1800000, 2000000, 2200000, 2500000 },
 };
 
 /* Pre-charge current in uA */
-static const unsigned int pcc_tbl[] = {
-	100000,
-	150000,
-	200000,
-	250000,
+static const unsigned int pcc_tbl[NUM_CHIP_TYPES][4] = {
+	[SMB345] = { 150000, 250000, 350000, 450000 },
+	[SMB347] = { 100000, 150000, 200000, 250000 },
 };
 
 /* Termination current in uA */
-static const unsigned int tc_tbl[] = {
-	37500,
-	50000,
-	100000,
-	150000,
-	200000,
-	250000,
-	500000,
-	600000,
+static const unsigned int tc_tbl[NUM_CHIP_TYPES][8] = {
+	[SMB345] = { 30000, 40000, 60000, 80000,
+			100000, 125000, 150000, 200000 },
+	[SMB347] = { 37500, 50000, 100000, 150000,
+			200000, 250000, 500000, 600000 },
 };
 
 /* Input current limit in uA */
-static const unsigned int icl_tbl[] = {
-	300000,
-	500000,
-	700000,
-	900000,
-	1200000,
-	1500000,
-	1800000,
-	2000000,
-	2200000,
-	2500000,
+static const unsigned int icl_tbl[NUM_CHIP_TYPES][10] = {
+	[SMB345] = { 300000, 500000, 700000, 1000000, 1500000,
+			1800000, 2000000, 2000000, 2000000, 2000000 },
+	[SMB347] = { 300000, 500000, 700000, 900000, 1200000,
+			1500000, 1800000, 2000000, 2200000, 2500000 },
 };
 
 /* Charge current compensation in uA */
-static const unsigned int ccc_tbl[] = {
-	250000,
-	700000,
-	900000,
-	1200000,
+static const unsigned int ccc_tbl[NUM_CHIP_TYPES][4] = {
+	[SMB345] = { 200000, 450000, 600000, 900000 },
+	[SMB347] = { 250000, 700000, 900000, 1200000 },
 };
 
 /* Convert register value to current using lookup table */
@@ -354,10 +344,10 @@ static int smb347_start_stop_charging(struct smb347_charger *smb)
 
 static int smb347_set_charge_current(struct smb347_charger *smb)
 {
-	int ret;
+	int ret, id = smb->id;
 
 	if (smb->pdata->max_charge_current) {
-		ret = current_to_hw(fcc_tbl, ARRAY_SIZE(fcc_tbl),
+		ret = current_to_hw(fcc_tbl[id], ARRAY_SIZE(fcc_tbl[id]),
 				    smb->pdata->max_charge_current);
 		if (ret < 0)
 			return ret;
@@ -370,7 +360,7 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->pre_charge_current) {
-		ret = current_to_hw(pcc_tbl, ARRAY_SIZE(pcc_tbl),
+		ret = current_to_hw(pcc_tbl[id], ARRAY_SIZE(pcc_tbl[id]),
 				    smb->pdata->pre_charge_current);
 		if (ret < 0)
 			return ret;
@@ -383,7 +373,7 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->termination_current) {
-		ret = current_to_hw(tc_tbl, ARRAY_SIZE(tc_tbl),
+		ret = current_to_hw(tc_tbl[id], ARRAY_SIZE(tc_tbl[id]),
 				    smb->pdata->termination_current);
 		if (ret < 0)
 			return ret;
@@ -399,10 +389,10 @@ static int smb347_set_charge_current(struct smb347_charger *smb)
 
 static int smb347_set_current_limits(struct smb347_charger *smb)
 {
-	int ret;
+	int ret, id = smb->id;
 
 	if (smb->pdata->mains_current_limit) {
-		ret = current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
+		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
 				    smb->pdata->mains_current_limit);
 		if (ret < 0)
 			return ret;
@@ -415,7 +405,7 @@ static int smb347_set_current_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->usb_hc_current_limit) {
-		ret = current_to_hw(icl_tbl, ARRAY_SIZE(icl_tbl),
+		ret = current_to_hw(icl_tbl[id], ARRAY_SIZE(icl_tbl[id]),
 				    smb->pdata->usb_hc_current_limit);
 		if (ret < 0)
 			return ret;
@@ -468,7 +458,7 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 {
 	bool enable_therm_monitor = false;
 	int ret = 0;
-	int val;
+	int val, id = smb->id;
 
 	if (smb->pdata->chip_temp_threshold) {
 		val = smb->pdata->chip_temp_threshold;
@@ -593,7 +583,7 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->charge_current_compensation) {
-		val = current_to_hw(ccc_tbl, ARRAY_SIZE(ccc_tbl),
+		val = current_to_hw(ccc_tbl[id], ARRAY_SIZE(ccc_tbl[id]),
 				    smb->pdata->charge_current_compensation);
 		if (val < 0)
 			return val;
@@ -729,10 +719,12 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 		return IRQ_NONE;
 	}
 
-	ret = regmap_read(smb->regmap, IRQSTAT_D, &irqstat_d);
-	if (ret < 0) {
-		dev_warn(smb->dev, "reading IRQSTAT_D failed\n");
-		return IRQ_NONE;
+	if (smb->id != SMB345) {
+		ret = regmap_read(smb->regmap, IRQSTAT_D, &irqstat_d);
+		if (ret < 0) {
+			dev_warn(smb->dev, "reading IRQSTAT_D failed\n");
+			return IRQ_NONE;
+		}
 	}
 
 	ret = regmap_read(smb->regmap, IRQSTAT_E, &irqstat_e);
@@ -767,13 +759,15 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
 	 * If we got a charger timeout INT that means the charge
 	 * full is not detected with in charge timeout value.
 	 */
-	if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_IRQ) {
-		dev_dbg(smb->dev, "total Charge Timeout INT received\n");
+	if (smb->id != SMB345) {
+		if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_IRQ) {
+			dev_dbg(smb->dev, "total Charge Timeout INT received\n");
 
-		if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_STAT)
-			dev_warn(smb->dev, "charging stopped due to timeout\n");
-		power_supply_changed(smb->battery);
-		handled = true;
+			if (irqstat_d & IRQSTAT_D_CHARGE_TIMEOUT_STAT)
+				dev_warn(smb->dev, "charging stopped due to timeout\n");
+			power_supply_changed(smb->battery);
+			handled = true;
+		}
 	}
 
 	/*
@@ -878,7 +872,7 @@ out:
  */
 static int get_const_charge_current(struct smb347_charger *smb)
 {
-	int ret, intval;
+	int ret, intval, id = smb->id;
 	unsigned int v;
 
 	if (!smb347_is_ps_online(smb))
@@ -893,10 +887,12 @@ static int get_const_charge_current(struct smb347_charger *smb)
 	 * and we can detect which table to use from bit 5.
 	 */
 	if (v & 0x20) {
-		intval = hw_to_current(fcc_tbl, ARRAY_SIZE(fcc_tbl), v & 7);
+		intval = hw_to_current(fcc_tbl[id],
+				       ARRAY_SIZE(fcc_tbl[id]), v & 7);
 	} else {
 		v >>= 3;
-		intval = hw_to_current(pcc_tbl, ARRAY_SIZE(pcc_tbl), v & 7);
+		intval = hw_to_current(pcc_tbl[id],
+				       ARRAY_SIZE(pcc_tbl[id]), v & 7);
 	}
 
 	return intval;
@@ -1300,6 +1296,7 @@ static int smb347_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, smb);
 
 	mutex_init(&smb->lock);
+	smb->id = id->driver_data;
 	smb->dev = &client->dev;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
@@ -1374,13 +1371,15 @@ static int smb347_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id smb347_id[] = {
-	{ "smb347", 0 },
+	{ "smb345", SMB345 },
+	{ "smb347", SMB347 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id of_smb347_ids[] = {
+	{ .compatible = "summit,smb345" },
 	{ .compatible = "summit,smb347" },
 	{},
 };
-- 
2.1.2
