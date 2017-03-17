From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/15] extcon: cht-wc: Add Intel Cherry Trail Whiskey Cove PMIC extcon driver
Date: Fri, 17 Mar 2017 10:55:15 +0100
Message-ID: <20170317095527.10487-4-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add a driver for charger detection / control on the Intel Cherrytrail
Whiskey Cove PMIC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/Kconfig         |   7 +
 drivers/extcon/Makefile        |   1 +
 drivers/extcon/extcon-cht-wc.c | 356 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 364 insertions(+)
 create mode 100644 drivers/extcon/extcon-cht-wc.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 96bbae5..4cace6b 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -52,6 +52,13 @@ config EXTCON_INTEL_INT3496
 	  This ACPI device is typically found on Intel Baytrail or Cherrytrail
 	  based tablets, or other Baytrail / Cherrytrail devices.
 
+config EXTCON_CHT_WC
+	tristate "Intel Cherrytrail Whiskey Cove PMIC extcon driver"
+	depends on INTEL_SOC_PMIC_CHTWC
+	help
+	  Say Y here to enable extcon support for charger detection / control
+	  on the Intel Cherrytrail Whiskey Cove PMIC.
+
 config EXTCON_MAX14577
 	tristate "Maxim MAX14577/77836 EXTCON Support"
 	depends on MFD_MAX14577
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 237ac3f..160f88b 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -7,6 +7,7 @@ extcon-core-objs		+= extcon.o devres.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
 obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
+obj-$(CONFIG_EXTCON_CHT_WC)	+= extcon-cht-wc.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
 obj-$(CONFIG_EXTCON_MAX14577)	+= extcon-max14577.o
