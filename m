From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] PM-QoS: simplify pm_qos_power_write()
Date: Wed, 11 Sep 2013 17:02:38 +0300
Message-ID: <1378908158-25468-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60979 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab3IKODN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Sep 2013 10:03:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Let kstrtos32_from_user() do the necessary calls and checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 kernel/power/qos.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index a394297..8dff9b4 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -558,30 +558,12 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
 			return -EFAULT;
-	} else if (count <= 11) { /* ASCII perhaps? */
-		char ascii_value[11];
-		unsigned long int ulval;
+	} else {
 		int ret;
 
-		if (copy_from_user(ascii_value, buf, count))
-			return -EFAULT;
-
-		if (count > 10) {
-			if (ascii_value[10] == '\n')
-				ascii_value[10] = '\0';
-			else
-				return -EINVAL;
-		} else {
-			ascii_value[count] = '\0';
-		}
-		ret = kstrtoul(ascii_value, 16, &ulval);
-		if (ret) {
-			pr_debug("%s, 0x%lx, 0x%x\n", ascii_value, ulval, ret);
-			return -EINVAL;
-		}
-		value = (s32)lower_32_bits(ulval);
-	} else {
-		return -EINVAL;
+		ret = kstrtos32_from_user(buf, count, 16, &value);
+		if (ret)
+			return ret;
 	}
 
 	req = filp->private_data;
-- 
1.8.4.rc3

