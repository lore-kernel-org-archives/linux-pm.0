From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through power_supply
 class
Date: Tue, 14 Nov 2017 11:44:47 +0000
Message-ID: <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510657748.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Yueyao Zhu <yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This commit adds a power_supply class instance to represent a
PD source's voltage and current properties. This provides an
interface for reading these properties from user-space or other
drivers.

For PPS enabled Sources, this also provides write access to set
the current and voltage and allows for swapping between standard
PDO and PPS APDO.

As this represents a superset of the information provided in the
fusb302 driver, the power_supply instance in that code is removed
as part of this change, so reverting the commit titled
'typec: tcpm: Represent source supply through power_supply class'

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/typec/Kconfig           |   1 +
 drivers/usb/typec/fusb302/Kconfig   |   2 +-
 drivers/usb/typec/fusb302/fusb302.c |  63 +---------
 drivers/usb/typec/tcpm.c            | 225 +++++++++++++++++++++++++++++++++++-
 4 files changed, 228 insertions(+), 63 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index 465d7da..b9cd806 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -8,6 +8,7 @@ config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
 	select TYPEC
+	select POWER_SUPPLY
 	help
 	  The Type-C Port Controller Manager provides a USB PD and USB Type-C
 	  state machine for use with Type-C Port Controllers.
diff --git a/drivers/usb/typec/fusb302/Kconfig b/drivers/usb/typec/fusb302/Kconfig
index 48a4f2f..fce099f 100644
--- a/drivers/usb/typec/fusb302/Kconfig
+++ b/drivers/usb/typec/fusb302/Kconfig
@@ -1,6 +1,6 @@
 config TYPEC_FUSB302
 	tristate "Fairchild FUSB302 Type-C chip driver"
-	depends on I2C && POWER_SUPPLY
+	depends on I2C
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index 72cb060..21bd075 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -19,7 +19,6 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
@@ -100,11 +99,6 @@ struct fusb302_chip {
 	/* lock for sharing chip states */
 	struct mutex lock;
 
-	/* psy + psy status */
-	struct power_supply *psy;
-	u32 current_limit;
-	u32 supply_voltage;
-
 	/* chip status */
 	enum toggling_mode toggling_mode;
 	enum src_current_status src_current_status;
@@ -873,13 +867,11 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 		chip->vbus_on = on;
 		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
 	}
-	if (chip->charge_on == charge) {
+	if (chip->charge_on == charge)
 		fusb302_log(chip, "charge is already %s",
 			    charge ? "On" : "Off");
-	} else {
+	else
 		chip->charge_on = charge;
-		power_supply_changed(chip->psy);
-	}
 
 done:
 	mutex_unlock(&chip->lock);
@@ -895,11 +887,6 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
 	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
 		    max_ma, mv);
 
-	chip->supply_voltage = mv;
-	chip->current_limit = max_ma;
-
-	power_supply_changed(chip->psy);
-
 	return 0;
 }
 
