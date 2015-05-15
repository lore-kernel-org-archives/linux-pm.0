From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: [PATCH v2 2/2] sched: cpufreq: Adds a field cpu_power in the task_struct
Date: Thu, 14 May 2015 17:12:50 -0700
Message-ID: <1431648770-7404-3-git-send-email-kandoiruchi@google.com>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kandoiruchi@google.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpu_power has been added to keep track of amount of power each task is
consuming. cpu_power is updated whenever stime and utime are updated for
a task. power is computed by taking into account the frequency at which
the current core was running and the current for cpu actively
running at hat frequency.

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
---
 drivers/cpufreq/cpufreq_stats.c | 28 ++++++++++++++++++++++++++++
 include/linux/cpufreq.h         |  8 ++++++++
 include/linux/sched.h           |  2 ++
 kernel/fork.c                   |  1 +
 kernel/sched/cputime.c          |  7 +++++++
 5 files changed, 46 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 6f0b562..682ed898 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/cputime.h>
+#include <linux/sched.h>
 
 static spinlock_t cpufreq_stats_lock;
 
@@ -83,6 +84,33 @@ static void store_current_value(struct cpufreq_power_stats *powerstats,
 	}
 }
 
+void acct_update_power(struct task_struct *task, cputime_t cputime)
+{
+	struct cpufreq_power_stats *powerstats;
+	struct cpufreq_stats *stats;
+	struct cpufreq_policy *policy;
+	unsigned int cpu_num, curr;
+
+	if (!task)
+		return;
+	cpu_num = task_cpu(task);
+	powerstats = per_cpu(cpufreq_power_stats, cpu_num);
+	policy = cpufreq_cpu_get(cpu_num);
+	if (!policy)
+		return;
+
+	if (!powerstats || !(policy->stats)) {
+		cpufreq_cpu_put(policy);
+		return;
+	}
+
+	stats = policy->stats;
+	curr = powerstats->curr[stats->last_index];
+	task->cpu_power += curr * cputime_to_usecs(cputime);
+	cpufreq_cpu_put(policy);
+}
+EXPORT_SYMBOL_GPL(acct_update_power);
+
 static ssize_t store_current_in_state(struct cpufreq_policy *policy,
 		const char *buf, size_t len)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 2ee4888..86826c8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
+#include <asm/cputime.h>
 
 /*********************************************************************
  *                        CPUFREQ INTERFACE                          *
@@ -601,4 +602,11 @@ unsigned int cpufreq_generic_get(unsigned int cpu);
 int cpufreq_generic_init(struct cpufreq_policy *policy,
 		struct cpufreq_frequency_table *table,
 		unsigned int transition_latency);
+
+/*********************************************************************
+ *                         CPUFREQ STATS                             *
+ *********************************************************************/
+
+void acct_update_power(struct task_struct *p, cputime_t cputime);
+
 #endif /* _LINUX_CPUFREQ_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26a2e61..1f2400a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1429,6 +1429,7 @@ struct task_struct {
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	cputime_t utime, stime, utimescaled, stimescaled;
+	unsigned long long cpu_power;
 	cputime_t gtime;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	struct cputime prev_cputime;
@@ -1441,6 +1442,7 @@ struct task_struct {
 		VTIME_USER,
 		VTIME_SYS,
 	} vtime_snap_whence;
+
 #endif
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	u64 start_time;		/* monotonic time in nsec */
diff --git a/kernel/fork.c b/kernel/fork.c
index 03c1eaa..2ca0e9e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1341,6 +1341,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 
 	p->utime = p->stime = p->gtime = 0;
 	p->utimescaled = p->stimescaled = 0;
+	p->cpu_power = 0;
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	p->prev_cputime.utime = p->prev_cputime.stime = 0;
 #endif
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 8394b1e..53a79d5 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -4,6 +4,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
+#include <linux/cpufreq.h>
 #include "sched.h"
 
 
@@ -149,6 +150,9 @@ void account_user_time(struct task_struct *p, cputime_t cputime,
 
 	/* Account for user time used */
 	acct_account_cputime(p);
+
+	/* Account power usage for user time */
+	acct_update_power(p, cputime);
 }
 
 /*
@@ -199,6 +203,9 @@ void __account_system_time(struct task_struct *p, cputime_t cputime,
 
 	/* Account for system time used */
 	acct_account_cputime(p);
+
+	/* Account power usage for system time */
+	acct_update_power(p, cputime);
 }
 
 /*
-- 
2.2.0.rc0.207.ga3a616c
