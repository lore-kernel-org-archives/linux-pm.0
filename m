From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] power: supply: twl4030_charger: Use sysfs_match_string() helper
Date: Sun, 11 Jun 2017 18:15:48 +0300
Message-ID: <20170611151548.7153-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53268 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbdFKPPw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 11 Jun 2017 11:15:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>

Use sysfs_match_string() helper instead of open coded variant.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 - constify array of mode names
 drivers/power/supply/twl4030_charger.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 785a07bc4f39..07c70e59f31a 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -153,7 +153,7 @@ struct twl4030_bci {
 };
 
 /* strings for 'usb_mode' values */
-static char *modes[] = { "off", "auto", "continuous" };
+static const char *modes[] = { "off", "auto", "continuous" };
 
 /*
  * clear and set bits on an given register on a given module
@@ -669,14 +669,10 @@ twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
 	int mode;
 	int status;
 
-	if (sysfs_streq(buf, modes[0]))
-		mode = 0;
-	else if (sysfs_streq(buf, modes[1]))
-		mode = 1;
-	else if (sysfs_streq(buf, modes[2]))
-		mode = 2;
-	else
-		return -EINVAL;
+	mode = sysfs_match_string(modes, buf);
+	if (mode < 0)
+		return mode;
+
 	if (dev == &bci->ac->dev) {
 		if (mode == 2)
 			return -EINVAL;
-- 
2.11.0
