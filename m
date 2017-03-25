From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq to get from of / ACPI
Date: Sat, 25 Mar 2017 14:55:49 +0100
Message-ID: <20170325135550.22509-4-hdegoede@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdCYN4C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Mar 2017 09:56:02 -0400
In-Reply-To: <20170325135550.22509-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org

Some of or ACPI declared / enumerated devices may have multiple irq
resources declared and the driver may want to use a different irq then
the one with index 0.

This commit adds a new irq_index field to struct i2c_driver and makes
the i2c-core pass this to of_irq_get / acpi_dev_gpio_irq_get.

This is esp. useful for ACPI declared devices where the irq with
index 0 may be entirely useless and cause i2c_device_probe to fail with
-EPROBE_DEFER.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Actually also use the irq_index for of interrupts
Changes in v3:
-Add kernel doc for new i2c_driver irq_index member
-Remove duplicate assignment of driver in i2c_device_probe
---
 drivers/i2c/i2c-core.c | 10 ++++++----
 include/linux/i2c.h    |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 062b480..a7dfa6c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -983,6 +983,8 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
+	driver = to_i2c_driver(dev->driver);
+
 	if (!client->irq) {
 		int irq = -ENOENT;
 
@@ -992,9 +994,11 @@ static int i2c_device_probe(struct device *dev)
 		} else if (dev->of_node) {
 			irq = of_irq_get_byname(dev->of_node, "irq");
 			if (irq == -EINVAL || irq == -ENODATA)
-				irq = of_irq_get(dev->of_node, 0);
+				irq = of_irq_get(dev->of_node,
+						 driver->irq_index);
 		} else if (ACPI_COMPANION(dev)) {
-			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
+			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev),
+						    driver->irq_index);
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
@@ -1005,8 +1009,6 @@ static int i2c_device_probe(struct device *dev)
 		client->irq = irq;
 	}
 
-	driver = to_i2c_driver(dev->driver);
-
 	/*
 	 * An I2C ID table is not mandatory, if and only if, a suitable Device
 	 * Tree match table entry is supplied for the probing device.
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 369ebfa..79de1d1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -149,6 +149,7 @@ enum i2c_alert_protocol {
  * @detect: Callback for device detection
  * @address_list: The I2C addresses to probe (for detect)
  * @clients: List of detected clients we created (for i2c-core use only)
+ * @irq_index: IRQ index for retreiving irq from OF/ACPI
  *
  * The driver.owner field should be set to the module owner of this driver.
  * The driver.name field should be set to the name of this driver.
@@ -212,6 +213,9 @@ struct i2c_driver {
 	int (*detect)(struct i2c_client *, struct i2c_board_info *);
 	const unsigned short *address_list;
 	struct list_head clients;
+
+	/* IRQ index for retreiving irq from OF/ACPI */
+	int irq_index;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-- 
2.9.3
