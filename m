From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] trace_device_pm_callback coverage in dpm_prepare/dpm_complete
Date: Thu, 28 May 2015 12:55:53 -0700
Message-ID: <1432842953-2391-1-git-send-email-todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17748 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbbE1Tzz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 15:55:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rjw@rjwysocki.net, rafael.j.wysocki@intel.com
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

Moved the trace_device_pm_callback locations for dpm_prepare and dpm_complete
to encompass the attempt to capture the device mutex prior to callback. This
is needed by analyze_suspend to identify gaps in the trace output caused by
the delay in locking the mutex for a device.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/base/power/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d874ec..5528e59 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -920,9 +920,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 
 	if (callback) {
 		pm_dev_dbg(dev, state, info);
-		trace_device_pm_callback_start(dev, info, state.event);
 		callback(dev);
-		trace_device_pm_callback_end(dev, 0);
 	}
 
 	device_unlock(dev);
@@ -954,7 +952,9 @@ void dpm_complete(pm_message_t state)
 		list_move(&dev->power.entry, &list);
 		mutex_unlock(&dpm_list_mtx);
 
+		trace_device_pm_callback_start(dev, "", state.event);
 		device_complete(dev, state);
+		trace_device_pm_callback_end(dev, 0);
 
 		mutex_lock(&dpm_list_mtx);
 		put_device(dev);
@@ -1585,11 +1585,8 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->prepare;
 	}
 
-	if (callback) {
-		trace_device_pm_callback_start(dev, info, state.event);
+	if (callback)
 		ret = callback(dev);
-		trace_device_pm_callback_end(dev, ret);
-	}
 
 	device_unlock(dev);
 
@@ -1631,7 +1628,9 @@ int dpm_prepare(pm_message_t state)
 		get_device(dev);
 		mutex_unlock(&dpm_list_mtx);
 
+		trace_device_pm_callback_start(dev, "", state.event);
 		error = device_prepare(dev, state);
+		trace_device_pm_callback_end(dev, error);
 
 		mutex_lock(&dpm_list_mtx);
 		if (error) {
-- 
2.1.0

