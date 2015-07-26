From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 3/3] power: olpc_battery: clean up eeprom read function
Date: Mon, 27 Jul 2015 00:26:49 +0300
Message-ID: <1437946009-6743-4-git-send-email-vz@mleia.com>
References: <1437946009-6743-1-git-send-email-vz@mleia.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from li271-223.members.linode.com ([178.79.152.223]:55744 "EHLO
	mail.mleia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbbGZVgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Jul 2015 17:36:01 -0400
In-Reply-To: <1437946009-6743-1-git-send-email-vz@mleia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The change removes redundant sysfs binary file boundary check while
reading eeprom content from userspace, the check is done on caller
side in fs/sysfs/file.c, if binary attribute size is not zero.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/power/olpc_battery.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/olpc_battery.c b/drivers/power/olpc_battery.c
index a944338..9e29b13 100644
--- a/drivers/power/olpc_battery.c
+++ b/drivers/power/olpc_battery.c
@@ -521,11 +521,6 @@ static ssize_t olpc_bat_eeprom_read(struct file *filp, struct kobject *kobj,
 	int ret;
 	int i;
 
-	if (off >= EEPROM_SIZE)
-		return 0;
-	if (off + count > EEPROM_SIZE)
-		count = EEPROM_SIZE - off;
-
 	for (i = 0; i < count; i++) {
 		ec_byte = EEPROM_START + off + i;
 		ret = olpc_ec_cmd(EC_BAT_EEPROM, &ec_byte, 1, &buf[i], 1);
@@ -545,7 +540,7 @@ static struct bin_attribute olpc_bat_eeprom = {
 		.name = "eeprom",
 		.mode = S_IRUGO,
 	},
-	.size = 0,
+	.size = EEPROM_SIZE,
 	.read = olpc_bat_eeprom_read,
 };
 
-- 
2.1.4

