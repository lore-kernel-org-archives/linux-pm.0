From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] PM / Suspend: Add more suspend notifier events
Date: Fri, 18 Mar 2011 17:46:20 +0000 (GMT)
Message-ID: <20110318174620.2D0B99D401D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net
List-Id: linux-pm@vger.kernel.org

Without becoming a full platform_suspend_ops implementation, the core
olpc driver needs to be called during late suspend to apply a wakeup mask
that will have been set by individual drivers' suspend routines.

Add a notifier here, and a symmetric one to happen during resume.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 include/linux/notifier.h |   10 ++++++----
 kernel/power/suspend.c   |    5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

To further clarify how this will be used by upcoming patches:

OLPC's EC needs to be run with a specific event mask during runtime,
and another one (based on configured wakeup events) during suspend.

The exact details of the in-suspend mask we are interested in cannot be
computed until individual drivers suspend routines are run.

Therefore we need a way to hook in generic code that runs after normal drivers
suspend routines, in process context with interrupts still enabled, to apply
the in-suspend event mask.

This patch will add the olpc_ec_wakeup_set() API for setting the appropriate
bits in the in-suspend event mask (stored only in memory to begin with), and
uses the new notifiers to program that mask to the hardware at the appropriate
time:
http://dev.laptop.org/~dsd/20110114/0006-olpc-EC-SCI-wakeup-mask-functionality.patch

This patch uses the olpc_ec_wakeup_set() API to compute and set the suspend
preference during olpc-battery's suspend routine:
http://dev.laptop.org/~dsd/20110114/0013-olpc_battery-add-wakeup-support.patch
(other drivers will follow this pattern too)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 2026f9e..4519d4f 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -254,10 +254,12 @@ static inline int notifier_to_errno(int ret)
 /* Hibernation and suspend events */
 #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
 #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
-#define PM_SUSPEND_PREPARE	0x0003 /* Going to suspend the system */
-#define PM_POST_SUSPEND		0x0004 /* Suspend finished */
-#define PM_RESTORE_PREPARE	0x0005 /* Going to restore a saved image */
-#define PM_POST_RESTORE		0x0006 /* Restore failed */
+#define PM_SUSPEND_PREPARE	0x0003 /* Preparing to suspend the system */
+#define PM_DO_SUSPEND		0x0004 /* Going to suspend the system */
+#define PM_DO_RESUME		0x0005 /* Going to resume the system */
+#define PM_POST_SUSPEND		0x0006 /* Suspend finished */
+#define PM_RESTORE_PREPARE	0x0007 /* Going to restore a saved image */
+#define PM_POST_RESTORE		0x0008 /* Restore failed */
 
 /* Console keyboard events.
  * Note: KBD_KEYCODE is always sent before KBD_UNBOUND_KEYCODE, KBD_UNICODE and
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 2814c32..35acfc5 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -224,9 +224,14 @@ int suspend_devices_and_enter(suspend_state_t state)
 	if (suspend_test(TEST_DEVICES))
 		goto Recover_platform;
 
+	error = pm_notifier_call_chain(PM_DO_SUSPEND);
+	if (error)
+		goto Recover_platform;
+
 	suspend_enter(state);
 
  Resume_devices:
+	pm_notifier_call_chain(PM_DO_RESUME);
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
-- 
1.7.4
