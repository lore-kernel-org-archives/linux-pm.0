From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 6/7] typec: tcpm: Represent source supply through power_supply
 class
Date: Mon, 18 Dec 2017 12:41:41 +0000
Message-ID: <4a578dd161acf70aa33cc887493d2854547c0a2b.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
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

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 .../ABI/testing/sysfs-class-power-tcpm-source-psy  |  92 ++++++++
 drivers/usb/typec/Kconfig                          |   1 +
 drivers/usb/typec/fusb302/Kconfig                  |   2 +-
 drivers/usb/typec/fusb302/fusb302.c                |  63 +-----
 drivers/usb/typec/tcpm.c                           | 235 ++++++++++++++++++++-
 5 files changed, 330 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy

diff --git a/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
new file mode 100644
index 0000000..4986cba
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-tcpm-source-psy
@@ -0,0 +1,92 @@
+What: 		/sys/class/power_supply/tcpm-source-psy/type
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-only property describes the main type of source supply.
+	Type-C is a USB standard so this property always returns "USB".
+
+What: 		/sys/class/power_supply/tcpm-source-psy/connected_type
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-only property describes the type of source supply that is
+	connected, if the supply is online. The value is always Type C
+	unless a source has been attached which is identified as USB-PD capable.
+
+	Valid values:
+		- "USB_TYPE_C"	: Type C connected supply, not UBS-PD capable
+				  (default value)
+		- "USB_PD"	: USB-PD capable source supply connected
+		- "USB_PD_PPS"	: USB-PD PPS capable source supply connected
+
+What: 		/sys/class/power_supply/tcpm-source-psy/online
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-write property describes the online state of the source
+	supply. When the value of this property is not 0, and the supply allows
+	it, then it's possible to switch between online states (i.e. 1 -> 2,
+	2 -> 1)
+
+	Valid values:
+		- 0	: Offline, no source supply attached
+		- 1	: Fixed Online, Type-C or USB-PD capable supply
+			  attached, non-configurable current and voltage
+			  properties in this state.
+		- 2	: PPS Online, USB-PD PPS feature enabled, 'current_now'
+			  and 'voltage_now' properties can be modified in this
+			  state. Re-writing of this value again, once already
+			  set, will re-request the same configured voltage and
+			  current values. This can be used as a keep-alive for
+			  the PPS connection.
+			  [NOTE: This is value only selectable if
+			   'connected_type' reports a value of "USB_PD_PPS"]
+
+What: 		/sys/class/power_supply/tcpm-source-psy/voltage_min
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-only property describes the minimum voltage the source supply
+	can provide.
+
+	Value in microvolts.
+
+What: 		/sys/class/power_supply/tcpm-source-psy/voltage_max
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-only property describes the maximum voltage the source supply
+	can provide.
+
+	Value in microvolts.
+
+What: 		/sys/class/power_supply/tcpm-source-psy/voltage_now
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-write property describes the voltage the source supply is
+	providing now. This property can only be written to if the source supply
+	is in online state '2' (PPS enabled), otherwise it's read-only
+	information.
+
+	Value in microvolts.
+
+What: 		/sys/class/power_supply/tcpm-source-psy/current_max
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-only property describes the maximum current the source supply
+	can provide.
+
+	Value in microamps.
+
+What: 		/sys/class/power_supply/tcpm-source-psy/current_now
+Date:		December 2017
+Contact:	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+Description:
+	This read-write property describes the current the source supply can
+	provide now. This property can only be written to if the source supply
+	is in online state '2' (PPS enabled), otherwise it's read-only
+	information.
+
+	Value in microamps.
diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index bcb2744..1ef606d 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -48,6 +48,7 @@ if TYPEC
 config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
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
index 9ce4756..82fddc7 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -18,7 +18,6 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/power_supply.h>
 #include <linux/proc_fs.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched/clock.h>
@@ -99,11 +98,6 @@ struct fusb302_chip {
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
@@ -872,13 +866,11 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
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
@@ -894,11 +886,6 @@ static int tcpm_set_current_limit(struct tcpc_dev *dev, u32 max_ma, u32 mv)
 	fusb302_log(chip, "current limit: %d ma, %d mv (not implemented)",
 		    max_ma, mv);
 
-	chip->supply_voltage = mv;
-	chip->current_limit = max_ma;
-
-	power_supply_changed(chip->psy);
-
 	return 0;
 }
 
