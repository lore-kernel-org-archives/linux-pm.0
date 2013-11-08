From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2] PM / Runtime: Update documentation around probe|remove|suspend
Date: Fri,  8 Nov 2013 06:13:51 +0100
Message-ID: <1383887631-2703-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:64655 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab3KHFN6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2013 00:13:58 -0500
Received: by mail-la0-f53.google.com with SMTP id eh20so1335726lab.40
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2013 21:13:56 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

PM core and driver core has changed some behavior regarding use of
runtime PM. Update the documentation accordingly.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/runtime_pm.txt |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 0f54333..b6ce00b 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -547,13 +547,11 @@ helper functions described in Section 4.  In that case, pm_runtime_resume()
 should be used.  Of course, for this purpose the device's runtime PM has to be
 enabled earlier by calling pm_runtime_enable().
 
-If the device bus type's or driver's ->probe() callback runs
-pm_runtime_suspend() or pm_runtime_idle() or their asynchronous counterparts,
-they will fail returning -EAGAIN, because the device's usage counter is
-incremented by the driver core before executing ->probe().  Still, it may be
-desirable to suspend the device as soon as ->probe() has finished, so the driver
-core uses pm_runtime_put_sync() to invoke the subsystem-level idle callback for
-the device at that time.
+It may be desirable to suspend the device once ->probe() has finished.
+Therefore the driver core uses the asyncronous pm_request_idle() to submit a
+request to execute the subsystem-level idle callback for the device at that
+time.  A driver that makes use of the runtime autosuspend feature, may want to
+update the last busy mark before returning from ->probe().
 
 Moreover, the driver core prevents runtime PM callbacks from racing with the bus
 notifier callback in __device_release_driver(), which is necessary, because the
@@ -656,7 +654,7 @@ out the following operations:
     __pm_runtime_disable() with 'false' as the second argument for every device
     right before executing the subsystem-level .suspend_late() callback for it.
 
-  * During system resume it calls pm_runtime_enable() and pm_runtime_put_sync()
+  * During system resume it calls pm_runtime_enable() and pm_runtime_put()
     for every device right after executing the subsystem-level .resume_early()
     callback and right after executing the subsystem-level .resume() callback
     for it, respectively.
-- 
1.7.9.5