diff --git a/drivers/extcon/extcon-cht-wc.c b/drivers/extcon/extcon-cht-wc.c
new file mode 100644
index 0000000..896eee6
--- /dev/null
+++ b/drivers/extcon/extcon-cht-wc.c
@@ -0,0 +1,356 @@
+/*
+ * Extcon charger detection driver for Intel Cherrytrail Whiskey Cove PMIC
+ * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
+ * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/extcon.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define CHT_WC_PWRSRC_IRQ		0x6e03
+#define CHT_WC_PWRSRC_IRQ_MASK		0x6e0f
+#define CHT_WC_PWRSRC_STS		0x6e1e
+#define CHT_WC_PWRSRC_VBUS		BIT(0)
+#define CHT_WC_PWRSRC_DC		BIT(1)
+#define CHT_WC_PWRSRC_BAT		BIT(2)
+#define CHT_WC_PWRSRC_ID_GND		BIT(3)
+#define CHT_WC_PWRSRC_ID_FLOAT		BIT(4)
+
+#define CHT_WC_PHYCTRL			0x5e07
+
+#define CHT_WC_CHGRCTRL0		0x5e16
+
+#define CHT_WC_CHGRCTRL0		0x5e16
+#define CHT_WC_CHGRCTRL0_CHGRRESET	BIT(0)
+#define CHT_WC_CHGRCTRL0_EMRGCHREN	BIT(1)
+#define CHT_WC_CHGRCTRL0_EXTCHRDIS	BIT(2)
+#define CHT_WC_CHGRCTRL0_SWCONTROL	BIT(3)
+#define CHT_WC_CHGRCTRL0_TTLCK_MASK	BIT(4)
+#define CHT_WC_CHGRCTRL0_CCSM_OFF_MASK	BIT(5)
+#define CHT_WC_CHGRCTRL0_DBPOFF_MASK	BIT(6)
+#define CHT_WC_CHGRCTRL0_WDT_NOKICK	BIT(7)
+
+#define CHT_WC_CHGRCTRL1		0x5e17
+
+#define CHT_WC_USBSRC			0x5e29
+#define CHT_WC_USBSRC_STS_MASK		GENMASK(1, 0)
+#define CHT_WC_USBSRC_STS_SUCCESS	2
+#define CHT_WC_USBSRC_STS_FAIL		3
+#define CHT_WC_USBSRC_TYPE_SHIFT	2
+#define CHT_WC_USBSRC_TYPE_MASK		GENMASK(5, 2)
+#define CHT_WC_USBSRC_TYPE_NONE		0
+#define CHT_WC_USBSRC_TYPE_SDP		1
+#define CHT_WC_USBSRC_TYPE_DCP		2
+#define CHT_WC_USBSRC_TYPE_CDP		3
+#define CHT_WC_USBSRC_TYPE_ACA		4
+#define CHT_WC_USBSRC_TYPE_SE1		5
+#define CHT_WC_USBSRC_TYPE_MHL		6
+#define CHT_WC_USBSRC_TYPE_FLOAT_DP_DN	7
+#define CHT_WC_USBSRC_TYPE_OTHER	8
+#define CHT_WC_USBSRC_TYPE_DCP_EXTPHY	9
+
+enum cht_wc_usb_id {
+	USB_ID_OTG,
+	USB_ID_GND,
+	USB_ID_FLOAT,
+	USB_RID_A,
+	USB_RID_B,
+	USB_RID_C,
+};
+
+/* Strings matching the cht_wc_usb_id enum labels */
+static const char * const usb_id_str[] = {
+	"otg", "gnd", "float", "rid_a", "rid_b", "rid_c" };
+
+enum cht_wc_mux_select {
+	MUX_SEL_PMIC = 0,
+	MUX_SEL_SOC,
+};
+
+static const unsigned int cht_wc_extcon_cables[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_CDP,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_NONE,
+};
+
+struct cht_wc_extcon_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct extcon_dev *edev;
+	unsigned int previous_cable;
+	int usb_id;
+};
+
+static int cht_wc_extcon_get_id(struct cht_wc_extcon_data *ext, int pwrsrc_sts)
+{
+	if (ext->usb_id)
+		return ext->usb_id;
+
+	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_GND)
+		return USB_ID_GND;
+	if (pwrsrc_sts & CHT_WC_PWRSRC_ID_FLOAT)
+		return USB_ID_FLOAT;
+
+	/*
+	 * Once we have iio support for the gpadc we should read the USBID
+	 * gpadc channel here and determine ACA role based on that.
+	 */
+	return USB_ID_FLOAT;
+}
+
+static int cht_wc_extcon_get_charger(struct cht_wc_extcon_data *ext)
+{
+	int ret, usbsrc, status, retries = 5;
+
+	do {
+		ret = regmap_read(ext->regmap, CHT_WC_USBSRC, &usbsrc);
+		if (ret) {
+			dev_err(ext->dev, "Error reading usbsrc: %d\n", ret);
+			return ret;
+		}
+		status = usbsrc & CHT_WC_USBSRC_STS_MASK;
+		if (status == CHT_WC_USBSRC_STS_SUCCESS ||
+		    status == CHT_WC_USBSRC_STS_FAIL)
+			break;
+
+		msleep(200);
+	} while (retries--);
+
+	if (status != CHT_WC_USBSRC_STS_SUCCESS) {
+		if (status == CHT_WC_USBSRC_STS_FAIL)
+			dev_warn(ext->dev, "Could not detect charger type\n");
+		else
+			dev_warn(ext->dev, "Timeout detecting charger type\n");
+		return EXTCON_CHG_USB_SDP; /* Save fallback */
+	}
+
+	ret = (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC_TYPE_SHIFT;
+	switch (ret) {
+	default:
+		dev_warn(ext->dev, "Unhandled charger type %d\n", ret);
+		/* Fall through treat as SDP */
+	case CHT_WC_USBSRC_TYPE_SDP:
+	case CHT_WC_USBSRC_TYPE_FLOAT_DP_DN:
+	case CHT_WC_USBSRC_TYPE_OTHER:
+		return EXTCON_CHG_USB_SDP;
+	case CHT_WC_USBSRC_TYPE_CDP:
+		return EXTCON_CHG_USB_CDP;
+	case CHT_WC_USBSRC_TYPE_DCP:
+	case CHT_WC_USBSRC_TYPE_DCP_EXTPHY:
+	case CHT_WC_USBSRC_TYPE_MHL: /* MHL2+ delivers upto 2A, treat as DCP */
+		return EXTCON_CHG_USB_DCP;
+	case CHT_WC_USBSRC_TYPE_ACA:
+		return EXTCON_CHG_USB_ACA;
+	}
+}
+
+static void cht_wc_extcon_set_phymux(struct cht_wc_extcon_data *ext, u8 state)
+{
+	int ret;
+
+	ret = regmap_write(ext->regmap, CHT_WC_PHYCTRL, state);
+	if (ret)
+		dev_err(ext->dev, "Error writing phyctrl: %d\n", ret);
+}
+
+static void cht_wc_extcon_det_event(struct cht_wc_extcon_data *ext)
+{
+	int ret, pwrsrc_sts, id;
+	unsigned int cable = EXTCON_NONE;
+
+	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
+	if (ret) {
+		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
+		return;
+	}
+
+	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
+	if (id == USB_ID_GND) {
+		/* The 5v boost causes a false VBUS / SDP detect, skip */
+		goto charger_det_done;
+	}
+
+	/* Plugged into a host/charger or not connected? */
+	if (!(pwrsrc_sts & CHT_WC_PWRSRC_VBUS)) {
+		/* Route D+ and D- to PMIC for future charger detection */
+		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
+		goto set_state;
+	}
+
+	ret = cht_wc_extcon_get_charger(ext);
+	if (ret >= 0)
+		cable = ret;
+
+charger_det_done:
+	/* Route D+ and D- to SoC for the host / gadget controller */
+	cht_wc_extcon_set_phymux(ext, MUX_SEL_SOC);
+
+set_state:
+	extcon_set_state_sync(ext->edev, cable, true);
+	extcon_set_state_sync(ext->edev, ext->previous_cable, false);
+	extcon_set_state_sync(ext->edev, EXTCON_USB_HOST,
+			      id == USB_ID_GND || id == USB_RID_A);
+	ext->previous_cable = cable;
+}
+
+static irqreturn_t cht_wc_extcon_isr(int irq, void *data)
+{
+	struct cht_wc_extcon_data *ext = data;
+	int ret, irqs;
+
+	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_IRQ, &irqs);
+	if (ret)
+		dev_err(ext->dev, "Error reading irqs: %d\n", ret);
+
+	cht_wc_extcon_det_event(ext);
+
+	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ, irqs);
+	if (ret)
+		dev_err(ext->dev, "Error writing irqs: %d\n", ret);
+
+	return IRQ_HANDLED;
+}
+
+/* usb_id sysfs attribute for debug / testing purposes */
+static ssize_t usb_id_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cht_wc_extcon_data *ext = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", usb_id_str[ext->usb_id]);
+}
+
+static ssize_t usb_id_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t n)
+{
+	struct cht_wc_extcon_data *ext = dev_get_drvdata(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(usb_id_str); i++) {
+		if (sysfs_streq(buf, usb_id_str[i])) {
+			dev_info(ext->dev, "New usb_id %s\n", usb_id_str[i]);
+			ext->usb_id = i;
+			cht_wc_extcon_det_event(ext);
+			return n;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static DEVICE_ATTR(usb_id, 0644, usb_id_show, usb_id_store);
+
+static int cht_wc_extcon_probe(struct platform_device *pdev)
+{
+	struct cht_wc_extcon_data *ext;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ext = devm_kzalloc(&pdev->dev, sizeof(*ext), GFP_KERNEL);
+	if (!ext)
+		return -ENOMEM;
+
+	ext->dev = &pdev->dev;
+	ext->regmap = pmic->regmap;
+	ext->previous_cable = EXTCON_NONE;
+
+	/* Initialize extcon device */
+	ext->edev = devm_extcon_dev_allocate(ext->dev, cht_wc_extcon_cables);
+	if (IS_ERR(ext->edev))
+		return PTR_ERR(ext->edev);
+
+	ret = regmap_update_bits(ext->regmap, CHT_WC_CHGRCTRL0,
+		 CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF_MASK,
+		 CHT_WC_CHGRCTRL0_SWCONTROL | CHT_WC_CHGRCTRL0_CCSM_OFF_MASK);
+	if (ret) {
+		dev_err(ext->dev, "Error enabling sw control\n");
+		return ret;
+	}
+
+	/* Register extcon device */
+	ret = devm_extcon_dev_register(ext->dev, ext->edev);
+	if (ret) {
+		dev_err(ext->dev, "Failed to register extcon device\n");
+		return ret;
+	}
+
+	/* Route D+ and D- to PMIC for initial charger detection */
+	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
+
+	/* Get initial state */
+	cht_wc_extcon_det_event(ext);
+
+	ret = devm_request_threaded_irq(ext->dev, irq, NULL, cht_wc_extcon_isr,
+					IRQF_ONESHOT, pdev->name, ext);
+	if (ret) {
+		dev_err(ext->dev, "Failed to request interrupt\n");
+		return ret;
+	}
+
+	/* Unmask irqs */
+	ret = regmap_write(ext->regmap, CHT_WC_PWRSRC_IRQ_MASK,
+			   (int)~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_ID_GND |
+				  CHT_WC_PWRSRC_ID_FLOAT));
+	if (ret) {
+		dev_err(ext->dev, "Error writing irq-mask: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, ext);
+	device_create_file(ext->dev, &dev_attr_usb_id);
+
+	return 0;
+}
+
+static int cht_wc_extcon_remove(struct platform_device *pdev)
+{
+	struct cht_wc_extcon_data *ext = platform_get_drvdata(pdev);
+
+	device_remove_file(ext->dev, &dev_attr_usb_id);
+
+	return 0;
+}
+
+static const struct platform_device_id cht_wc_extcon_table[] = {
+	{ .name = "cht_wcove_pwrsrc" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, cht_wc_extcon_table);
+
+static struct platform_driver cht_wc_extcon_driver = {
+	.probe = cht_wc_extcon_probe,
+	.remove = cht_wc_extcon_remove,
+	.id_table = cht_wc_extcon_table,
+	.driver = {
+		.name = "cht_wcove_pwrsrc",
+	},
+};
+module_platform_driver(cht_wc_extcon_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Intel Cherrytrail Whiskey Cove PMIC extcon driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
