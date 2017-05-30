From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 2/3] w1: MAX1721x Stanalone Fuel Gauge - add 1-Wire slave drivers
Date: Tue, 30 May 2017 20:57:34 +0300
Message-ID: <20170530175735.3481-3-minimumlaw@rambler.ru>
References: <20170530175735.3481-1-minimumlaw@rambler.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530175735.3481-1-minimumlaw@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
List-Id: linux-pm@vger.kernel.org

Add support for Maxim Semiconductor MAX17211/MAX17215
Standlone Fuel Gauge 1-Wire family 0x26

Signed-off-by: Alex A. Mihaylov <minimumlaw@rambler.ru>
---
 drivers/w1/slaves/Kconfig       |  12 +++++
 drivers/w1/slaves/Makefile      |   1 +
 drivers/w1/slaves/w1_max1721x.c |  73 ++++++++++++++++++++++++++++
 drivers/w1/slaves/w1_max1721x.h | 102 ++++++++++++++++++++++++++++++++++++++++
 drivers/w1/w1_family.h          |   1 +
 5 files changed, 189 insertions(+)
 create mode 100644 drivers/w1/slaves/w1_max1721x.c
 create mode 100644 drivers/w1/slaves/w1_max1721x.h

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index 0ef9f26..06a63a1 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -86,6 +86,18 @@ config W1_SLAVE_DS2433_CRC
 	  Each block has 30 bytes of data and a two byte CRC16.
 	  Full block writes are only allowed if the CRC is valid.
 
+config W1_SLAVE_MAX1721X
+	tristate "Maxim MAX17211/MAX17215 battery monitor chip"
+	help
+	  If you enable this you will have the MAX17211/MAX17215 battery
+	  monitor chip support.
+
+	  The battery monitor chip is used in many batteries/devices
+	  as the one who is responsible for charging/discharging/monitoring
+	  Li+ batteries.
+
+	  If you are unsure, say N.
+
 config W1_SLAVE_DS2760
 	tristate "Dallas 2760 battery monitor chip (HP iPAQ & others)"
 	help
diff --git a/drivers/w1/slaves/Makefile b/drivers/w1/slaves/Makefile
index b4a3589..967329a 100644
--- a/drivers/w1/slaves/Makefile
+++ b/drivers/w1/slaves/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_W1_SLAVE_DS2406)	+= w1_ds2406.o
 obj-$(CONFIG_W1_SLAVE_DS2423)	+= w1_ds2423.o
 obj-$(CONFIG_W1_SLAVE_DS2431)	+= w1_ds2431.o
 obj-$(CONFIG_W1_SLAVE_DS2433)	+= w1_ds2433.o
+obj-$(CONFIG_W1_SLAVE_MAX1721X)	+= w1_max1721x.o
 obj-$(CONFIG_W1_SLAVE_DS2760)	+= w1_ds2760.o
 obj-$(CONFIG_W1_SLAVE_DS2780)	+= w1_ds2780.o
 obj-$(CONFIG_W1_SLAVE_DS2781)	+= w1_ds2781.o
