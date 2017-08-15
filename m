From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 13/14] i2c-cht-wc: Add device-properties for fusb302 integration
Date: Tue, 15 Aug 2017 22:05:01 +0200
Message-ID: <20170815200502.17339-14-hdegoede@redhat.com>
References: <20170815200502.17339-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815200502.17339-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Add device-properties to make the bq24292i charger connected to
the bus get its input-current-limit from the fusb302 Type-C port
controller which is used on boards with the cht-wc PMIC,
as well as regulator_init_data for the 5V boost converter on
the bq24292i.

Since this means we now hook-up the bq24292i to the fusb302 Type-C port
controller add a check for the ACPI device which instantiates the fusb302.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Set board_info.dev_name
-Define and pass regulator_init_data for the bq24292i
-Add a check for the ACPI device which instantiates the fusb302
---
 drivers/i2c/busses/Kconfig      |  5 ++++
 drivers/i2c/busses/i2c-cht-wc.c | 52 +++++++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 79c3381..272ef10 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -197,6 +197,11 @@ config I2C_CHT_WC
 	  SMBus controller found in the Intel Cherry Trail Whiskey Cove PMIC
 	  found on some Intel Cherry Trail systems.
 
+	  Note this controller is hooked up to a TI bq24292i charger-IC,
+	  combined with a FUSB302 Type-C port-controller as such it is advised
+	  to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
+	  (the fusb302 driver currently is in drivers/staging).
+
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
 	depends on PCI
diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 21312ee..d1f3ec4 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -25,6 +26,7 @@
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/power/bq24190_charger.h>
 #include <linux/slab.h>
 
 #define CHT_WC_I2C_CTRL			0x5e24
@@ -232,13 +234,36 @@ static const struct irq_chip cht_wc_i2c_irq_chip = {
 	.name			= "cht_wc_ext_chrg_irq_chip",
 };
 
+static const char * const bq24190_suppliers[] = { "fusb302-typec-source" };
+
 static const struct property_entry bq24190_props[] = {
-	PROPERTY_ENTRY_STRING("extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq24190_suppliers),
+	PROPERTY_ENTRY_BOOL("input-current-limit-from-supplier"),
 	PROPERTY_ENTRY_BOOL("omit-battery-class"),
 	PROPERTY_ENTRY_BOOL("disable-reset"),
 	{ }
 };
 
+static struct regulator_consumer_supply fusb302_consumer = {
+	.supply = "vbus",
+	/* Must match fusb302 dev_name in intel_cht_int33fe.c */
+	.dev_name = "i2c-fusb302",
+};
+
+static const struct regulator_init_data bq24190_vbus_init_data = {
+	.constraints = {
+		/* The name is used in intel_cht_int33fe.c do not change. */
+		.name = "cht_wc_usb_typec_vbus",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.consumer_supplies = &fusb302_consumer,
+	.num_consumer_supplies = 1,
+};
+
+static struct bq24190_platform_data bq24190_pdata = {
+	.regulator_init_data = &bq24190_vbus_init_data,
+};
+
 static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
@@ -246,7 +271,9 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 	struct i2c_board_info board_info = {
 		.type = "bq24190",
 		.addr = 0x6b,
+		.dev_name = "bq24190",
 		.properties = bq24190_props,
+		.platform_data = &bq24190_pdata,
 	};
 	int ret, reg, irq;
 
@@ -314,11 +341,21 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_irq_domain;
 
-	board_info.irq = adap->client_irq;
-	adap->client = i2c_new_device(&adap->adapter, &board_info);
-	if (!adap->client) {
-		ret = -ENOMEM;
-		goto del_adapter;
+	/*
+	 * Normally the Whiskey Cove PMIC is paired with a TI bq24292i charger,
+	 * connected to this i2c bus, and a max17047 fuel-gauge and a fusb302
+	 * USB Type-C controller connected to another i2c bus. In this setup
+	 * the max17047 and fusb302 devices are enumerated through an INT33FE
+	 * ACPI device. If this device is present register an i2c-client for
+	 * the TI bq24292i charger.
+	 */
+	if (acpi_dev_present("INT33FE", NULL, -1)) {
+		board_info.irq = adap->client_irq;
+		adap->client = i2c_new_device(&adap->adapter, &board_info);
+		if (!adap->client) {
+			ret = -ENOMEM;
+			goto del_adapter;
+		}
 	}
 
 	platform_set_drvdata(pdev, adap);
@@ -335,7 +372,8 @@ static int cht_wc_i2c_adap_i2c_remove(struct platform_device *pdev)
 {
 	struct cht_wc_i2c_adap *adap = platform_get_drvdata(pdev);
 
-	i2c_unregister_device(adap->client);
+	if (adap->client)
+		i2c_unregister_device(adap->client);
 	i2c_del_adapter(&adap->adapter);
 	irq_domain_remove(adap->irq_domain);
 
-- 
2.9.4
