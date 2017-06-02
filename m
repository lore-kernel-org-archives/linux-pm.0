From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Find transition latency dynamically
Date: Fri,  2 Jun 2017 16:59:38 +0530
Message-ID: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

The transition_latency_ns represents the maximum time it can take for
the hardware to switch from/to any frequency for a CPU.

The transition_latency_ns is used currently for two purposes:

o To check if the hardware latency is over the maximum allowed for a
  governor (only for ondemand and conservative (why not schedutil?)) and
  to decide if the governor can be used or not.

o To calculate the sampling_rate or rate_limit for the governors by
  multiplying transition_latency_ns with a constant.

The platform drivers can also set this value to CPUFREQ_ETERNAL if they
don't know this number and in that case we disallow use of ondemand and
conservative governors as the latency would be higher than the maximum
allowed for the governors.

In many cases this number is forged by the driver authors to get the
default sampling rate to a desired value. Anyway, the actual latency
values can differ from what is received from the hardware designers.

Over that, what is provided by the drivers is most likely the time it
takes to change frequency of the hardware, which doesn't account the
software overhead involved.

In order to have guarantees about this number, this patch tries to
calculate the latency dynamically at cpufreq driver registration time by
first switching to min frequency, then to the max and finally back to
the initial frequency. And the maximum of all three is used as the
target_latency. Specifically the time it takes to go from min to max
frequency (when the software runs the slowest) should be good enough,
and even if there is a delta involved then it shouldn't be a lot.

For now this patch limits this feature only for platforms which have set
the transition latency to CPUFREQ_ETERNAL. Maybe we can convert everyone
to use it in future, but lets see.

This is tested over ARM64 Hikey platform which currently sets
"clock-latency" as 500 us from DT, while with this patch the actualy
value increased to 800 us.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e3f6496524d..478a18364b1f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -977,6 +978,66 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
 	return NULL;
 }
 
+static int find_dvfs_latency(struct cpufreq_policy *policy, unsigned long freq,
+			     unsigned int *latency_ns)
+{
+	u64 time;
+	int ret;
+
+	time = local_clock();
+	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
+	*latency_ns = local_clock() - time;
+
+	return ret;
+}
+
+/*
+ * Find the transition latency dynamically by:
+ * - Switching to min freq first.
+ * - Then switching to max freq.
+ * - And finally switching back to the initial freq.
+ *
+ * The maximum duration of the above three freq changes should be good enough to
+ * find the maximum transition latency for a platform.
+ */
+static void cpufreq_find_target_latency(struct cpufreq_policy *policy)
+{
+	unsigned long initial_freq = policy->cur;
+	unsigned int latency_ns, latency_max_ns;
+	int ret;
+
+	if (!has_target())
+		return;
+
+	/* Limit to drivers with latency set to CPUFREQ_ETERNAL for now */
+	if (policy->cpuinfo.transition_latency != CPUFREQ_ETERNAL)
+		return;
+
+	/* Go to min frequency first */
+	ret = find_dvfs_latency(policy, policy->cpuinfo.min_freq, &latency_ns);
+	if (ret)
+		return;
+
+	latency_max_ns = latency_ns;
+
+	/* Go to max frequency then.. */
+	ret = find_dvfs_latency(policy, policy->cpuinfo.max_freq, &latency_ns);
+	if (ret)
+		return;
+
+	latency_max_ns = max(latency_max_ns, latency_ns);
+
+	/* And finally switch back to where we started from */
+	ret = find_dvfs_latency(policy, initial_freq, &latency_ns);
+	if (ret)
+		return;
+
+	policy->cpuinfo.transition_latency = max(latency_max_ns, latency_ns);
+
+	pr_info("%s: Setting transition latency to %u ns for policy of CPU%d\n",
+		__func__, policy->cpuinfo.transition_latency, policy->cpu);
+}
+
 static int cpufreq_init_policy(struct cpufreq_policy *policy)
 {
 	struct cpufreq_governor *gov = NULL;
@@ -1246,6 +1307,8 @@ static int cpufreq_online(unsigned int cpu)
 	}
 
 	if (new_policy) {
+		cpufreq_find_target_latency(policy);
+
 		ret = cpufreq_add_dev_interface(policy);
 		if (ret)
 			goto out_exit_policy;
-- 
2.13.0.70.g6367777092d9
