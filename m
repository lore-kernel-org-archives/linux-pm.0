From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v4 4/4] platform/x86: Add Intel Cherry Trail ACPI INT33FE device driver
Date: Mon,  3 Apr 2017 13:09:14 +0200
Message-ID: <20170403110914.30323-4-hdegoede@redhat.com>
References: <20170403110914.30323-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170403110914.30323-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources for
3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB300C USB Type-C
Controller and PI3USB30532 USB switch.

This commit adds a driver for this ACPI device which instantiates
i2c-clients for these, so that the standard i2c drivers for these chips
can bind to the them.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-This is a new patch in v4 of this patch-set replacing the
 cht_wc_fuel_gauge driver which was binding to the INT33FE device before
 I figured out this is some sort of meta device describing 3 devices
 and that the fuel-guage really is just a Maxim MAX17047. The
 cht_wc_fuel_gauge driver will be replaced by a max17047 driver which I
 will submit seperately
---
 drivers/platform/x86/Kconfig             |  13 +++
 drivers/platform/x86/Makefile            |   1 +
 drivers/platform/x86/intel_cht_int33fe.c | 144 +++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/platform/x86/intel_cht_int33fe.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 6a5b79c..57f7c1d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -772,6 +772,19 @@ config ACPI_CMPC
 	  keys as input device, backlight device, tablet and accelerometer
 	  devices.
 
+config INTEL_CHT_INT33FE
+	tristate "Intel Cherry Trail ACPI INT33FE Driver"
+	depends on X86 && ACPI
+	---help---
+	  This driver add support for the INT33FE ACPI device found on
+	  some Intel Cherry Trail devices.
+
+	  The INT33FE ACPI device has a CRS table with I2cSerialBusV2
+	  resources for 3 devices: Maxim MAX17047 Fuel Gauge Controller,
+	  FUSB300C USB Type-C Controller and PI3USB30532 USB switch.
+	  This driver instantiates i2c-clients for these, so that standard
+	  i2c drivers for these chips can bind to the them.
+
 config INTEL_HID_EVENT
 	tristate "INTEL HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6d4b01a..6731893 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_TOSHIBA_BT_RFKILL)	+= toshiba_bluetooth.o
 obj-$(CONFIG_TOSHIBA_HAPS)	+= toshiba_haps.o
 obj-$(CONFIG_TOSHIBA_WMI)	+= toshiba-wmi.o
+obj-$(CONFIG_INTEL_CHT_INT33FE)	+= intel_cht_int33fe.o
 obj-$(CONFIG_INTEL_HID_EVENT)	+= intel-hid.o
 obj-$(CONFIG_INTEL_VBTN)	+= intel-vbtn.o
 obj-$(CONFIG_INTEL_SCU_IPC)	+= intel_scu_ipc.o
diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
new file mode 100644
index 0000000..3a06426
--- /dev/null
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -0,0 +1,144 @@
+/*
+ * Intel Cherry Trail ACPI INT33FE pseudo device driver
+ *
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Some Intel Cherry Trail based device which ship with Windows 10, have
+ * this weird INT33FE ACPI device with a CRS table with 4 I2cSerialBusV2
+ * resources, for 4 different chips attached to various i2c busses:
+ * 1. The Whiskey Cove pmic, which is also described by the INT34D3 ACPI device
+ * 2. Maxim MAX17047 Fuel Gauge Controller
+ * 3. FUSB300C USB Type-C Controller
+ * 4. PI3USB30532 USB switch
+ *
+ * So this driver is a stub / pseudo driver whose only purpose is to
+ * instantiate i2c-clients for chips 2 - 4, so that standard i2c drivers
+ * for these chips can bind to the them.
+ */
+
+#include <linux/acpi.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/power/acpi.h>
+#include <linux/slab.h>
+
+#define EXPECTED_PTYPE		4
+
+struct cht_int33fe_data {
+	struct i2c_client *max17047;
+	struct i2c_client *fusb300c;
+	struct i2c_client *pi3usb30532;
+};
+
+static int cht_int33fe_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct i2c_board_info board_info;
+	struct cht_int33fe_data *data;
+	acpi_status status;
+	unsigned long long ptyp;
+	int fusb300c_irq;
+
+	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP", NULL, &ptyp);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Error getting PTYPE\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * The same ACPI HID is used for different configurations check PTYP
+	 * to ensure that we are dealing with the expected config.
+	 */
+	if (ptyp != EXPECTED_PTYPE)
+		return -ENODEV;
+
+	/* The FUSB300C uses the irq at index 1 and is the only irq user */
+	fusb300c_irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 1);
+	if (fusb300c_irq < 0) {
+		if (fusb300c_irq != -EPROBE_DEFER)
+			dev_err(dev, "Error getting FUSB300C irq\n");
+		return fusb300c_irq;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+
+	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	if (!data->max17047)
+		return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "fusb300c", I2C_NAME_SIZE);
+	board_info.irq = fusb300c_irq;
+
+	data->fusb300c = i2c_acpi_new_device(dev, 2, &board_info);
+	if (!data->fusb300c)
+		goto out_unregister_max17047;
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
+
+	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
+	if (!data->pi3usb30532)
+		goto out_unregister_fusb300c;
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+
+out_unregister_fusb300c:
+	i2c_unregister_device(data->fusb300c);
+
+out_unregister_max17047:
+	i2c_unregister_device(data->max17047);
+
+	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+}
+
+static int cht_int33fe_remove(struct i2c_client *i2c)
+{
+	struct cht_int33fe_data *data = i2c_get_clientdata(i2c);
+
+	i2c_unregister_device(data->pi3usb30532);
+	i2c_unregister_device(data->fusb300c);
+	i2c_unregister_device(data->max17047);
+
+	return 0;
+}
+
+static const struct i2c_device_id cht_int33fe_i2c_id[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, cht_int33fe_i2c_id);
+
+static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
+	{ "INT33FE", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cht_int33fe_acpi_ids);
+
+static struct i2c_driver cht_int33fe_driver = {
+	.driver	= {
+		.name = "Intel Cherry Trail ACPI INT33FE driver",
+		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
+	},
+	.probe_new = cht_int33fe_probe,
+	.remove = cht_int33fe_remove,
+	.id_table = cht_int33fe_i2c_id,
+	.disable_i2c_core_irq_mapping = true,
+};
+
+module_i2c_driver(cht_int33fe_driver);
+
+MODULE_DESCRIPTION("Intel Cherry Trail ACPI INT33FE pseudo device driver");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
