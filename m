From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [RFC PATCH 7/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date: Tue,  9 Oct 2018 12:25:02 -0400
Message-ID: <1539102302-9057-8-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency
to be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped
maximum capacity is known as thermal pressure. Enable cpufreq cooling
device to update the thermal pressure in event of a capped
maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd2324..da8de66 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/sched/topology.h>
 
 #include <trace/events/thermal.h>
 
@@ -132,6 +133,21 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
+ * cpufreq_update_sched_max_capacity - update scheduler about change in cpu
+ *					max frequency.
+ * @policy - cpufreq policy whose max frequency is capped.
+ */
+static void cpufreq_update_sched_max_capacity(struct cpufreq_policy *policy)
+{
+	int cpu;
+	unsigned long capacity = (policy->max << SCHED_CAPACITY_SHIFT) /
+					policy->cpuinfo.max_freq;
+
+	for_each_cpu(cpu, policy->cpus)
+		update_maxcap_capacity(cpu, capacity);
+}
+
+/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -175,8 +191,10 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		 */
 		clipped_freq = cpufreq_cdev->clipped_freq;
 
-		if (policy->max > clipped_freq)
+		if (policy->max > clipped_freq) {
 			cpufreq_verify_within_limits(policy, 0, clipped_freq);
+			cpufreq_update_sched_max_capacity(policy);
+		}
 		break;
 	}
 	mutex_unlock(&cooling_list_lock);
-- 
2.1.4
