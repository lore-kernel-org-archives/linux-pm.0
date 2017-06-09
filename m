From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] power: supply: twl4030_charger: Use sysfs_match_string() helper
Date: Fri,  9 Jun 2017 15:07:27 +0300
Message-ID: <20170609120727.21910-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4036 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751694AbdFIMHg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 08:07:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>

Use sysfs_match_string() helper instead of open coded variant.

Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/twl4030_charger.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 785a07bc4f39..2c2d1f457487 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
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
