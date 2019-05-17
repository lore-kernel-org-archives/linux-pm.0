From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: sleep: Add kerneldoc comments to some functions
Date: Fri, 17 May 2019 12:56:01 +0200
Message-ID: <11319987.O9o76ZdvQC@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add kerneldoc comments to pm_suspend_via_firmware(),
pm_resume_via_firmware() and pm_suspend_via_s2idle() to explain
what they do.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/suspend.h |   20 ++++++++++++++++++++
 kernel/power/suspend.c  |    6 ++++++
 2 files changed, 26 insertions(+)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -227,11 +227,31 @@ static inline void pm_set_resume_via_fir
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
 }
 
+/**
+ * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if the platform firmware is going to be invoked at the end of
+ * the system-wide power management transition in progress in order to complete
+ * it.
+ */
 static inline bool pm_suspend_via_firmware(void)
 {
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_SUSPEND);
 }
 
+/**
+ * pm_resume_via_firmware - Check if platform firmware has woken up the system.
+ *
+ * To be called during system-wide power management transitions from sleep
+ * states.
+ *
+ * Return 'true' if the platform firmware has passed control to the kernel at
+ * the beginning of the system-wide power management transition in progress, so
+ * the event that woke up the system from sleep has been handled by the platform
+ * firmware.
+ */
 static inline bool pm_resume_via_firmware(void)
 {
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -62,6 +62,12 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_w
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+/**
+ * pm_suspend_via_s2idle - Check if suspend-to-idle is the default suspend.
+ *
+ * Return 'true' if suspend-to-idle has been selected as the default system
+ * suspend method.
+ */
 bool pm_suspend_via_s2idle(void)
 {
 	return mem_sleep_current == PM_SUSPEND_TO_IDLE;
