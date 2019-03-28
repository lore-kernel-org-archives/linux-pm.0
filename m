From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH v3 3/4] cpufreq: schedutil: Simplify iowait boosting
Date: Thu, 28 Mar 2019 11:33:21 +0100
Message-ID: <3714586.Xfz7sSM4fi@aspire.rjw.lan>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan> <2864116.v8IU97Resm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2864116.v8IU97Resm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is not reason for the minimum iowait boost value in the
schedutil cpufreq governor to depend on the available range of CPU
frequencies.  In fact, that dependency is generally confusing,
because it causes the iowait boost to behave somewhat differently
on CPUs with the same maximum frequency and different minimum
frequencies, for example.

For this reason, replace the min field in struct sugov_cpu
with a constant and choose its values to be 1/8 of
SCHED_CAPACITY_SCALE (for consistency with the intel_pstate
driver's internal governor).

[Note that policy->cpuinfo.max_freq will not be a constant any more
 after a subsequent change, so this change is depended on by it.]

Link: https://lore.kernel.org/lkml/20190305083202.GU32494@hirez.programming.kicks-ass.net/T/#ee20bdc98b7d89f6110c0d00e5c3ee8c2ced93c3d
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

As pointed out by Quentin, the original patch overlooked two kerneldoc
comments that needed to be updated along with the code, so do that here.

No other changes with respect to the original.

---
 kernel/sched/cpufreq_schedutil.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -13,6 +13,8 @@
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
+#define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
+
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
 	unsigned int		rate_limit_us;
@@ -51,7 +53,6 @@ struct sugov_cpu {
 	u64			last_update;
 
 	unsigned long		bw_dl;
-	unsigned long		min;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -291,8 +292,8 @@ static unsigned long sugov_get_util(stru
  *
  * The IO wait boost of a task is disabled after a tick since the last update
  * of a CPU. If a new IO wait boost is requested after more then a tick, then
- * we enable the boost starting from the minimum frequency, which improves
- * energy efficiency by ignoring sporadic wakeups from IO.
+ * we enable the boost starting from IOWAIT_BOOST_MIN, which improves energy
+ * efficiency by ignoring sporadic wakeups from IO.
  */
 static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 			       bool set_iowait_boost)
@@ -303,7 +304,7 @@ static bool sugov_iowait_reset(struct su
 	if (delta_ns <= TICK_NSEC)
 		return false;
 
-	sg_cpu->iowait_boost = set_iowait_boost ? sg_cpu->min : 0;
+	sg_cpu->iowait_boost = set_iowait_boost ? IOWAIT_BOOST_MIN : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -317,8 +318,9 @@ static bool sugov_iowait_reset(struct su
  *
  * Each time a task wakes up after an IO operation, the CPU utilization can be
  * boosted to a certain utilization which doubles at each "frequent and
- * successive" wakeup from IO, ranging from the utilization of the minimum
- * OPP to the utilization of the maximum OPP.
+ * successive" wakeup from IO, ranging from IOWAIT_BOOST_MIN to the utilization
+ * of the maximum OPP.
+ *
  * To keep doubling, an IO boost has to be requested at least once per tick,
  * otherwise we restart from the utilization of the minimum OPP.
  */
@@ -349,7 +351,7 @@ static void sugov_iowait_boost(struct su
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->min;
+	sg_cpu->iowait_boost = IOWAIT_BOOST_MIN;
 }
 
 /**
@@ -389,7 +391,7 @@ static unsigned long sugov_iowait_apply(
 		 * No boost pending; reduce the boost value.
 		 */
 		sg_cpu->iowait_boost >>= 1;
-		if (sg_cpu->iowait_boost < sg_cpu->min) {
+		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
 			return util;
 		}
@@ -826,9 +828,6 @@ static int sugov_start(struct cpufreq_po
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->min			=
-			(SCHED_CAPACITY_SCALE * policy->cpuinfo.min_freq) /
-			policy->cpuinfo.max_freq;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