diff --git a/drivers/w1/slaves/w1_max1721x.c b/drivers/w1/slaves/w1_max1721x.c
new file mode 100644
index 0000000..017ec3e
--- /dev/null
+++ b/drivers/w1/slaves/w1_max1721x.c
@@ -0,0 +1,73 @@
+/*
+ * 1-Wire implementation for Maxim Semiconductor
+ * MAX17211/MAX17215 standalone fuel gauge chip
+ *
+ * Copyright (C) 2017 OAO Radioavionica
+ * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
+ *
+ * Use consistent with the GNU GPL is permitted,
+ * provided that this copyright notice is
+ * preserved in its entirety in all copies and derived works.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <linux/idr.h>
+#include <linux/gfp.h>
+
+#include "../w1.h"
+#include "../w1_int.h"
+#include "../w1_family.h"
+#include "w1_max1721x.h"
+
+static int w1_max17211_add_device(struct w1_slave *sl)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc("max1721x-battery", PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+	pdev->dev.parent = &sl->dev;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto pdev_add_failed;
+
+	dev_set_drvdata(&sl->dev, pdev);
+
+	return 0;
+
+pdev_add_failed:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static void w1_max17211_remove_device(struct w1_slave *sl)
+{
+	struct platform_device *pdev = dev_get_drvdata(&sl->dev);
+
+	platform_device_unregister(pdev);
+}
+
+static struct w1_family_ops w1_max17211_fops = {
+	.add_slave    = w1_max17211_add_device,
+	.remove_slave = w1_max17211_remove_device,
+};
+
+static struct w1_family w1_max17211_family = {
+	.fid = W1_FAMILY_MAX17211,
+	.fops = &w1_max17211_fops,
+};
+module_w1_family(w1_max17211_family);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
+MODULE_DESCRIPTION("1-wire Driver for MAX17211/MAX17215 battery monitor");
+MODULE_ALIAS("w1-family-" __stringify(W1_FAMILY_MAX17211));
diff --git a/drivers/w1/slaves/w1_max1721x.h b/drivers/w1/slaves/w1_max1721x.h
new file mode 100644
index 0000000..47694d9
--- /dev/null
+++ b/drivers/w1/slaves/w1_max1721x.h
@@ -0,0 +1,102 @@
+/*
+ * 1-Wire implementation for Maxim Semiconductor
+ * MAX7211/MAX17215 stanalone fuel gauge chip
+ *
+ * Copyright (C) 2017 OAO Radioavionica
+ * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
+ *
+ * Use consistent with the GNU GPL is permitted,
+ * provided that this copyright notice is
+ * preserved in its entirety in all copies and derived works.
+ *
+ */
+
+#ifndef __w1_max17211_h__
+#define __w1_max17211_h__
+
+/* Known commands to the MAX1721X chip */
+#define W1_MAX1721X_READ_DATA		0x69
+#define W1_MAX1721X_WRITE_DATA		0x6C
+
+/* Factory settings (nonvilatile registers) (W1 specific) */
+
+#define MAX1721X_REG_NRSENSE	0x1CF	/* RSense in 10^-5 Ohm */
+/* Strings */
+#define MAX1721X_REG_MFG_STR	0x1CC
+#define MAX1721X_REG_MFG_NUMB	3
+#define MAX1721X_REG_DEV_STR	0x1DB
+#define MAX1721X_REG_DEV_NUMB	5
+/* HEX Strings */
+#define MAX1721X_REG_SER_HEX	0x1D8
+
+/* MAX1721X/MAX17215 Output Registers for I2C and W1 chips */
+
+#define MAX172XX_REG_STATUS	0x000	/* status reg */
+#define MAX172XX_BAT_PRESENT	(1<<4)	/* battery connected bit */
+#define MAX172XX_REG_DEVNAME	0x021	/* chip config */
+#define MAX172XX_DEV_MASK	0x000F	/* chip type mask */
+#define MAX172X1_DEV		0x0001
+#define MAX172X5_DEV		0x0005
+#define MAX172XX_REG_TEMP	0x008	/* Temperature */
+#define MAX172XX_REG_BATT	0x0DA	/* Battery voltage */
+#define MAX172XX_REG_CURRENT	0x00A	/* Actual current */
+#define MAX172XX_REG_AVGCURRENT	0x00B	/* Average current */
+#define MAX172XX_REG_REPSOC	0x006	/* Percentage of charge */
+#define MAX172XX_REG_DESIGNCAP	0x018	/* Design capacity */
+#define MAX172XX_REG_REPCAP	0x005	/* Average capacity */
+#define MAX172XX_REG_TTE	0x011	/* Time to empty */
+#define MAX172XX_REG_TTF	0x020	/* Time to full */
+
+/* Number of valid register addresses */
+#define MAX1721X_MAX_REG_NR	0x1EF
+
+/* Convert regs value to power_supply units */
+
+static inline int max172xx_time_to_ps(unsigned int reg)
+{
+	return reg * 5625 / 1000;	/* in sec. */
+}
+
+static inline int max172xx_percent_to_ps(unsigned int reg)
+{
+	return reg / 256;	/* in percent from 0 to 100 */
+}
+
+static inline int max172xx_voltage_to_ps(unsigned int reg)
+{
+	return reg * 1250;	/* in uV */
+}
+
+static inline int max172xx_capacity_to_ps(unsigned int reg)
+{
+	return reg * 500;	/* in uAh */
+}
+
+/*
+ * Current and temperature is signed values, so unsigned regs
+ * value must be converted to signed type
+ */
+
+static inline int max172xx_temperature_to_ps(unsigned int reg)
+{
+	int val = (int16_t)(reg);
+
+	return val * 10 / 256; /* in tenths of deg. C */
+}
+
+/*
+ * Calculating current registers resolution:
+ *
+ * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
+ * in 10^-11 Volts for get current in uA.
+ * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
+ * So: 102400 / 65535 * 10^5 = 156252
+ */
+static inline int max172xx_current_to_voltage(unsigned int reg)
+{
+	int val = (int16_t)(reg);
+
+	return val * 156252;
+}
+
+#endif /* !__w1_max17211_h__ */
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
index c4a6b25..398adc9 100644
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -29,6 +29,7 @@
 #define W1_COUNTER_DS2423	0x1D
 #define W1_THERM_DS1822  	0x22
 #define W1_EEPROM_DS2433  	0x23
+#define W1_FAMILY_MAX17211	0x26
 #define W1_THERM_DS18B20 	0x28
 #define W1_FAMILY_DS2408	0x29
 #define W1_EEPROM_DS2431	0x2D
-- 
2.8.4 (Apple Git-73)
