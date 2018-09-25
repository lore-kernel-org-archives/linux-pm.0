From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH] PM / core: Fix extra pm_runtime_enable on resume
Date: Tue, 25 Sep 2018 18:10:55 -0400
Message-ID: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Matching pm_runtime_disable/pm_runtime_enable routines should be
called for "direct_complete" devices during suspend/resume and there
are cases where the pm_runtime_disable is skipped during suspend but
pm_runtime_enable is still called during resume. This is a problem
because the runtime enable state is really a counter and this can
incorrectly enable pm_runtime when it should not be enabled. This
happens for any direct_complete device doing an async suspend after
the global variable "async_error" is set (which is set by any sync
or async device's suspend error or early wake condition).

This failure is very timing dependent but for testing and debug
the following changes will make it happen more frequently.
- Add an msleep(500) as the first line in async_suspend() in
  drivers/base/power/main.c
- Modify alarmtimer_suspend in kernel/time/alarmtimer.c to just
  return -EBUSY

To see the failure condition that's been fixed with this patch,
enable dynamic debug for drivers/power/main.c and then run
"rtcwake -s 2 -m standby" and grep for
"skipping runtime enable during resume" messages.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/base/power/main.c | 21 +++++++++++++++++++--
 include/linux/pm.h        |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..2dc40662aae0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -945,7 +945,13 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
-		pm_runtime_enable(dev);
+		if (dev->power.pm_runtime_disabled) {
+			pm_runtime_enable(dev);
+			dev->power.pm_runtime_disabled = false;
+		} else {
+			pm_dev_dbg(dev, state,
+				   "skipping runtime enable during ");
+		}
 		goto Complete;
 	}
 
@@ -1736,8 +1742,19 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-			if (pm_runtime_status_suspended(dev))
+			if (pm_runtime_status_suspended(dev)) {
+				/*
+				 * If any device's sync or async suspend fails
+				 * and sets async_error, any async suspend for
+				 * direct_complete devices after the failure
+				 * will not execute the pm_runtime_disable
+				 * above. This flag lets the async device's
+				 * resume function (which is always run) know
+				 * if a matching pm_runtime_enable is needed.
+				 */
+				dev->power.pm_runtime_disabled = true;
 				goto Complete;
+			}
 
 			pm_runtime_enable(dev);
 		}
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..45738ad977fd 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -593,6 +593,7 @@ struct dev_pm_info {
 	bool			is_late_suspended:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	unsigned int		pm_runtime_disabled:1;
 	u32			driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
-- 
1.9.0.138.g2de3478
