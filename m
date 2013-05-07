From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2] thermal: cut the spaces when user sets policy
Date: Tue,  7 May 2013 17:21:00 +0300
Message-ID: <1367936460-15257-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:9671 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479Ab3EGOVI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 May 2013 10:21:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Setting policy results in invalid value error.
	% echo "step_wise" > policy
	% echo: write error: Invalid argument

Need clean up of the buffer which "echo" may add based on the arguments, before
comparing aganist list of governor names.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
In v2:
 - copy input string to a temporary buffer
 drivers/thermal/thermal_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..e256380 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
+#include <linux/string.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
 
@@ -713,10 +714,13 @@ policy_store(struct device *dev, struct device_attribute *attr,
 	int ret = -EINVAL;
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_governor *gov;
+	char *name[THERMAL_NAME_LENGTH];
+
+	snprintf(name, sizeof(name), "%s", buf);
 
 	mutex_lock(&thermal_governor_lock);
 
-	gov = __find_governor(buf);
+	gov = __find_governor(strim(name));
 	if (!gov)
 		goto exit;
 
-- 
1.8.2.rc0.22.gb3600c3

