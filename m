From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 11/11] platform/x86: intel_cht_int33fe: Update fusb302 type string, add properties
Date: Wed, 30 Aug 2017 11:48:14 +0200
Message-ID: <20170830094814.17758-12-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

The fusb302 driver as merged in staging uses "typec_fusb302" as i2c-id
rather then just "fusb302" and needs us to set a number of device-
properties, adjust the intel_cht_int33fe driver accordingly.

One of the properties set is max-snk-mv which makes the fusb302 driver
negotiate up to 12V charging voltage, which is a bad idea on boards
which are not setup to handle this, so this commit also adds 2 extra
sanity checks to make sure that the expected Whiskey Cove PMIC +
TI bq24292i charger combo, which can handle 12V, is present.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Set board_info.dev_name
-Adjust for changes in other patches in this patch-set
---
 drivers/platform/x86/Kconfig             |  6 ++++-
 drivers/platform/x86/intel_cht_int33fe.c | 44 +++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 80b87954f6dd..c5554577681a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -793,7 +793,7 @@ config ACPI_CMPC
 
 config INTEL_CHT_INT33FE
 	tristate "Intel Cherry Trail ACPI INT33FE Driver"
-	depends on X86 && ACPI && I2C
+	depends on X86 && ACPI && I2C && REGULATOR
 	---help---
 	  This driver add support for the INT33FE ACPI device found on
 	  some Intel Cherry Trail devices.
@@ -804,6 +804,10 @@ config INTEL_CHT_INT33FE
 	  This driver instantiates i2c-clients for these, so that standard
 	  i2c drivers for these chips can bind to the them.
 
+	  If you enable this driver it is advised to also select
+	  CONFIG_CHARGER_BQ24190=m, CONFIG_BATTERY_MAX17042=m and
+	  CONFIG_TYPEC_FUSB302=m (currently in drivers/staging).
+
 config INTEL_INT0002_VGPIO
 	tristate "Intel ACPI INT0002 Virtual GPIO driver"
 	depends on GPIOLIB && ACPI
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 5f1924fb3190..24a1662be81d 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define EXPECTED_PTYPE		4
@@ -70,12 +71,21 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static const struct property_entry fusb302_props[] = {
+	PROPERTY_ENTRY_STRING("fcs,extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
+	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
+	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
+	{ }
+};
+
 static int cht_int33fe_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
 	struct i2c_client *max17047;
+	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
 	int ret, fusb302_irq;
@@ -93,6 +103,34 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	if (ptyp != EXPECTED_PTYPE)
 		return -ENODEV;
 
+	/* Check presence of INT34D3 (hardware-rev 3) expected for ptype == 4 */
+	if (!acpi_dev_present("INT34D3", "1", 3)) {
+		dev_err(dev, "Error PTYPE == %d, but no INT34D3 device\n",
+			EXPECTED_PTYPE);
+		return -ENODEV;
+	}
+
+	/*
+	 * We expect the WC PMIC to be paired with a TI bq24292i charger-IC.
+	 * We check for the bq24292i vbus regulator here, this has 2 purposes:
+	 * 1) The bq24292i allows charging with up to 12V, setting the fusb302's
+	 *    max-snk voltage to 12V with another charger-IC is not good.
+	 * 2) For the fusb302 driver to get the bq24292i vbus regulator, the
+	 *    regulator-map, which is part of the bq24292i regulator_init_data,
+	 *    must be registered before the fusb302 is instantiated, otherwise
+	 *    it will end up with a dummy-regulator.
+	 * Note "cht_wc_usb_typec_vbus" comes from the regulator_init_data
+	 * which is defined in i2c-cht-wc.c from where the bq24292i i2c-client
+	 * gets instantiated. We use regulator_get_optional here so that we
+	 * don't end up getting a dummy-regulator ourselves.
+	 */
+	regulator = regulator_get_optional(dev, "cht_wc_usb_typec_vbus");
+	if (IS_ERR(regulator)) {
+		ret = PTR_ERR(regulator);
+		return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
+	}
+	regulator_put(regulator);
+
 	/* The FUSB302 uses the irq at index 1 and is the only irq user */
 	fusb302_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
 	if (fusb302_irq < 0) {
@@ -119,6 +157,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	} else {
 		memset(&board_info, 0, sizeof(board_info));
 		strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+		board_info.dev_name = "max17047";
 		board_info.properties = max17047_props;
 		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
 		if (!data->max17047)
@@ -126,7 +165,9 @@ static int cht_int33fe_probe(struct i2c_client *client)
 	}
 
 	memset(&board_info, 0, sizeof(board_info));
-	strlcpy(board_info.type, "fusb302", I2C_NAME_SIZE);
+	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
+	board_info.dev_name = "fusb302";
+	board_info.properties = fusb302_props;
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -134,6 +175,7 @@ static int cht_int33fe_probe(struct i2c_client *client)
 		goto out_unregister_max17047;
 
 	memset(&board_info, 0, sizeof(board_info));
+	board_info.dev_name = "pi3usb30532";
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
-- 
2.13.4
