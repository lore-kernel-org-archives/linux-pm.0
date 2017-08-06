From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 17/18] platform/x86: intel_cht_int33fe Update fusb302 type string, add properties
Date: Sun,  6 Aug 2017 14:35:54 +0200
Message-ID: <20170806123555.5124-18-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
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

Unfortunately the entire INT33FE device is undocumented, so there is no
other way to ensure doing 12V charging is safe.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig             |  6 ++++-
 drivers/platform/x86/intel_cht_int33fe.c | 39 ++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index ef738602f897..2e412a3dacb1 100644
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
index da706e2c4232..69f8ab0d8d55 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,9 +24,11 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define EXPECTED_PTYPE		4
+#define BQ24292I_REGULATOR	"regulator-bq24190-usb-vbus"
 
 struct cht_int33fe_data {
 	struct i2c_client *max17047;
@@ -41,14 +43,24 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static const struct property_entry fusb302_props[] = {
+	PROPERTY_ENTRY_STRING("fcs,extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_STRING("fcs,vbus-regulator-name", BQ24292I_REGULATOR),
+	PROPERTY_ENTRY_U32("fcs,max-snk-mv", 12000),
+	PROPERTY_ENTRY_U32("fcs,max-snk-ma", 3000),
+	PROPERTY_ENTRY_U32("fcs,max-snk-mw", 36000),
+	{ }
+};
+
 static int cht_int33fe_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
+	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
-	int fusb302_irq;
+	int ret, fusb302_irq;
 
 	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
 	if (ACPI_FAILURE(status)) {
@@ -63,6 +75,28 @@ static int cht_int33fe_probe(struct i2c_client *client)
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
+	 * We expect the Whiskey Cove PMIC to be paired with a TI bq24292i
+	 * charger-IC, allowing charging with up to 12V, so we set the fusb302
+	 * "fcs,max-snk-mv" device property to 12000 mV. Allowing 12V with
+	 * another charger-IC is not a good idea, so we get the bq24292i vbus
+	 * regulator here, to ensure that things are as expected.
+	 * Use regulator_get_optional so that we don't get a dummy-regulator.
+	 */
+	regulator = regulator_get_optional(dev, BQ24292I_REGULATOR);
+	if (IS_ERR(regulator)) {
+		ret = PTR_ERR(regulator);
+		return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
+	}
+	regulator_put(regulator);
+
 	/* The FUSB302 uses the irq at index 1 and is the only irq user */
 	fusb302_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
 	if (fusb302_irq < 0) {
@@ -84,7 +118,8 @@ static int cht_int33fe_probe(struct i2c_client *client)
 		return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
 
 	memset(&board_info, 0, sizeof(board_info));
-	strlcpy(board_info.type, "fusb302", I2C_NAME_SIZE);
+	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
+	board_info.properties = fusb302_props;
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
-- 
2.13.3
