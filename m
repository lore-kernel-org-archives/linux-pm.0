From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2] PM / sleep: Return RPM_SUSPENDED to keep devices in runtime-suspended
Date: Wed, 28 Sep 2016 11:26:57 +0800
Message-ID: <8202fa7e7900749087d3484abbabd9c274a97318.1475032126.git.yu.c.chen@intel.com>
References: <cover.1475032126.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21754 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752805AbcI1DS4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Sep 2016 23:18:56 -0400
In-Reply-To: <cover.1475032126.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Currently if the ->prepare() callback of a device returns a positive number,
the PM core will regard that as an indication that it may leave the
device runtime-suspended. However it would be more convenient to define
this positive number then makes it more maintainable. Consider there might be
already some device drivers using different positive values, this patch
prints a warning if the positive value is other than RPM_SUSPENDED, and hoping
driver developers would adjust their return values to RPM_SUSPENDED, then
at last we can modify the code to only enable this feature for values return
of RPM_SUSPENDED rather than arbitrary positive value.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 Documentation/power/devices.txt    | 8 ++++----
 Documentation/power/runtime_pm.txt | 2 +-
 drivers/base/power/main.c          | 8 ++++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
index 8ba6625..fc585a5 100644
--- a/Documentation/power/devices.txt
+++ b/Documentation/power/devices.txt
@@ -331,8 +331,8 @@ the phases are:
 	prepare callback can be used to indicate to the PM core that it may
 	safely leave the device in runtime suspend (if runtime-suspended
 	already), provided that all of the device's descendants are also left in
-	runtime suspend.  Namely, if the prepare callback returns a positive
-	number and that happens for all of the descendants of the device too,
+	runtime suspend.  Namely, if the prepare callback returns RPM_SUSPENDED
+	and that happens for all of the descendants of the device too,
 	and all of them (including the device itself) are runtime-suspended, the
 	PM core will skip the suspend, suspend_late and	suspend_noirq suspend
 	phases as well as the resume_noirq, resume_early and resume phases of
@@ -344,7 +344,7 @@ the phases are:
 	Note that this direct-complete procedure applies even if the device is
 	disabled for runtime PM; only the runtime-PM status matters.  It follows
 	that if a device has system-sleep callbacks but does not support runtime
-	PM, then its prepare callback must never return a positive value.  This
+	PM, then its prepare callback must never return RPM_SUSPENDED.  This
 	is because all devices are initially set to runtime-suspended with
 	runtime PM disabled.
 
@@ -422,7 +422,7 @@ When resuming from freeze, standby or memory sleep, the phases are:
 	the resume callbacks occur; it's not necessary to wait until the
 	complete phase.
 
-	Moreover, if the preceding prepare callback returned a positive number,
+	Moreover, if the preceding prepare callback returned RPM_SUSPENDED,
 	the device may have been left in runtime suspend throughout the whole
 	system suspend and resume (the suspend, suspend_late, suspend_noirq
 	phases of system suspend and the resume_noirq, resume_early, resume
diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 1fd1fbe..5316daf 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -667,7 +667,7 @@ suspend began in the suspended state.
 
 To this end, the PM core provides a mechanism allowing some coordination between
 different levels of device hierarchy.  Namely, if a system suspend .prepare()
-callback returns a positive number for a device, that indicates to the PM core
+callback returns RPM_SUSPENDED for a device, that indicates to the PM core
 that the device appears to be runtime-suspended and its state is fine, so it
 may be left in runtime suspend provided that all of its descendants are also
 left in runtime suspend.  If that happens, the PM core will not execute any
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e44944f..03a047e 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1603,14 +1603,18 @@ unlock:
 		return ret;
 	}
 	/*
-	 * A positive return value from ->prepare() means "this device appears
+	 * A return value of RPM_SUSPENDED from ->prepare() means "this device appears
 	 * to be runtime-suspended and its state is fine, so if it really is
 	 * runtime-suspended, you can leave it in that state provided that you
 	 * will do the same thing with all of its descendants".  This only
 	 * applies to suspend transitions, however.
 	 */
 	spin_lock_irq(&dev->power.lock);
-	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
+	if (ret > 0 && state.event == PM_EVENT_SUSPEND) {
+		dev->power.direct_complete = true;
+		if (ret != RPM_SUSPENDED)
+			dev_warn(dev, "->prepare() should return RPM_SUSPENDED.\n");
+	}
 	spin_unlock_irq(&dev->power.lock);
 	return 0;
 }
-- 
2.7.4