@@ -1685,43 +1672,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int fusb302_psy_get_property(struct power_supply *psy,
-				    enum power_supply_property psp,
-				    union power_supply_propval *val)
-{
-	struct fusb302_chip *chip = power_supply_get_drvdata(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = chip->charge_on;
-		break;
-	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = chip->supply_voltage * 1000; /* mV -> µV */
-		break;
-	case POWER_SUPPLY_PROP_CURRENT_MAX:
-		val->intval = chip->current_limit * 1000; /* mA -> µA */
-		break;
-	default:
-		return -ENODATA;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property fusb302_psy_properties[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_MAX,
-};
-
-static const struct power_supply_desc fusb302_psy_desc = {
-	.name		= "fusb302-typec-source",
-	.type		= POWER_SUPPLY_TYPE_USB_TYPE_C,
-	.properties	= fusb302_psy_properties,
-	.num_properties	= ARRAY_SIZE(fusb302_psy_properties),
-	.get_property	= fusb302_psy_get_property,
-};
-
 static int init_gpio(struct fusb302_chip *chip)
 {
 	struct device_node *node;
@@ -1761,7 +1711,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
-	struct power_supply_config cfg = {};
 	const char *name;
 	int ret = 0;
 	u32 v;
@@ -1808,14 +1757,6 @@ static int fusb302_probe(struct i2c_client *client,
 			return -EPROBE_DEFER;
 	}
 
-	cfg.drv_data = chip;
-	chip->psy = devm_power_supply_register(dev, &fusb302_psy_desc, &cfg);
-	if (IS_ERR(chip->psy)) {
-		ret = PTR_ERR(chip->psy);
-		dev_err(chip->dev, "Error registering power-supply: %d\n", ret);
-		return ret;
-	}
-
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 78983e1..7c26c3d 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/clock.h>
 #include <linux/seq_file.h>
@@ -277,6 +278,10 @@ struct tcpm_port {
 	u32 current_limit;
 	u32 supply_voltage;
 
+	/* Used to export TA voltage and current */
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+
 	u32 bist_request;
 
 	/* PD state for Vendor Defined Messages */
@@ -1756,6 +1761,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	int ret = -EINVAL;
 
 	port->pps_data.supported = false;
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD;
 
 	/*
 	 * Select the source PDO providing the most power while staying within
@@ -1775,8 +1781,10 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 			mv = pdo_min_voltage(pdo);
 			break;
 		case PDO_TYPE_APDO:
-			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
 				port->pps_data.supported = true;
+				port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD_PPS;
+			}
 			continue;
 		default:
 			tcpm_log(port, "Invalid PDO type, ignoring");
@@ -2248,6 +2256,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_snk_count = 0;
 	port->supply_voltage = 0;
 	port->current_limit = 0;
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_TYPE_C;
+
+	power_supply_changed(port->psy);
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2780,6 +2791,8 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_pps_complete(port, port->pps_status);
 
+		power_supply_changed(port->psy);
+
 		break;
 
 	/* Accessory states */
@@ -3937,6 +3950,212 @@ void tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 }
 EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
 
+/* Power Supply access to expose source power information */
+enum tcpm_psy_online_states {
+	TCPM_PSY_OFFLINE = 0,
+	TCPM_PSY_FIXED_ONLINE,
+	TCPM_PSY_PROG_ONLINE,
+};
+
+static enum power_supply_property tcpm_psy_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int tcpm_psy_get_online(struct tcpm_port *port,
+			       union power_supply_propval *val)
+{
+	if (port->vbus_charge) {
+		if (port->pps_data.active)
+			val->intval = TCPM_PSY_PROG_ONLINE;
+		else
+			val->intval = TCPM_PSY_FIXED_ONLINE;
+	} else {
+		val->intval = TCPM_PSY_OFFLINE;
+	}
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_min(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.min_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_voltage_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.out_volt * 1000;
+	else
+		val->intval = port->supply_voltage * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_max(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.max_curr * 1000;
+	else
+		val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_current_now(struct tcpm_port *port,
+				    union power_supply_propval *val)
+{
+	if (port->pps_data.active)
+		val->intval = port->pps_data.op_curr * 1000;
+	else
+		val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_get_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = tcpm_psy_get_voltage_min(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		ret = tcpm_psy_get_voltage_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = tcpm_psy_get_voltage_now(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = tcpm_psy_get_current_max(port, val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = tcpm_psy_get_current_now(port, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_online(struct tcpm_port *port,
+			       const union power_supply_propval *val)
+{
+	int ret;
+
+	switch (val->intval) {
+	case TCPM_PSY_FIXED_ONLINE:
+		ret = tcpm_pps_activate(port, false);
+		break;
+	case TCPM_PSY_PROG_ONLINE:
+		ret = tcpm_pps_activate(port, true);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_set_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = tcpm_psy_set_online(port, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		if ((val->intval < (port->pps_data.min_volt * 1000)) ||
+		    (val->intval > (port->pps_data.max_volt * 1000)))
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_out_volt(port, (val->intval / 1000));
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		if (val->intval > (port->pps_data.max_curr * 1000))
+			ret = -EINVAL;
+		else
+			ret = tcpm_pps_set_op_curr(port, (val->intval / 1000));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int tcpm_psy_prop_writeable(struct power_supply *psy,
+				   enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+int devm_tcpm_psy_register(struct tcpm_port *port)
+{
+	struct power_supply_config psy_cfg = {};
+
+	psy_cfg.drv_data = port;
+	port->psy_desc.name = "tcpm-source-psy",
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_TYPE_C,
+	port->psy_desc.properties = tcpm_psy_props,
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
+	port->psy_desc.get_property = tcpm_psy_get_prop,
+	port->psy_desc.set_property = tcpm_psy_set_prop,
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+
+	port->psy = devm_power_supply_register(port->dev, &port->psy_desc,
+					       &psy_cfg);
+	if (IS_ERR(port->psy))
+		return PTR_ERR(port->psy);
+
+	return 0;
+}
+
 struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 {
 	struct tcpm_port *port;
@@ -4000,6 +4219,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = tcpc->config->type;
 
+	err = devm_tcpm_psy_register(port);
+	if (err)
+		goto out_destroy_wq;
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (!port->typec_port) {
 		err = -ENOMEM;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
