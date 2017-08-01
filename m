From: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] power: smb347-charger: Summit SMB358 charger IC
Date: Wed,  2 Aug 2017 00:20:26 +0530
Message-ID: <1501613430-24508-1-git-send-email-simhavcs@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Summit microelectronics' SMB358 charger chip has
almost the same register map and functionality.
voltage and current table are only differed.

SMB345 charger IC tested in nexus7

Cc: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sumit Semwal <sumit.semwal-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonghwa Lee <jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Myungjoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Vinay Simha BN <simhavcs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
v2:
* incorporated code review from Rob Herring
  gpio line added for Enable charging control,
  documentation bindings (vendor prefixes and unit suffixes)
---
 .../bindings/power/supply/smb347_charger.txt       |  73 +++++
 drivers/power/supply/smb347-charger.c              | 334 +++++++++++++--------
 include/linux/power/smb347-charger.h               |   4 +-
 3 files changed, 283 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/smb347_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/smb347_charger.txt b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
new file mode 100644
index 0000000..45da4ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/smb347_charger.txt
@@ -0,0 +1,73 @@
+smb347_charger bindings
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+[Required porperties]
+- compatible : "summit,smb345"
+	       "summit,smb347"
+- reg : Slave address for i2c interface
+# At least one of following should be set
+  - enable-usb-charging
+  - enable-otg-charging
+  - enable-mains-charging
+
+[Optional properties]
+- interrupt-parent : The phandle for the interrupt controller
+- interrupts : Interrupt line index for mapping
+- en-gpio : Enable charging control
+	  : If this is not specified it will use SW (i2c interface)
+
+# Charging constraints
+- max-chg-curr : microamps for charging Maximum current
+- max-chg-volt : microvolts for charging Maximum voltage
+- pre-chg-curr : microamps for Pre-charging current
+- term-curr : microamps for Charging cycle termination current
+- fast-volt-thershold : microvolts for Voltage threshold to transit to fast charge mode
+- mains-curr-limit : micromaps for Maximum input current from AC/DC input
+- usb-curr-limit : microamps for Maximum input current from USB input
+
+# Related thermometer monitoring (Degrees Celsius)
+- chip-temp-threshold : Chip temperature for thermal regulaton.   <100, 130>
+- soft-cold-temp-limit : Cold battery temperature for soft alarm. <0, 15>*
+- soft-hot-temp-limit : Hot battery temperature for soft alarm.   <40, 55>
+- hard-cold-temp-limit : Cold battery temperature for hard alarm. <0, 15>*
+- hard-hot-temp-limit : Hot battery temperature for hard alarm.   <55, 65>
+(* The written temperature has +5'C offset. 0'C -> -5'C, 15'C -> 10'C)
+- soft-comp-method : Soft temperature limit compensation method
+	(Not defined) : Use default setting
+		<0> : Compensation none
+		<1> : Charge current compensation
+		<2> : Voltage compensation
+
+Example:
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
+		chip-temp-thershold = <110>; /* celsius */
+
+		enable-usb-charging;
+		enable-otg-charging;
+	};
+
+	smb347@7f {
+		compatible = "summit,smb347";
+		reg = <0x7f>;
+		status = "okay";
+
+		max-chg-curr = <1800000>;
+		mains-curr-limit = <2000000>;
+		usb-curr-limit = <450000>;
+
+		chip-temp-thershold = <110>; /* celsius */
+
+		en-gpios = <&tlmm_pinmux 54 GPIO_ACTIVE_HIGH>;
+
+		enable-usb-charging;
+		enable-mains-charging;
+	};
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 072c518..28666ab 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -124,6 +124,7 @@
 
 /**
  * struct smb347_charger - smb347 charger instance
+ * @id: smb charger id
  * @lock: protects concurrent access to online variables
  * @dev: pointer to device
  * @regmap: pointer to driver regmap
@@ -136,7 +137,8 @@
  * @pdata: pointer to platform data
  */
 struct smb347_charger {
-	struct mutex		lock;
+	int                     id;
+	struct mutex		lock; /* protects concurrent access */
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct power_supply	*mains;
@@ -145,61 +147,49 @@ struct smb347_charger {
 	bool			mains_online;
 	bool			usb_online;
 	bool			charging_enabled;
-	const struct smb347_charger_platform_data *pdata;
+	struct smb347_charger_platform_data *pdata;
+};
+
+enum smb_charger_chipid {
+	SMB345,
+	SMB347,
+	NUM_CHIP_TYPES,
 };
 
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
@@ -440,9 +430,10 @@ static int smb347_set_voltage_limits(struct smb347_charger *smb)
 		ret = clamp_val(ret, 2400000, 3000000) - 2400000;
 		ret /= 200000;
 
-		ret = regmap_update_bits(smb->regmap, CFG_FLOAT_VOLTAGE,
-				CFG_FLOAT_VOLTAGE_THRESHOLD_MASK,
-				ret << CFG_FLOAT_VOLTAGE_THRESHOLD_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_FLOAT_VOLTAGE,
+			 CFG_FLOAT_VOLTAGE_THRESHOLD_MASK,
+			 ret << CFG_FLOAT_VOLTAGE_THRESHOLD_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
@@ -467,7 +458,7 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 {
 	bool enable_therm_monitor = false;
 	int ret = 0;
-	int val;
+	int val, id = smb->id;
 
 	if (smb->pdata->chip_temp_threshold) {
 		val = smb->pdata->chip_temp_threshold;
@@ -565,8 +556,9 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	}
 
 	if (smb->pdata->suspend_on_hard_temp_limit) {
-		ret = regmap_update_bits(smb->regmap, CFG_SYSOK,
-				 CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED, 0);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_SYSOK,
+			 CFG_SYSOK_SUSPEND_HARD_LIMIT_DISABLED, 0);
 		if (ret < 0)
 			return ret;
 	}
@@ -575,28 +567,31 @@ static int smb347_set_temp_limits(struct smb347_charger *smb)
 	    SMB347_SOFT_TEMP_COMPENSATE_DEFAULT) {
 		val = smb->pdata->soft_temp_limit_compensation & 0x3;
 
-		ret = regmap_update_bits(smb->regmap, CFG_THERM,
-				 CFG_THERM_SOFT_HOT_COMPENSATION_MASK,
-				 val << CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_THERM,
+			 CFG_THERM_SOFT_HOT_COMPENSATION_MASK,
+			 val << CFG_THERM_SOFT_HOT_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 
-		ret = regmap_update_bits(smb->regmap, CFG_THERM,
-				 CFG_THERM_SOFT_COLD_COMPENSATION_MASK,
-				 val << CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_THERM,
+			 CFG_THERM_SOFT_COLD_COMPENSATION_MASK,
+			 val << CFG_THERM_SOFT_COLD_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (smb->pdata->charge_current_compensation) {
-		val = current_to_hw(ccc_tbl, ARRAY_SIZE(ccc_tbl),
+		val = current_to_hw(ccc_tbl[id], ARRAY_SIZE(ccc_tbl[id]),
 				    smb->pdata->charge_current_compensation);
 		if (val < 0)
 			return val;
 
-		ret = regmap_update_bits(smb->regmap, CFG_OTG,
-				CFG_OTG_CC_COMPENSATION_MASK,
-				(val & 0x3) << CFG_OTG_CC_COMPENSATION_SHIFT);
+		ret = regmap_update_bits
+			(smb->regmap, CFG_OTG,
+			 CFG_OTG_CC_COMPENSATION_MASK,
+			 (val & 0x3) << CFG_OTG_CC_COMPENSATION_SHIFT);
 		if (ret < 0)
 			return ret;
 	}
@@ -662,7 +657,8 @@ static int smb347_hw_init(struct smb347_charger *smb)
 	 * support for driving VBUS. Otherwise we disable it.
 	 */
 	ret = regmap_update_bits(smb->regmap, CFG_OTHER, CFG_OTHER_RID_MASK,
-		smb->pdata->use_usb_otg ? CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
+				 smb->pdata->use_usb_otg ?
+				 CFG_OTHER_RID_ENABLED_AUTO_OTG : 0);
 	if (ret < 0)
 		goto fail;
 
@@ -723,10 +719,12 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
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
@@ -761,13 +759,15 @@ static irqreturn_t smb347_interrupt(int irq, void *data)
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
@@ -809,7 +809,7 @@ static int smb347_irq_set(struct smb347_charger *smb, bool enable)
 		goto fail;
 
 	ret = regmap_update_bits(smb->regmap, CFG_STATUS_IRQ, 0xff,
-			enable ? (CFG_STATUS_IRQ_TERMINATION_OR_TAPER |
+				 enable ? (CFG_STATUS_IRQ_TERMINATION_OR_TAPER |
 					CFG_STATUS_IRQ_CHARGE_TIMEOUT) : 0);
 	if (ret < 0)
 		goto fail;
@@ -834,22 +834,22 @@ static inline int smb347_irq_disable(struct smb347_charger *smb)
 static int smb347_irq_init(struct smb347_charger *smb,
 			   struct i2c_client *client)
 {
-	const struct smb347_charger_platform_data *pdata = smb->pdata;
-	int ret, irq = gpio_to_irq(pdata->irq_gpio);
+	int ret;
+	unsigned long irqflags;
 
-	ret = gpio_request_one(pdata->irq_gpio, GPIOF_IN, client->name);
-	if (ret < 0)
-		goto fail;
+	irqflags = client->dev.of_node ? 0 : IRQF_TRIGGER_FALLING;
+
+	ret = devm_request_threaded_irq(smb->dev, client->irq, NULL,
+					smb347_interrupt, irqflags |
+					IRQF_ONESHOT,
+					client->name, smb);
 
-	ret = request_threaded_irq(irq, NULL, smb347_interrupt,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   client->name, smb);
 	if (ret < 0)
-		goto fail_gpio;
+		goto out;
 
 	ret = smb347_set_writable(smb, true);
 	if (ret < 0)
-		goto fail_irq;
+		goto out;
 
 	/*
 	 * Configure the STAT output to be suitable for interrupts: disable
@@ -859,20 +859,10 @@ static int smb347_irq_init(struct smb347_charger *smb,
 				 CFG_STAT_ACTIVE_HIGH | CFG_STAT_DISABLED,
 				 CFG_STAT_DISABLED);
 	if (ret < 0)
-		goto fail_readonly;
-
-	smb347_set_writable(smb, false);
-	client->irq = irq;
-	return 0;
+		client->irq = 0;
 
-fail_readonly:
 	smb347_set_writable(smb, false);
-fail_irq:
-	free_irq(irq, smb);
-fail_gpio:
-	gpio_free(pdata->irq_gpio);
-fail:
-	client->irq = 0;
+out:
 	return ret;
 }
 
@@ -882,7 +872,7 @@ static int smb347_irq_init(struct smb347_charger *smb,
  */
 static int get_const_charge_current(struct smb347_charger *smb)
 {
-	int ret, intval;
+	int ret, intval, id = smb->id;
 	unsigned int v;
 
 	if (!smb347_is_ps_online(smb))
@@ -897,10 +887,12 @@ static int get_const_charge_current(struct smb347_charger *smb)
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
@@ -947,16 +939,14 @@ static int smb347_mains_get_property(struct power_supply *psy,
 		ret = get_const_charge_voltage(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = get_const_charge_current(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	default:
@@ -988,16 +978,14 @@ static int smb347_usb_get_property(struct power_supply *psy,
 		ret = get_const_charge_voltage(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = get_const_charge_current(smb);
 		if (ret < 0)
 			return ret;
-		else
-			val->intval = ret;
+		val->intval = ret;
 		break;
 
 	default:
@@ -1026,7 +1014,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb)
 		return ret;
 
 	if ((val & STAT_C_CHARGER_ERROR) ||
-			(val & STAT_C_HOLDOFF_STAT)) {
+	    (val & STAT_C_HOLDOFF_STAT)) {
 		/*
 		 * set to NOT CHARGING upon charger error
 		 * or charging has stopped.
@@ -1049,7 +1037,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb)
 		} else {
 			/*
 			 * in this case no charger error or termination
-			 * occured but charging is not in progress!!!
+			 * occurred but charging is not in progress!!!
 			 */
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		}
@@ -1178,6 +1166,75 @@ static bool smb347_readable_reg(struct device *dev, unsigned int reg)
 	return smb347_volatile_reg(dev, reg);
 }
 
+static void smb347_dt_parse_pdata(struct device_node *np,
+				  struct smb347_charger_platform_data *pdata)
+{
+	/* Charing constraints */
+	of_property_read_u32(np, "max-chg-curr", &pdata->max_charge_current);
+	of_property_read_u32(np, "max-chg-volt", &pdata->max_charge_voltage);
+	of_property_read_u32(np, "pre-chg-curr", &pdata->pre_charge_current);
+	of_property_read_u32(np, "term-curr", &pdata->termination_current);
+	of_property_read_u32(np, "fast-volt-threshold",
+			     &pdata->pre_to_fast_voltage);
+	of_property_read_u32(np, "mains-curr-limit",
+			     &pdata->mains_current_limit);
+	of_property_read_u32(np, "usb-curr-limit",
+			     &pdata->usb_hc_current_limit);
+
+	/* For thermometer monitoring */
+	of_property_read_u32(np, "chip-temp-threshold",
+			     &pdata->chip_temp_threshold);
+	if (of_property_read_u32(np, "soft-cold-temp-limit",
+				 &pdata->soft_cold_temp_limit))
+		pdata->soft_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "soft-hot-temp-limit",
+				 &pdata->soft_hot_temp_limit))
+		pdata->soft_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "hard-cold-temp-limit",
+				 &pdata->hard_cold_temp_limit))
+		pdata->hard_cold_temp_limit = SMB347_TEMP_USE_DEFAULT;
+	if (of_property_read_u32(np, "hard-hot-temp-limit",
+				 &pdata->hard_hot_temp_limit))
+		pdata->hard_hot_temp_limit = SMB347_TEMP_USE_DEFAULT;
+
+	/* Suspend when battery temperature is outside hard limits */
+	if ((pdata->hard_cold_temp_limit != SMB347_TEMP_USE_DEFAULT) ||
+	    (pdata->hard_hot_temp_limit != SMB347_TEMP_USE_DEFAULT))
+		pdata->suspend_on_hard_temp_limit = true;
+
+	if (of_property_read_u32(np, "soft-comp-method",
+				 &pdata->soft_temp_limit_compensation))
+		pdata->soft_temp_limit_compensation =
+				SMB347_SOFT_TEMP_COMPENSATE_DEFAULT;
+
+	of_property_read_u32(np, "chg-curr-comp",
+			     &pdata->charge_current_compensation);
+
+	/* Supported charging mode */
+	pdata->use_mains = of_property_read_bool(np, "enable-mains-charging");
+	pdata->use_usb = of_property_read_bool(np, "enable-usb-charging");
+	pdata->use_usb_otg = of_property_read_bool(np, "enable-otg-charging");
+
+	/* If IRQ is enabled or not */
+	if (!of_get_property(np, "interrupts", NULL))
+		pdata->irq_gpio = -1;
+}
+
+static struct smb347_charger_platform_data
+			*smb347_get_platdata(struct device *dev)
+{
+	struct smb347_charger_platform_data *pdata = NULL;
+
+	if (dev->of_node) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		smb347_dt_parse_pdata(dev->of_node, pdata);
+	} else {
+		pdata = dev_get_platdata(dev);
+	}
+
+	return pdata;
+}
+
 static const struct regmap_config smb347_regmap = {
 	.reg_bits	= 8,
 	.val_bits	= 8,
@@ -1210,32 +1267,34 @@ static const struct power_supply_desc smb347_battery_desc = {
 	.num_properties	= ARRAY_SIZE(smb347_battery_properties),
 };
 
+static char *battery[] = {
+	"smb347-battery",
+};
+
 static int smb347_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
-	static char *battery[] = { "smb347-battery" };
-	const struct smb347_charger_platform_data *pdata;
 	struct power_supply_config mains_usb_cfg = {}, battery_cfg = {};
 	struct device *dev = &client->dev;
 	struct smb347_charger *smb;
 	int ret;
 
-	pdata = dev->platform_data;
-	if (!pdata)
-		return -EINVAL;
-
-	if (!pdata->use_mains && !pdata->use_usb)
-		return -EINVAL;
-
 	smb = devm_kzalloc(dev, sizeof(*smb), GFP_KERNEL);
 	if (!smb)
 		return -ENOMEM;
 
+	smb->pdata = smb347_get_platdata(dev);
+	if (IS_ERR_OR_NULL(smb->pdata))
+		return -ENODEV;
+
+	if (!smb->pdata->use_mains && !smb->pdata->use_usb)
+		return -EINVAL;
+
 	i2c_set_clientdata(client, smb);
 
 	mutex_init(&smb->lock);
+	smb->id = id->driver_data;
 	smb->dev = &client->dev;
-	smb->pdata = pdata;
 
 	smb->regmap = devm_regmap_init_i2c(client, &smb347_regmap);
 	if (IS_ERR(smb->regmap))
@@ -1277,10 +1336,24 @@ static int smb347_probe(struct i2c_client *client,
 	}
 
 	/*
+	 * EN - enable input can be controlled by i2c or gpio.
+	 */
+	smb->pdata->en_gpio = devm_gpiod_get(dev, "en", GPIOD_OUT_HIGH);
+	if (IS_ERR(smb->pdata->en_gpio)) {
+		ret = PTR_ERR(smb->pdata->en_gpio);
+		dev_err(dev, "cannot get en-gpio %d\n", ret);
+		dev_dbg(smb->dev, "charging enable/disable in SW enabled\n");
+
+		smb->pdata->enable_control = SMB347_CHG_ENABLE_SW;
+	} else {
+		smb->pdata->enable_control = SMB347_CHG_ENABLE_PIN_ACTIVE_HIGH;
+	}
+
+	/*
 	 * Interrupt pin is optional. If it is connected, we setup the
 	 * interrupt support here.
 	 */
-	if (pdata->irq_gpio >= 0) {
+	if (smb->pdata->irq_gpio >= 0) {
 		ret = smb347_irq_init(smb, client);
 		if (ret < 0) {
 			dev_warn(dev, "failed to initialize IRQ: %d\n", ret);
@@ -1297,11 +1370,8 @@ static int smb347_remove(struct i2c_client *client)
 {
 	struct smb347_charger *smb = i2c_get_clientdata(client);
 
-	if (client->irq) {
+	if (client->irq)
 		smb347_irq_disable(smb);
-		free_irq(client->irq, smb);
-		gpio_free(smb->pdata->irq_gpio);
-	}
 
 	power_supply_unregister(smb->battery);
 	if (smb->pdata->use_usb)
@@ -1312,14 +1382,24 @@ static int smb347_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id smb347_id[] = {
-	{ "smb347", 0 },
+	{ "smb345", SMB345 },
+	{ "smb347", SMB347 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id of_smb347_ids[] = {
+	{ .compatible = "summit,smb345" },
+	{ .compatible = "summit,smb347" },
+	{},
+};
+#endif
+
 static struct i2c_driver smb347_driver = {
 	.driver = {
 		.name = "smb347",
+		.of_match_table = of_match_ptr(of_smb347_ids),
 	},
 	.probe        = smb347_probe,
 	.remove       = smb347_remove,
diff --git a/include/linux/power/smb347-charger.h b/include/linux/power/smb347-charger.h
index b3cb20d..7bdc709 100644
--- a/include/linux/power/smb347-charger.h
+++ b/include/linux/power/smb347-charger.h
@@ -47,7 +47,7 @@ enum smb347_chg_enable {
  * @pre_charge_current: current (in uA) to use in pre-charging phase
  * @termination_current: current (in uA) used to determine when the
  *			 charging cycle terminates
- * @pre_to_fast_voltage: voltage (in uV) treshold used for transitioning to
+ * @pre_to_fast_voltage: voltage (in uV) threshold used for transitioning to
  *			 pre-charge to fast charge mode
  * @mains_current_limit: maximum input current drawn from AC/DC input (in uA)
  * @usb_hc_current_limit: maximum input high current (in uA) drawn from USB
@@ -71,6 +71,7 @@ enum smb347_chg_enable {
  * @use_usb: USB input can be used
  * @use_usb_otg: USB OTG output can be used (not implemented yet)
  * @irq_gpio: GPIO number used for interrupts (%-1 if not used)
+ * @en_gpio: GPIO used for Enable input
  * @enable_control: how charging enable/disable is controlled
  *		    (driver/pin controls)
  *
@@ -111,6 +112,7 @@ struct smb347_charger_platform_data {
 	bool		use_usb;
 	bool		use_usb_otg;
 	int		irq_gpio;
+	struct gpio_desc *en_gpio;
 	enum smb347_chg_enable enable_control;
 };
 
-- 
2.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
