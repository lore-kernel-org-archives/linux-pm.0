From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/14] staging: typec: fusb302: Add support for USB2 charger detection through extcon
Date: Tue, 15 Aug 2017 22:04:54 +0200
Message-ID: <20170815200502.17339-7-hdegoede@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815200502.17339-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, "Yueyao (Nathan) Zhu" <yueyao@google.com>
List-Id: linux-pm@vger.kernel.org

The fusb302 port-controller relies on an external device doing USB2
charger-type detection.

The Intel Whiskey Cove PMIC with which the fusb302 is combined on some
X86/ACPI platforms already has a charger-type detection driver which
uses extcon to communicate the detected charger-type.

This commit uses the tcpm_get_usb2_current_limit_extcon helper to enable
USB2 charger detection on these systems. Note that the "fcs,extcon-name"
property name is only for kernel internal use by X86/ACPI platform code
and as such is NOT documented in the devicetree bindings.

Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 49 +++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index dea88fd..870f8078 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/extcon.h>
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -96,6 +97,7 @@ struct fusb302_chip {
 
 	int gpio_int_n;
 	int gpio_int_n_irq;
+	struct extcon_dev *extcon;
 
 	struct workqueue_struct *wq;
 	struct delayed_work bc_lvl_handler;
@@ -516,6 +518,38 @@ static int tcpm_get_vbus(struct tcpc_dev *dev)
 	return ret;
 }
 
+static int tcpm_get_current_limit(struct tcpc_dev *dev)
+{
+	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
+						 tcpc_dev);
+	int current_limit = 0;
+	unsigned long timeout;
+
+	if (!chip->extcon)
+		return 0;
+
+	/*
+	 * USB2 Charger detection may still be in progress when we get here,
+	 * this can take upto 600ms, wait 800ms max.
+	 */
+	timeout = jiffies + msecs_to_jiffies(800);
+	do {
+		if (extcon_get_state(chip->extcon, EXTCON_CHG_USB_SDP) == 1)
+			current_limit = 500;
+
+		if (extcon_get_state(chip->extcon, EXTCON_CHG_USB_CDP) == 1 ||
+		    extcon_get_state(chip->extcon, EXTCON_CHG_USB_ACA) == 1)
+			current_limit = 1500;
+
+		if (extcon_get_state(chip->extcon, EXTCON_CHG_USB_DCP) == 1)
+			current_limit = 2000;
+
+		msleep(50);
+	} while (current_limit == 0 && time_before(jiffies, timeout));
+
+	return current_limit;
+}
+
 static int fusb302_set_cc_pull(struct fusb302_chip *chip,
 			       bool pull_up, bool pull_down)
 {
@@ -1201,6 +1235,7 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 {
 	fusb302_tcpc_dev->init = tcpm_init;
 	fusb302_tcpc_dev->get_vbus = tcpm_get_vbus;
+	fusb302_tcpc_dev->get_current_limit = tcpm_get_current_limit;
 	fusb302_tcpc_dev->set_cc = tcpm_set_cc;
 	fusb302_tcpc_dev->get_cc = tcpm_get_cc;
 	fusb302_tcpc_dev->set_polarity = tcpm_set_polarity;
@@ -1685,6 +1720,7 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
 	struct device *dev = &client->dev;
+	const char *name;
 	int ret = 0;
 	u32 val;
 
@@ -1717,6 +1753,19 @@ static int fusb302_probe(struct i2c_client *client,
 	if (!device_property_read_u32(dev, "fcs,operating-snk-microwatt", &val))
 		chip->tcpc_config.operating_snk_mw = val / 1000;
 
+	/*
+	 * Devicetree platforms should get extcon via phandle (not yet
+	 * supported). On ACPI platforms, we get the name from a device prop.
+	 * This device prop is for kernel internal use only and is expected
+	 * to be set by the platform code which also registers the i2c client
+	 * for the fusb302.
+	 */
+	if (device_property_read_string(dev, "fcs,extcon-name", &name) == 0) {
+		chip->extcon = extcon_get_extcon_dev(name);
+		if (!chip->extcon)
+			return -EPROBE_DEFER;
+	}
+
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
-- 
2.9.4
