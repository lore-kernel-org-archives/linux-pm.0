From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/15] i2c: core: Allow drivers to specify index for irq to get from of / ACPI
Date: Fri, 17 Mar 2017 10:55:25 +0100
Message-ID: <20170317095527.10487-14-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdCQJ4t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Mar 2017 05:56:49 -0400
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

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
---
 drivers/i2c/i2c-core.c | 8 ++++++--
 include/linux/i2c.h    | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fd45207..2457995 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -984,6 +984,8 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
+	driver = to_i2c_driver(dev->driver);
+
 	if (!client->irq) {
 		int irq = -ENOENT;
 
@@ -993,9 +995,11 @@ static int i2c_device_probe(struct device *dev)
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
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 369ebfa..a5ffe29 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -212,6 +212,9 @@ struct i2c_driver {
 	int (*detect)(struct i2c_client *, struct i2c_board_info *);
 	const unsigned short *address_list;
 	struct list_head clients;
+
+	/* IRQ index for retreiving irq from ACPI resources */
+	int irq_index;
 };
 #define to_i2c_driver(d) container_of(d, struct i2c_driver, driver)
 
-- 
2.9.3
