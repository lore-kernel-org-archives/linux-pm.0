From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Sleep: Fall back to subsystem level PM callbacks for PM domains
Date: Fri, 25 Apr 2014 12:44:55 +0200
Message-ID: <1398422695-2295-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62697 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbaDYKpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 06:45:07 -0400
Received: by mail-lb0-f178.google.com with SMTP id s7so2986654lbd.9
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2014 03:45:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Previously once the PM core found a PM domain pointer for a device,
but which didn't have a valid PM callback, it falled back to try the
driver's PM callback.

In this scenario, change the behavior of the PM core to try out the
other subsystem level PM callbacks, before it moves on to the driver.

This gives provision for PM domains to easier re-use subsystem level
code to handle the needed operations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/power/devices.txt |    6 +++--
 drivers/base/power/main.c       |   55 +++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 47d46df..c875056 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -303,8 +303,10 @@ The PM domain, type, class and bus callbacks may in turn invoke device- or
 driver-specific methods stored in dev->driver->pm, but they don't have to do
 that.
 
-If the subsystem callback chosen for execution is not present, the PM core will
-execute the corresponding method from dev->driver->pm instead if there is one.
+If a PM domain exist, but the callback chosen for execution isn't present, the
+PM core will fall back to try the other subsystem level callbacks.  Finally, if
+no subsystem level callback is found, it executes the corresponding method from
+dev->driver->pm instead if there is one.
 
 
 Entering System Suspend
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 86d5e4f..e604db9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -490,7 +490,11 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "noirq type ";
 		callback = pm_noirq_op(dev->type->pm, state);
 	} else if (dev->class && dev->class->pm) {
@@ -506,6 +510,7 @@ static int device_resume_noirq(struct device *dev, pm_message_t state, bool asyn
 		callback = pm_noirq_op(dev->driver->pm, state);
 	}
 
+ End:
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_noirq_suspended = false;
 
@@ -616,7 +621,11 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 	if (dev->pm_domain) {
 		info = "early power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "early type ";
 		callback = pm_late_early_op(dev->type->pm, state);
 	} else if (dev->class && dev->class->pm) {
@@ -632,6 +641,7 @@ static int device_resume_early(struct device *dev, pm_message_t state, bool asyn
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+ End:
 	error = dpm_run_callback(callback, dev, state, info);
 	dev->power.is_late_suspended = false;
 
@@ -751,7 +761,8 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-		goto Driver;
+		if (callback)
+			goto End;
 	}
 
 	if (dev->type && dev->type->pm) {
@@ -889,7 +900,11 @@ static void device_complete(struct device *dev, pm_message_t state)
 	if (dev->pm_domain) {
 		info = "completing power domain ";
 		callback = dev->pm_domain->ops.complete;
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "completing type ";
 		callback = dev->type->pm->complete;
 	} else if (dev->class && dev->class->pm) {
@@ -905,6 +920,7 @@ static void device_complete(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->complete;
 	}
 
+ End:
 	if (callback) {
 		pm_dev_dbg(dev, state, info);
 		callback(dev);
@@ -1015,7 +1031,11 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "noirq type ";
 		callback = pm_noirq_op(dev->type->pm, state);
 	} else if (dev->class && dev->class->pm) {
@@ -1031,6 +1051,7 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 		callback = pm_noirq_op(dev->driver->pm, state);
 	}
 
+ End:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (!error)
 		dev->power.is_noirq_suspended = true;
@@ -1154,7 +1175,11 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "late type ";
 		callback = pm_late_early_op(dev->type->pm, state);
 	} else if (dev->class && dev->class->pm) {
@@ -1170,6 +1195,7 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 		callback = pm_late_early_op(dev->driver->pm, state);
 	}
 
+ End:
 	error = dpm_run_callback(callback, dev, state, info);
 	if (!error)
 		dev->power.is_late_suspended = true;
@@ -1338,20 +1364,21 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->pm_domain) {
 		info = "power domain ";
 		callback = pm_op(&dev->pm_domain->ops, state);
-		goto Run;
+		if (callback)
+			goto Run;
 	}
 
 	if (dev->type && dev->type->pm) {
 		info = "type ";
 		callback = pm_op(dev->type->pm, state);
-		goto Run;
+		goto Driver;
 	}
 
 	if (dev->class) {
 		if (dev->class->pm) {
 			info = "class ";
 			callback = pm_op(dev->class->pm, state);
-			goto Run;
+			goto Driver;
 		} else if (dev->class->suspend) {
 			pm_dev_dbg(dev, state, "legacy class ");
 			error = legacy_suspend(dev, state, dev->class->suspend,
@@ -1372,12 +1399,13 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 		}
 	}
 
- Run:
+ Driver:
 	if (!callback && dev->driver && dev->driver->pm) {
 		info = "driver ";
 		callback = pm_op(dev->driver->pm, state);
 	}
 
+ Run:
 	error = dpm_run_callback(callback, dev, state, info);
 
  End:
@@ -1507,7 +1535,11 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	if (dev->pm_domain) {
 		info = "preparing power domain ";
 		callback = dev->pm_domain->ops.prepare;
-	} else if (dev->type && dev->type->pm) {
+		if (callback)
+			goto End;
+	}
+
+	if (dev->type && dev->type->pm) {
 		info = "preparing type ";
 		callback = dev->type->pm->prepare;
 	} else if (dev->class && dev->class->pm) {
@@ -1523,6 +1555,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 		callback = dev->driver->pm->prepare;
 	}
 
+ End:
 	if (callback) {
 		error = callback(dev);
 		suspend_report_result(callback, error);
-- 
1.7.9.5

