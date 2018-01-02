From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 5/7] power: supply: Add 'connected_type' property and
 supporting code
Date: Tue, 2 Jan 2018 15:50:53 +0000
Message-ID: <3af7db87e0e6bdfa46ef3c1c9053297f711aee5a.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds the 'connected_type' property to represent supplies
which can report a number of different types of supply based on a
connection event.

Examples of this already exist in drivers whereby the existing 'type'
property is updated, based on an event, to represent what was
connected (e.g. USB_DCP, USB_ACA, ...). Current implementations
however don't show all supported connectable types, so this knowledge
has to be exlicitly known for each driver that supports this.

The 'connected_type' property is intended to fill this void and show
users all possible types supported by a driver. The property, when
read, shows all available types for the driver, and the one currently
chosen is highlighted/bracketed. It is expected that the 'type'
property would then just show the top-level type, such as 'USB', and
this would be static.

Currently the 'conn_type' enum contains all of the USB variant types
that exist for the 'type' enum at this time, and in addition has
the PPS type. In the future this can be extended further for other
types which have multiple connected types supported. The mirroring
is intentional so as to not impact existing usage of the 'type'
property.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/power/supply/power_supply_sysfs.c | 50 +++++++++++++++++++++++++++++++
 include/linux/power_supply.h              | 15 ++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5204f11..1b3b202 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -46,6 +46,11 @@
 	"USB_PD", "USB_PD_DRP", "BrickID"
 };
 
+static const char * const power_supply_conn_type_text[] = {
+	"Unknown", "USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
+	"USB_PD", "USB_PD_DRP", "USB_PD_PPS", "BrickID"
+};
+
 static const char * const power_supply_status_text[] = {
 	"Unknown", "Charging", "Discharging", "Not charging", "Full"
 };
@@ -73,6 +78,46 @@
 	"Unknown", "System", "Device"
 };
 
+static ssize_t power_supply_show_conn_type(struct device *dev,
+					   enum power_supply_conn_type *conn_types,
+					   ssize_t num_conn_types,
+					   union power_supply_propval *value,
+					   char *buf)
+{
+	enum power_supply_conn_type conn_type;
+	ssize_t count = 0;
+	bool match = false;
+	int i;
+
+	if ((!conn_types) || (num_conn_types <= 0)) {
+		dev_warn(dev, "driver has no valid connected types\n");
+		return -ENODATA;
+	}
+
+	for (i = 0; i < num_conn_types; ++i) {
+		conn_type = conn_types[i];
+
+		if (value->intval == conn_type) {
+			count += sprintf(buf + count, "[%s] ",
+					 power_supply_conn_type_text[conn_type]);
+			match = true;
+		} else {
+			count += sprintf(buf + count, "%s ",
+					 power_supply_conn_type_text[conn_type]);
+		}
+	}
+
+	if (!match) {
+		dev_warn(dev, "driver reporting unsupported connected type\n");
+		return -EINVAL;
+	}
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+
 static ssize_t power_supply_show_property(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf) {
@@ -115,6 +160,10 @@ static ssize_t power_supply_show_property(struct device *dev,
 	else if (off == POWER_SUPPLY_PROP_TYPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_type_text[value.intval]);
+	else if (off == POWER_SUPPLY_PROP_CONNECTED_TYPE)
+		return power_supply_show_conn_type(dev, psy->desc->conn_types,
+						   psy->desc->num_conn_types,
+						   &value, buf);
 	else if (off == POWER_SUPPLY_PROP_SCOPE)
 		return sprintf(buf, "%s\n",
 			       power_supply_scope_text[value.intval]);
@@ -241,6 +290,7 @@ static ssize_t power_supply_store_property(struct device *dev,
 	POWER_SUPPLY_ATTR(time_to_full_now),
 	POWER_SUPPLY_ATTR(time_to_full_avg),
 	POWER_SUPPLY_ATTR(type),
+	POWER_SUPPLY_ATTR(connected_type),
 	POWER_SUPPLY_ATTR(scope),
 	POWER_SUPPLY_ATTR(precharge_current),
 	POWER_SUPPLY_ATTR(charge_term_current),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 79e90b3..e15a629 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -145,6 +145,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
+	POWER_SUPPLY_PROP_CONNECTED_TYPE,
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
@@ -170,6 +171,18 @@ enum power_supply_type {
 	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
 };
 
+enum power_supply_conn_type {
+	POWER_SUPPLY_CONN_TYPE_UNKNOWN = 0,
+	POWER_SUPPLY_CONN_TYPE_USB_DCP,		/* Dedicated Charging Port */
+	POWER_SUPPLY_CONN_TYPE_USB_CDP,		/* Charging Downstream Port */
+	POWER_SUPPLY_CONN_TYPE_USB_ACA,		/* Accessory Charger Adapters */
+	POWER_SUPPLY_CONN_TYPE_USB_TYPE_C,	/* Type C Port */
+	POWER_SUPPLY_CONN_TYPE_USB_PD,		/* Power Delivery Port */
+	POWER_SUPPLY_CONN_TYPE_USB_PD_DRP,	/* PD Dual Role Port */
+	POWER_SUPPLY_CONN_TYPE_USB_PD_PPS,	/* PD Programmable Power Supply */
+	POWER_SUPPLY_CONN_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
+};
+
 enum power_supply_notifier_events {
 	PSY_EVENT_PROP_CHANGED,
 };
@@ -196,6 +209,8 @@ struct power_supply_config {
 struct power_supply_desc {
 	const char *name;
 	enum power_supply_type type;
+	enum power_supply_conn_type *conn_types;
+	size_t num_conn_types;
 	enum power_supply_property *properties;
 	size_t num_properties;
 
-- 
1.9.1
