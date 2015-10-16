From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3] PM: check for complete cb before device lock in dpm_complete
Date: Fri, 16 Oct 2015 15:45:10 -0700
Message-ID: <6146fb8483239461040674927df2e71d4555c59e.1445035227.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1757 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbbJPWpR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 18:45:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: rjw@rjwysocki.net, todd.e.brandt@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

If a device has no pm_ops complete callback it shouldn't have
to be locked in order to skip it in the dpm_complete call. This causes
problems when a device without a complete callback has already begun
operation after its resume cb is called. It can end up holding up the
system resume as the pm subsystem tries to get a device lock just to
check for a callback that isn't there.

This is basically the original v1 patch but updated for the latest kernel.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 1710c26..9bb8ff0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -899,8 +899,6 @@ static void device_complete(struct device *dev, pm_message_t state)
 	if (dev->power.syscore)
 		return;
 
-	device_lock(dev);
-
 	if (dev->pm_domain) {
 		info = "completing power domain ";
 		callback = dev->pm_domain->ops.complete;
@@ -920,13 +918,15 @@ static void device_complete(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->complete;
 	}
 
-	if (callback) {
-		pm_dev_dbg(dev, state, info);
-		callback(dev);
-	}
+	if (!callback)
+		goto Complete;
 
+	device_lock(dev);
+	pm_dev_dbg(dev, state, info);
+	callback(dev);
 	device_unlock(dev);
 
+Complete:
 	pm_runtime_put(dev);
 }
 
-- 
2.1.4

