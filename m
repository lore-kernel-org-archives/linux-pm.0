From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v3 3/6] power: bq27xxx_battery: Platform initialization must declare a device
Date: Wed, 5 Aug 2015 11:05:37 -0500
Message-ID: <1438790740-29856-4-git-send-email-afd@ti.com>
References: <1438790740-29856-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438790740-29856-1-git-send-email-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-pm@vger.kernel.org

When initialized as a platform device the initializer must now specify
a device. An empty device name is no longer valid.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27xxx_battery.c       | 9 ++++++---
 drivers/w1/slaves/w1_bq27000.c        | 1 +
 include/linux/power/bq27xxx_battery.h | 6 +++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index e72055c..0734413 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -91,8 +91,6 @@ struct bq27xxx_access_methods {
 	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
 };
 
-enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510};
-
 struct bq27xxx_reg_cache {
 	int temperature;
 	int time_to_empty;
@@ -1036,6 +1034,11 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!pdata->chip) {
+		dev_err(&pdev->dev, "no device supplied\n");
+		return -EINVAL;
+	}
+
 	di = devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
 	if (!di)
 		return -ENOMEM;
@@ -1043,7 +1046,7 @@ static int bq27xxx_battery_platform_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, di);
 
 	di->dev = &pdev->dev;
-	di->chip = BQ27000;
+	di->chip = pdata->chip;
 
 	name = pdata->name ?: dev_name(&pdev->dev);
 	di->bus.read = &bq27xxx_battery_platform_read;
diff --git a/drivers/w1/slaves/w1_bq27000.c b/drivers/w1/slaves/w1_bq27000.c
index 8480531..9f4a86b 100644
--- a/drivers/w1/slaves/w1_bq27000.c
+++ b/drivers/w1/slaves/w1_bq27000.c
@@ -42,6 +42,7 @@ static int w1_bq27000_read(struct device *dev, unsigned int reg)
 static struct bq27xxx_platform_data bq27000_battery_info = {
 	.read   = w1_bq27000_read,
 	.name   = "bq27000-battery",
+	.chip   = BQ27000,
 };
 
 static int w1_bq27000_add_slave(struct w1_slave *sl)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index e70a93a..a4efb10 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -3,7 +3,8 @@
 
 /**
  * struct bq27xxx_plaform_data - Platform data for bq27xxx devices
- * @name: Name of the battery. If NULL the driver will fallback to "bq27000".
+ * @name: Name of the battery.
+ * @chip: Chip class number of this device.
  * @read: HDQ read callback.
  *	This function should provide access to the HDQ bus the battery is
  *	connected to.
@@ -11,8 +12,11 @@
  *	register to be read. The return value should either be the content of
  *	the passed register or an error value.
  */
+enum bq27xxx_chip { BQ27000 = 1, BQ27500, BQ27425, BQ27742, BQ27510 };
+
 struct bq27xxx_platform_data {
 	const char *name;
+	enum bq27xxx_chip chip;
 	int (*read)(struct device *dev, unsigned int);
 };
 
-- 
1.9.1
