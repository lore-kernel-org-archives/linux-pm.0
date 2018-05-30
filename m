From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 3/3] power: supply: cros: add property to detect connected ports
Date: Tue, 29 May 2018 20:17:04 -0700
Message-ID: <20180530031704.18597-4-fparent@baylibre.com>
References: <20180530031704.18597-1-fparent@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530031704.18597-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eballetbo@gmail.com, gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-pm@vger.kernel.org

When a port is connected but acting as a source, its 'online' and
'status' properties are identical to a port that is not connected. This
makes it tedious for userspace to know for sure whether a port is
connected or not.

This commit adds a new property 'present' to reflect whether a port
is connected or not.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 808688a6586c..d44ab35670ab 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -32,6 +32,7 @@ struct port_data {
 	struct power_supply_desc psy_desc;
 	int psy_usb_type;
 	int psy_online;
+	int psy_present;
 	int psy_status;
 	int psy_current_max;
 	int psy_voltage_max_design;
@@ -54,6 +55,7 @@ struct charger_data {
 
 static enum power_supply_property cros_usbpd_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
@@ -65,6 +67,7 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
 
 static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 };
@@ -205,18 +208,22 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
 	case USB_PD_PORT_POWER_DISCONNECTED:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 0;
+		port->psy_present = 0;
 		break;
 	case USB_PD_PORT_POWER_SOURCE:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 0;
+		port->psy_present = 1;
 		break;
 	case USB_PD_PORT_POWER_SINK:
 		port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
 		port->psy_online = 1;
+		port->psy_present = 1;
 		break;
 	case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
 		port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		port->psy_online = 1;
+		port->psy_present = 1;
 		break;
 	default:
 		dev_err(dev, "Unknown role %d\n", resp.role);
@@ -362,6 +369,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 		 */
 		if (ec_device->mkbp_event_supported || port->psy_online)
 			break;
+	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_CURRENT_MAX:
 	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
@@ -380,6 +388,9 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = port->psy_online;
 		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = port->psy_present;
+		break;
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = port->psy_status;
 		break;
-- 
2.17.0
