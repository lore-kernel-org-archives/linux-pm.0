From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2] kernel/hung_task.c: disable on suspend
Date: Tue, 25 Sep 2018 14:16:36 +0200
Message-ID: <20180925121636.592-1-vkuznets@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

It is possible to observe hung_task complaints when system goes to
suspend-to-idle state:

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
 sd 0:0:0:0: [sda] Synchronizing SCSI cache
 INFO: task bash:1569 blocked for more than 120 seconds.
       Not tainted 4.19.0-rc3_+ #687
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 bash            D    0  1569    604 0x00000000
 Call Trace:
  ? __schedule+0x1fe/0x7e0
  schedule+0x28/0x80
  suspend_devices_and_enter+0x4ac/0x750
  pm_suspend+0x2c0/0x310

The root cause of the issue is that under certain circumstances jiffies
counter keeps advancing, some work to prevent that is currently ongoing.
However, it seems that it would make sense to disable hung task detector
on suspend and re-enable it on wakeup regardless.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
- Implement detector disabling by zeroing timeout [Rafael J. Wysocki]
---
 kernel/hung_task.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1269ef..ac6e8c9306bd 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/export.h>
 #include <linux/sysctl.h>
+#include <linux/suspend.h>
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
@@ -242,12 +243,14 @@ void reset_hung_task_detector(void)
 }
 EXPORT_SYMBOL_GPL(reset_hung_task_detector);
 
+static unsigned long hung_last_checked;
+
 /*
  * kthread which checks for tasks stuck in D state
  */
 static int watchdog(void *dummy)
 {
-	unsigned long hung_last_checked = jiffies;
+	hung_last_checked = jiffies;
 
 	set_user_nice(current, 0);
 
@@ -272,9 +275,40 @@ static int watchdog(void *dummy)
 	return 0;
 }
 
+static int hungtask_pm_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	static unsigned long saved_timeout, saved_interval;
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+		saved_timeout = sysctl_hung_task_timeout_secs;
+		saved_interval = sysctl_hung_task_check_interval_secs;
+		sysctl_hung_task_timeout_secs = 0;
+		sysctl_hung_task_check_interval_secs = 0;
+		wake_up_process(watchdog_task);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+		sysctl_hung_task_timeout_secs = saved_timeout;
+		sysctl_hung_task_check_interval_secs = saved_interval;
+		hung_last_checked = jiffies;
+		wake_up_process(watchdog_task);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 static int __init hung_task_init(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	/* Disable hung task detector on suspend */
+	pm_notifier(hungtask_pm_notify, 0);
+
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
 
 	return 0;
-- 
2.17.1
