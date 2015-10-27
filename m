From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 35/70] cpufreq: interactive: fix racy timer stopping
Date: Tue, 27 Oct 2015 18:30:23 +0100
Message-ID: <1445967059-6897-35-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

When stopping the governor, del_timer_sync() can race against an
invocation of the idle notifier callback, which has the potential
to reactivate the timer.

To fix this issue, a read-write semaphore is used. Multiple readers are
allowed as long as pcpu->governor_enabled is true.  However it can be
moved to false only after taking a write semaphore which would wait for
any on-going asynchronous activities to complete and prevent any more o=
f
those activities to be initiated.

[toddpoynor@google.com: cosmetic and commit text changes]
Change-Id: Ib51165a735d73dcf964a06754c48bdc1913e13d0
Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   38 ++++++++++++++++++++++++-=
--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index f8e9ee9..74f5609 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -21,7 +21,7 @@
 #include <linux/cpufreq.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/mutex.h>
+#include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
 #include <linux/tick.h>
@@ -29,7 +29,6 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/kthread.h>
-#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <asm/cputime.h>
=20
@@ -52,6 +51,7 @@ struct cpufreq_interactive_cpuinfo {
 	unsigned int floor_freq;
 	u64 floor_validate_time;
 	u64 hispeed_validate_time;
+	struct rw_semaphore enable_sem;
 	int governor_enabled;
 };
=20
@@ -279,8 +279,8 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	unsigned long flags;
 	bool boosted;
=20
-	smp_rmb();
-
+	if (!down_read_trylock(&pcpu->enable_sem))
+		return;
 	if (!pcpu->governor_enabled)
 		goto exit;
=20
@@ -387,6 +387,7 @@ rearm:
 		cpufreq_interactive_timer_resched(pcpu);
=20
 exit:
+	up_read(&pcpu->enable_sem);
 	return;
 }
=20
@@ -396,8 +397,12 @@ static void cpufreq_interactive_idle_start(void)
 		&per_cpu(cpuinfo, smp_processor_id());
 	int pending;
=20
-	if (!pcpu->governor_enabled)
+	if (!down_read_trylock(&pcpu->enable_sem))
+		return;
+	if (!pcpu->governor_enabled) {
+		up_read(&pcpu->enable_sem);
 		return;
+	}
=20
 	pending =3D timer_pending(&pcpu->cpu_timer);
=20
@@ -414,6 +419,7 @@ static void cpufreq_interactive_idle_start(void)
 			cpufreq_interactive_timer_resched(pcpu);
 	}
=20
+	up_read(&pcpu->enable_sem);
 }
=20
 static void cpufreq_interactive_idle_end(void)
@@ -421,8 +427,12 @@ static void cpufreq_interactive_idle_end(void)
 	struct cpufreq_interactive_cpuinfo *pcpu =3D
 		&per_cpu(cpuinfo, smp_processor_id());
=20
-	if (!pcpu->governor_enabled)
+	if (!down_read_trylock(&pcpu->enable_sem))
+		return;
+	if (!pcpu->governor_enabled) {
+		up_read(&pcpu->enable_sem);
 		return;
+	}
=20
 	/* Arm the timer for 1-2 ticks later if not already. */
 	if (!timer_pending(&pcpu->cpu_timer)) {
@@ -432,6 +442,8 @@ static void cpufreq_interactive_idle_end(void)
 		del_timer(&pcpu->cpu_slack_timer);
 		cpufreq_interactive_timer(smp_processor_id());
 	}
+
+	up_read(&pcpu->enable_sem);
 }
=20
 static int cpufreq_interactive_speedchange_task(void *data)
@@ -466,10 +478,12 @@ static int cpufreq_interactive_speedchange_task(v=
oid *data)
 			unsigned int max_freq =3D 0;
=20
 			pcpu =3D &per_cpu(cpuinfo, cpu);
-			smp_rmb();
-
-			if (!pcpu->governor_enabled)
+			if (!down_read_trylock(&pcpu->enable_sem))
+				continue;
+			if (!pcpu->governor_enabled) {
+				up_read(&pcpu->enable_sem);
 				continue;
+			}
=20
 			for_each_cpu(j, pcpu->policy->cpus) {
 				struct cpufreq_interactive_cpuinfo *pjcpu =3D
@@ -486,6 +500,8 @@ static int cpufreq_interactive_speedchange_task(voi=
d *data)
 			trace_cpufreq_interactive_setspeed(cpu,
 						     pcpu->target_freq,
 						     pcpu->policy->cur);
+
+			up_read(&pcpu->enable_sem);
 		}
 	}
=20
@@ -936,10 +952,11 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 	case CPUFREQ_GOV_STOP:
 		for_each_cpu(j, policy->cpus) {
 			pcpu =3D &per_cpu(cpuinfo, j);
+			down_write(&pcpu->enable_sem);
 			pcpu->governor_enabled =3D 0;
-			smp_wmb();
 			del_timer_sync(&pcpu->cpu_timer);
 			del_timer_sync(&pcpu->cpu_slack_timer);
+			up_write(&pcpu->enable_sem);
 		}
=20
 		if (atomic_dec_return(&active_count) > 0)
@@ -989,6 +1006,7 @@ static int __init cpufreq_interactive_init(void)
 		init_timer(&pcpu->cpu_slack_timer);
 		pcpu->cpu_slack_timer.function =3D cpufreq_interactive_nop_timer;
 		spin_lock_init(&pcpu->load_lock);
+		init_rwsem(&pcpu->enable_sem);
 	}
=20
 	spin_lock_init(&target_loads_lock);
--=20
1.7.9.5
