From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Runtime: Update documentation around probe|remove|suspend
Date: Thu,  7 Nov 2013 10:40:00 +0100
Message-ID: <1383817200-3004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:42977 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab3KGJkG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2013 04:40:06 -0500
Received: by mail-wi0-f169.google.com with SMTP id cb5so246649wib.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2013 01:40:04 -0800 (PST)
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
 Documentation/power/runtime_pm.txt |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 0f54333..0f62cc7 100644
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
+time.  A driver which make use of the runtime autosuspend feature, may want to
+update the last busy mark before it finalilizes it's ->probe().
 
 Moreover, the driver core prevents runtime PM callbacks from racing with the bus
 notifier callback in __device_release_driver(), which is necessary, because the
@@ -632,7 +630,10 @@ The PM core always increments the runtime usage counter before calling the
 Hence disabling runtime PM temporarily like this will not cause any runtime
 suspend attempts to be permanently lost.  If the usage count goes to zero
 following the return of the ->resume() callback, the ->runtime_idle() callback
-will be invoked as usual.
+will be invoked as usual.  Do note that PM core use the asyncronous
+pm_runtime_put() when decrementing the usage counter, which means it don't wait
+for the device to become inactive before it moves on and handles the next
+device from the list.
 
 On some systems, however, system sleep is not entered through a global firmware
 or hardware operation.  Instead, all hardware components are put into low-power
@@ -656,7 +657,7 @@ out the following operations:
     __pm_runtime_disable() with 'false' as the second argument for every device
     right before executing the subsystem-level .suspend_late() callback for it.
 
-  * During system resume it calls pm_runtime_enable() and pm_runtime_put_sync()
+  * During system resume it calls pm_runtime_enable() and pm_runtime_put()
     for every device right after executing the subsystem-level .resume_early()
     callback and right after executing the subsystem-level .resume() callback
     for it, respectively.
-- 
1.7.9.5

