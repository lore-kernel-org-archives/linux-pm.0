From: Juri Lelli <juri.lelli@redhat.com>
Subject: [RFC PATCH v2 1/8] sched/cpufreq_schedutil: make use of DEADLINE utilization signal
Date: Mon,  4 Dec 2017 11:23:18 +0100
Message-ID: <20171204102325.5110-2-juri.lelli@redhat.com>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204102325.5110-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, alessio.balsini@arm.com, juri.lelli@redhat.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Juri Lelli <juri.lelli@arm.com>

SCHED_DEADLINE tracks active utilization signal with a per dl_rq
variable named running_bw.

Make use of that to drive cpu frequency selection: add up FAIR and
DEADLINE contribution to get the required CPU capacity to handle both
requirements (while RT still selects max frequency).

Co-authored-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/sched/cpufreq.h    |  2 --
 kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index d1ad3d825561..0b55834efd46 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -12,8 +12,6 @@
 #define SCHED_CPUFREQ_DL	(1U << 1)
 #define SCHED_CPUFREQ_IOWAIT	(1U << 2)
 
-#define SCHED_CPUFREQ_RT_DL	(SCHED_CPUFREQ_RT | SCHED_CPUFREQ_DL)
-
 #ifdef CONFIG_CPU_FREQ
 struct update_util_data {
        void (*func)(struct update_util_data *data, u64 time, unsigned int flags);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2f52ec0f1539..de1ad1fffbdc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -179,12 +179,17 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long cfs_max;
+	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
+				>> BW_SHIFT;
 
-	cfs_max = arch_scale_cpu_capacity(NULL, cpu);
+	*max = arch_scale_cpu_capacity(NULL, cpu);
 
-	*util = min(rq->cfs.avg.util_avg, cfs_max);
-	*max = cfs_max;
+	/*
+	 * Ideally we would like to set util_dl as min/guaranteed freq and
+	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
+	 * ready for such an interface. So, we only do the latter for now.
+	 */
+	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
@@ -272,7 +277,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	if (flags & SCHED_CPUFREQ_RT_DL) {
+	if (flags & SCHED_CPUFREQ_RT) {
 		next_f = policy->cpuinfo.max_freq;
 	} else {
 		sugov_get_util(&util, &max, sg_cpu->cpu);
@@ -317,7 +322,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 			j_sg_cpu->iowait_boost_pending = false;
 			continue;
 		}
-		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
+		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
 			return policy->cpuinfo.max_freq;
 
 		j_util = j_sg_cpu->util;
@@ -353,7 +358,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
 	sg_cpu->last_update = time;
 
 	if (sugov_should_update_freq(sg_policy, time)) {
-		if (flags & SCHED_CPUFREQ_RT_DL)
+		if (flags & SCHED_CPUFREQ_RT)
 			next_f = sg_policy->policy->cpuinfo.max_freq;
 		else
 			next_f = sugov_next_freq_shared(sg_cpu, time);
@@ -383,9 +388,9 @@ static void sugov_irq_work(struct irq_work *irq_work)
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
 	/*
-	 * For RT and deadline tasks, the schedutil governor shoots the
-	 * frequency to maximum. Special care must be taken to ensure that this
-	 * kthread doesn't result in the same behavior.
+	 * For RT tasks, the schedutil governor shoots the frequency to maximum.
+	 * Special care must be taken to ensure that this kthread doesn't result
+	 * in the same behavior.
 	 *
 	 * This is (mostly) guaranteed by the work_in_progress flag. The flag is
 	 * updated only at the end of the sugov_work() function and before that
-- 
2.14.3
