From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Restore lock-less behaviour for the genpd syscore APIs
Date: Tue,  7 Feb 2017 16:53:04 +0100
Message-ID: <1486482784-31734-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32840 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754778AbdBGPxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 10:53:10 -0500
Received: by mail-lf0-f53.google.com with SMTP id x1so65504548lff.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2017 07:53:09 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

The commit ef4f7e2c8335 ("PM / Domains: Fix asynchronous execution of
*noirq() callbacks") went too far, as it not only changed to use locks for
the *noirq callbacks, but also for the genpd syscore APIs.

This cause the following error, reported by Geert Uytterhoeven:

"This causes the following BUG on all my Renesas arm32 boards, where the
system timer is an IRQ safe device:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:232
in_atomic(): 0, irqs_disabled(): 128, pid: 1751, name: s2ram
CPU: 0 PID: 1751 Comm: s2ram Not tainted
4.10.0-rc7-koelsch-05643-g27f4c73972a614fe #3354
Hardware name: Generic R8A7791 (Flattened Device Tree)
[<c020e9c4>] (unwind_backtrace) from [<c020a40c>] (show_stack+0x10/0x14)
[<c020a40c>] (show_stack) from [<c03f9818>] (dump_stack+0x7c/0x9c)
[<c03f9818>] (dump_stack) from [<c0240020>] (___might_sleep+0x124/0x160)
[<c0240020>] (___might_sleep) from [<c06fedfc>] (mutex_lock+0x18/0x60)
[<c06fedfc>] (mutex_lock) from [<c04de340>]
(genpd_syscore_switch+0x2c/0x7c)
[<c04de340>] (genpd_syscore_switch) from [<c05ec328>]
(sh_cmt_clock_event_suspend+0x18/0x28)
[<c05ec328>] (sh_cmt_clock_event_suspend) from [<c027f9a4>]
(clockevents_suspend+0x40/0x54)
[<c027f9a4>] (clockevents_suspend) from [<c0276d48>]
(timekeeping_suspend+0x23c/0x278)
[<c0276d48>] (timekeeping_suspend) from [<c04cbb88>]
(syscore_suspend+0x88/0x138)
[<c04cbb88>] (syscore_suspend) from [<c025f618>]
(suspend_devices_and_enter+0x290/0x470)
[<c025f618>] (suspend_devices_and_enter) from [<c025fa20>]
(pm_suspend+0x228/0x280)
[<c025fa20>] (pm_suspend) from [<c025e60c>] (state_store+0xac/0xcc)
[<c025e60c>] (state_store) from [<c0340c4c>] (kernfs_fop_write+0x160/0x19c)
[<c0340c4c>] (kernfs_fop_write) from [<c02e3054>] (__vfs_write+0x20/0x108)
[<c02e3054>] (__vfs_write) from [<c02e4424>] (vfs_write+0xb8/0x144)
[<c02e4424>] (vfs_write) from [<c02e5014>] (SyS_write+0x40/0x80)
[<c02e5014>] (SyS_write) from [<c0206cc0>] (ret_fast_syscall+0x0/0x34)"

To fix this problem, restore the lock-less behaviour. However only for the
genpd syscore APIs.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: ef4f7e2c8335 ("PM / Domains: Fix asynchronous execution of *noirq() callbacks")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 48 +++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 271e208..3a75fb1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -729,16 +729,17 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 /**
  * genpd_sync_power_off - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
+ * @use_lock: use the lock.
  * @depth: nesting count for lockdep.
  *
  * Check if the given PM domain can be powered off (during system suspend or
  * hibernation) and do that if so.  Also, in that case propagate to its masters.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
- * transitions, but since the "noirq" callbacks may be executed asynchronously,
- * the lock must be held.
+ * transitions. The "noirq" callbacks may be executed asynchronously, thus in
+ * these cases the lock must be held.
  */
-static void genpd_sync_power_off(struct generic_pm_domain *genpd,
+static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 				 unsigned int depth)
 {
 	struct gpd_link *link;
@@ -759,22 +760,27 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd,
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_dec(link->master);
 
-		genpd_lock_nested(link->master, depth + 1);
-		genpd_sync_power_off(link->master, depth + 1);
-		genpd_unlock(link->master);
+		if (use_lock)
+			genpd_lock_nested(link->master, depth + 1);
+
+		genpd_sync_power_off(link->master, use_lock, depth + 1);
+
+		if (use_lock)
+			genpd_unlock(link->master);
 	}
 }
 
 /**
  * genpd_sync_power_on - Synchronously power on a PM domain and its masters.
  * @genpd: PM domain to power on.
+ * @use_lock: use the lock.
  * @depth: nesting count for lockdep.
  *
  * This function is only called in "noirq" and "syscore" stages of system power
- * transitions, but since the "noirq" callbacks may be executed asynchronously,
- * the lock must be held.
+ * transitions. The "noirq" callbacks may be executed asynchronously, thus in
+ * these cases the lock must be held.
  */
-static void genpd_sync_power_on(struct generic_pm_domain *genpd,
+static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 				unsigned int depth)
 {
 	struct gpd_link *link;
@@ -785,9 +791,13 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd,
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_inc(link->master);
 
-		genpd_lock_nested(link->master, depth + 1);
-		genpd_sync_power_on(link->master, depth + 1);
-		genpd_unlock(link->master);
+		if (use_lock)
+			genpd_lock_nested(link->master, depth + 1);
+
+		genpd_sync_power_on(link->master, use_lock, depth + 1);
+
+		if (use_lock)
+			genpd_unlock(link->master);
 	}
 
 	_genpd_power_on(genpd, false);
@@ -898,7 +908,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 
 	genpd_lock(genpd);
 	genpd->suspended_count++;
-	genpd_sync_power_off(genpd, 0);
+	genpd_sync_power_off(genpd, true, 0);
 	genpd_unlock(genpd);
 
 	return 0;
@@ -925,7 +935,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 		return 0;
 
 	genpd_lock(genpd);
-	genpd_sync_power_on(genpd, 0);
+	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
 
@@ -1016,7 +1026,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 
-	genpd_sync_power_on(genpd, 0);
+	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start)
@@ -1070,17 +1080,13 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 	if (!pm_genpd_present(genpd))
 		return;
 
-	genpd_lock(genpd);
-
 	if (suspend) {
 		genpd->suspended_count++;
-		genpd_sync_power_off(genpd, 0);
+		genpd_sync_power_off(genpd, false, 0);
 	} else {
-		genpd_sync_power_on(genpd, 0);
+		genpd_sync_power_on(genpd, false, 0);
 		genpd->suspended_count--;
 	}
-
-	genpd_unlock(genpd);
 }
 
 void pm_genpd_syscore_poweroff(struct device *dev)
-- 
1.9.1