@@ -1697,43 +1684,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
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
@@ -1773,7 +1723,6 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
-	struct power_supply_config cfg = {};
 	const char *name;
 	int ret = 0;
 	u32 v;
@@ -1820,14 +1769,6 @@ static int fusb302_probe(struct i2c_client *client,
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
index b66d26c..f2bac3d 100644
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
@@ -281,6 +282,11 @@ struct tcpm_port {
 	u32 current_limit;
 	u32 supply_voltage;
 
+	/* Used to export TA voltage and current */
+	struct power_supply *psy;
+	struct power_supply_desc psy_desc;
+	enum power_supply_conn_type connected_type;
+
 	u32 bist_request;
 
 	/* PD state for Vendor Defined Messages */
@@ -1893,6 +1899,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 	int ret = -EINVAL;
 
 	port->pps_data.supported = false;
+	port->connected_type = POWER_SUPPLY_CONN_TYPE_USB_PD;
 
 	/*
 	 * Select the source PDO providing the most power which has a
@@ -1974,8 +1981,11 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 			}
 			break;
 		case PDO_TYPE_APDO:
-			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
 				port->pps_data.supported = true;
+				port->connected_type =
+					POWER_SUPPLY_CONN_TYPE_USB_PD_PPS;
+			}
 			continue;
 		default:
 			tcpm_log(port, "Invalid PDO type, ignoring");
@@ -2459,6 +2469,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	port->try_snk_count = 0;
 	port->supply_voltage = 0;
 	port->current_limit = 0;
+	port->connected_type = POWER_SUPPLY_CONN_TYPE_USB_TYPE_C;
+
+	power_supply_changed(port->psy);
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2991,6 +3004,8 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_pps_complete(port, port->pps_status);
 
+		power_supply_changed(port->psy);
+
 		break;
 
 	/* Accessory states */
@@ -4170,6 +4185,220 @@ static int nr_type_pdos(const u32 *pdo, unsigned int nr_pdo,
 	return count;
 }
 
+/* Power Supply access to expose source power information */
+enum tcpm_psy_online_states {
+	TCPM_PSY_OFFLINE = 0,
+	TCPM_PSY_FIXED_ONLINE,
+	TCPM_PSY_PROG_ONLINE,
+};
+
+static enum power_supply_property tcpm_psy_props[] = {
+	POWER_SUPPLY_PROP_CONNECTED_TYPE,
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
+	val->intval = port->supply_voltage * 1000;
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
+	val->intval = port->current_limit * 1000;
+
+	return 0;
+}
+
+static int tcpm_psy_get_prop(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct tcpm_port *port = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONNECTED_TYPE:
+		val->intval = port->connected_type;
+		break;
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
+static enum power_supply_conn_type tcpm_psy_conn_types[] = {
+	POWER_SUPPLY_CONN_TYPE_USB_TYPE_C,
+	POWER_SUPPLY_CONN_TYPE_USB_PD,
+	POWER_SUPPLY_CONN_TYPE_USB_PD_PPS,
+};
+
+int devm_tcpm_psy_register(struct tcpm_port *port)
+{
+	struct power_supply_config psy_cfg = {};
+
+	psy_cfg.drv_data = port;
+	port->psy_desc.name = "tcpm-source-psy",
+	port->psy_desc.type = POWER_SUPPLY_TYPE_USB,
+	port->psy_desc.conn_types = tcpm_psy_conn_types;
+	port->psy_desc.num_conn_types = ARRAY_SIZE(tcpm_psy_conn_types);
+	port->psy_desc.properties = tcpm_psy_props,
+	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props),
+	port->psy_desc.get_property = tcpm_psy_get_prop,
+	port->psy_desc.set_property = tcpm_psy_set_prop,
+	port->psy_desc.property_is_writeable = tcpm_psy_prop_writeable,
+
+	port->connected_type = POWER_SUPPLY_CONN_TYPE_USB_TYPE_C;
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
@@ -4253,6 +4482,10 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
