From: a@samsung.com
Subject: [PATCH 2/3] power: max17042_battery: Add support for max77693/843 chip
Date: Tue, 31 Mar 2015 22:35:11 +0900
Message-ID: <1427808912-19562-1-git-send-email-a@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:38374 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbbCaNfO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 09:35:14 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NM200D12WEP6750@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 31 Mar 2015 22:35:13 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Beomho Seo <beomho.seo@samsung.com>, Sebastian Reichel <sre@kernel.org>

From: Beomho Seo <beomho.seo@samsung.com>

Max77693/843 fuelgauge is similar to max17042 fuelgauge. This patch add
supports max77693/843 fuelgague use max17042_battery.c fuel gauge driver.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/power/Kconfig                  |    6 +++---
 drivers/power/max17042_battery.c       |    8 ++++++++
 include/linux/power/max17042_battery.h |    2 ++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 4091fb0..887f28e 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -222,7 +222,7 @@ config BATTERY_MAX17040
 	  to operate with a single lithium cell
 
 config BATTERY_MAX17042
-	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
+	tristate "Maxim MAX17042/17047/17050/77693/77843/8997/8966 Fuel Gauge"
 	depends on I2C
 	select REGMAP_I2C
 	help
@@ -230,8 +230,8 @@ config BATTERY_MAX17042
 	  in handheld and portable equipment. The MAX17042 is configured
 	  to operate with a single lithium cell. MAX8997 and MAX8966 are
 	  multi-function devices that include fuel gauages that are compatible
-	  with MAX17042. This driver also supports max17047/50 chips which are
-	  improved version of max17042.
+	  with MAX17042. This driver also supports max17047/50 and max77693/843
+	  chips which are improved version of max17042.
 
 config BATTERY_Z2
 	tristate "Z2 battery driver"
diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index 1db87fd..806ac2e 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -627,6 +627,8 @@ static int max17042_get_reg_type(struct max17042_chip *chip)
 
 	switch (chip->chip_type) {
 	case MAXIM_DEVICE_TYPE_MAX17042:
+	case MAXIM_DEVICE_TYPE_MAX77693:
+	case MAXIM_DEVICE_TYPE_MAX77843:
 		reg_type = MAXIM_REG_TYPE_MAX17042;
 		break;
 	case MAXIM_DEVICE_TYPE_MAX17047:
@@ -837,6 +839,9 @@ static const struct of_device_id max17042_dt_match[] = {
 	{ .compatible = "maxim,max17042" },
 	{ .compatible = "maxim,max17047" },
 	{ .compatible = "maxim,max17050" },
+	{ .compatible = "maxim,max77693" },
+	{ .compatible = "maxim,max77843" },
+
 	{ },
 };
 MODULE_DEVICE_TABLE(of, max17042_dt_match);
@@ -846,6 +851,9 @@ static const struct i2c_device_id max17042_id[] = {
 	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
 	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
 	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
+	{ "max77693", MAXIM_DEVICE_TYPE_MAX77693 },
+	{ "max77843", MAXIM_DEVICE_TYPE_MAX77843 },
+
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 8dd7b70..72de625 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -131,6 +131,8 @@ enum max170xx_chip_type {
 	MAXIM_DEVICE_TYPE_MAX17042,
 	MAXIM_DEVICE_TYPE_MAX17047,
 	MAXIM_DEVICE_TYPE_MAX17050,
+	MAXIM_DEVICE_TYPE_MAX77693,
+	MAXIM_DEVICE_TYPE_MAX77843,
 
 	MAXIM_DEVICE_TYPE_NUM
 };
-- 
1.7.9.5

