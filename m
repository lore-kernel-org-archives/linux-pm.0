From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 2/3] power: ds2781_battery: clean up eeprom read/write functions
Date: Mon, 27 Jul 2015 00:26:48 +0300
Message-ID: <1437946009-6743-3-git-send-email-vz@mleia.com>
References: <1437946009-6743-1-git-send-email-vz@mleia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:55738 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbbGZVgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jul 2015 17:36:01 -0400
In-Reply-To: <1437946009-6743-1-git-send-email-vz@mleia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The change removes redundant calculation of left space on eeprom while
reading or writing "param_eeprom" or "user_eeprom", the checks are not
needed, since this task is done on caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/power/ds2781_battery.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/power/ds2781_battery.c b/drivers/power/ds2781_battery.c
index 56d583d..c368002 100644
--- a/drivers/power/ds2781_battery.c
+++ b/drivers/power/ds2781_battery.c
@@ -639,8 +639,6 @@ static ssize_t ds2781_read_param_eeprom_bin(struct file *filp,
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 
-	count = min_t(loff_t, count, DS2781_PARAM_EEPROM_SIZE - off);
-
 	return ds2781_read_block(dev_info, buf,
 				DS2781_EEPROM_BLOCK1_START + off, count);
 }
@@ -655,8 +653,6 @@ static ssize_t ds2781_write_param_eeprom_bin(struct file *filp,
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 	int ret;
 
-	count = min_t(loff_t, count, DS2781_PARAM_EEPROM_SIZE - off);
-
 	ret = ds2781_write(dev_info, buf,
 				DS2781_EEPROM_BLOCK1_START + off, count);
 	if (ret < 0)
@@ -688,8 +684,6 @@ static ssize_t ds2781_read_user_eeprom_bin(struct file *filp,
 	struct power_supply *psy = to_power_supply(dev);
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 
-	count = min_t(loff_t, count, DS2781_USER_EEPROM_SIZE - off);
-
 	return ds2781_read_block(dev_info, buf,
 				DS2781_EEPROM_BLOCK0_START + off, count);
 
@@ -705,8 +699,6 @@ static ssize_t ds2781_write_user_eeprom_bin(struct file *filp,
 	struct ds2781_device_info *dev_info = to_ds2781_device_info(psy);
 	int ret;
 
-	count = min_t(loff_t, count, DS2781_USER_EEPROM_SIZE - off);
-
 	ret = ds2781_write(dev_info, buf,
 				DS2781_EEPROM_BLOCK0_START + off, count);
 	if (ret < 0)
-- 
2.1.4

