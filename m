From: Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH RESEND 1/1] x86: tsc: avoid system instability in hibernation
Date: Thu, 26 Jul 2018 08:56:56 -0700
Message-ID: <20180726155656.14873-1-eduval@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Eduardo Valentin <eduval@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Rajvi Jingar <rajvi.jingar@intel.com>, Pavel Tatashin <pasha.tatashin@oracle.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

System instability are seen during resume from hibernation when system
is under heavy CPU load. This is due to the lack of update of sched
clock data, and the scheduler would then think that heavy CPU hog
tasks need more time in CPU, causing the system to freeze
during the unfreezing of tasks. For example, threaded irqs,
and kernel processes servicing network interface may be delayed
for several tens of seconds, causing the system to be unreachable.

Situation like this can be reported by using lockup detectors
such as workqueue lockup detectors:

[root@ip-172-31-67-114 ec2-user]# echo disk > /sys/power/state

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
 kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!

The fix for this situation is to mark the sched clock as unstable
as early as possible in the resume path, leaving it unstable
for the duration of the resume process. This will force the
scheduler to attempt to align the sched clock across CPUs using
the delta with time of day, updating sched clock data. In a post
hibernation event, we can then mark the sched clock as stable
again, avoiding unnecessary syncs with time of day on systems
in which TSC is reliable.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---

Hey,

No changes from first attempt, no pressure on resending. The RESEND
tag is just because I missed linux-pm in the first attempt.

BR,

 arch/x86/kernel/tsc.c       | 29 +++++++++++++++++++++++++++++
 include/linux/sched/clock.h |  5 +++++
 kernel/sched/clock.c        |  4 ++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8ea117f8142e..f197c9742fef 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -13,6 +13,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/suspend.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -1377,3 +1378,31 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 #endif
+
+static int tsc_pm_notifier(struct notifier_block *notifier,
+			   unsigned long pm_event, void *unused)
+{
+	switch (pm_event) {
+	case PM_HIBERNATION_PREPARE:
+		clear_sched_clock_stable();
+		break;
+	case PM_POST_HIBERNATION:
+		/* Set back to the default */
+		if (!check_tsc_unstable())
+			set_sched_clock_stable();
+		break;
+	}
+
+	return 0;
+};
+
+static struct notifier_block tsc_pm_notifier_block = {
+	.notifier_call = tsc_pm_notifier,
+};
+
+static int tsc_setup_pm_notifier(void)
+{
+	return register_pm_notifier(&tsc_pm_notifier_block);
+}
+
+subsys_initcall(tsc_setup_pm_notifier);
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 867d588314e0..902654ac5f7e 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -32,6 +32,10 @@ static inline void clear_sched_clock_stable(void)
 {
 }
 
+static inline void set_sched_clock_stable(void)
+{
+}
+
 static inline void sched_clock_idle_sleep_event(void)
 {
 }
@@ -51,6 +55,7 @@ static inline u64 local_clock(void)
 }
 #else
 extern int sched_clock_stable(void);
+extern void set_sched_clock_stable(void);
 extern void clear_sched_clock_stable(void);
 
 /*
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e086babe6c61..8453440e236c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -131,7 +131,7 @@ static void __scd_stamp(struct sched_clock_data *scd)
 	scd->tick_raw = sched_clock();
 }
 
-static void __set_sched_clock_stable(void)
+void set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
 
@@ -228,7 +228,7 @@ static int __init sched_clock_init_late(void)
 	smp_mb(); /* matches {set,clear}_sched_clock_stable() */
 
 	if (__sched_clock_stable_early)
-		__set_sched_clock_stable();
+		set_sched_clock_stable();
 
 	return 0;
 }
-- 
2.18.0
