From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] thermal: cut the spaces when user sets policy
Date: Fri,  3 May 2013 16:52:08 +0300
Message-ID: <1367589128-19787-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27868 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762313Ab3ECNwO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 09:52:14 -0400
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
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d755440..a637be5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/thermal.h>
 #include <linux/reboot.h>
+#include <linux/string.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
 
@@ -716,7 +717,7 @@ policy_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&thermal_governor_lock);
 
-	gov = __find_governor(buf);
+	gov = __find_governor(strim(buf));
 	if (!gov)
 		goto exit;
 
-- 
1.8.2.rc0.22.gb3600c3

