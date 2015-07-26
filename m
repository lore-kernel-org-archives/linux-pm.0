From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 1/3] power: ds2780_battery: clean up eeprom read/write functions
Date: Mon, 27 Jul 2015 00:26:47 +0300
Message-ID: <1437946009-6743-2-git-send-email-vz@mleia.com>
References: <1437946009-6743-1-git-send-email-vz@mleia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:55739 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbbGZVgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jul 2015 17:36:01 -0400
In-Reply-To: <1437946009-6743-1-git-send-email-vz@mleia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The change removes redundant sysfs binary file boundary checks while
reading or writing "param_eeprom" or "user_eeprom", the checks are not
needed, since this task is done on caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/power/ds2780_battery.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/power/ds2780_battery.c b/drivers/power/ds2780_battery.c
index a7a0427..d3743d0 100644
--- a/drivers/power/ds2780_battery.c
+++ b/drivers/power/ds2780_battery.c
@@ -637,10 +637,6 @@ static ssize_t ds2780_read_param_eeprom_bin(struct file *filp,
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 
-	count = min_t(loff_t, count,
-		DS2780_EEPROM_BLOCK1_END -
-		DS2780_EEPROM_BLOCK1_START + 1 - off);
-
 	return ds2780_read_block(dev_info, buf,
 				DS2780_EEPROM_BLOCK1_START + off, count);
 }
@@ -655,10 +651,6 @@ static ssize_t ds2780_write_param_eeprom_bin(struct file *filp,
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 	int ret;
 
-	count = min_t(loff_t, count,
-		DS2780_EEPROM_BLOCK1_END -
-		DS2780_EEPROM_BLOCK1_START + 1 - off);
-
 	ret = ds2780_write(dev_info, buf,
 				DS2780_EEPROM_BLOCK1_START + off, count);
 	if (ret < 0)
@@ -676,7 +668,7 @@ static struct bin_attribute ds2780_param_eeprom_bin_attr = {
 		.name = "param_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
-	.size = DS2780_EEPROM_BLOCK1_END - DS2780_EEPROM_BLOCK1_START + 1,
+	.size = DS2780_PARAM_EEPROM_SIZE,
 	.read = ds2780_read_param_eeprom_bin,
 	.write = ds2780_write_param_eeprom_bin,
 };
@@ -690,10 +682,6 @@ static ssize_t ds2780_read_user_eeprom_bin(struct file *filp,
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 
-	count = min_t(loff_t, count,
-		DS2780_EEPROM_BLOCK0_END -
-		DS2780_EEPROM_BLOCK0_START + 1 - off);
-
 	return ds2780_read_block(dev_info, buf,
 				DS2780_EEPROM_BLOCK0_START + off, count);
 }
@@ -708,10 +696,6 @@ static ssize_t ds2780_write_user_eeprom_bin(struct file *filp,
 	struct ds2780_device_info *dev_info = to_ds2780_device_info(psy);
 	int ret;
 
-	count = min_t(loff_t, count,
-		DS2780_EEPROM_BLOCK0_END -
-		DS2780_EEPROM_BLOCK0_START + 1 - off);
-
 	ret = ds2780_write(dev_info, buf,
 				DS2780_EEPROM_BLOCK0_START + off, count);
 	if (ret < 0)
@@ -729,7 +713,7 @@ static struct bin_attribute ds2780_user_eeprom_bin_attr = {
 		.name = "user_eeprom",
 		.mode = S_IRUGO | S_IWUSR,
 	},
-	.size = DS2780_EEPROM_BLOCK0_END - DS2780_EEPROM_BLOCK0_START + 1,
+	.size = DS2780_USER_EEPROM_SIZE,
 	.read = ds2780_read_user_eeprom_bin,
 	.write = ds2780_write_user_eeprom_bin,
 };
-- 
2.1.4

