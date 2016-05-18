From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH] cpufreq: powernv: Add fast_switch callback
Date: Wed, 18 May 2016 18:23:40 +0530
Message-ID: <1463576020-18597-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Add fast_switch driver callback to support frequency update in
interrupt context while using schedutil governor. Changing frequency
in interrupt context will remove the jitter on the workloads which can
be seen when a kworker thread is used for the changing the frequency.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 54c4536..4553eb6 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -678,6 +678,8 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	for (i = 0; i < threads_per_core; i++)
 		cpumask_set_cpu(base + i, policy->cpus);
 
+	policy->fast_switch_possible = true;
+
 	kn = kernfs_find_and_get(policy->kobj.sd, throttle_attr_grp.name);
 	if (!kn) {
 		int ret;
@@ -854,6 +856,24 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	del_timer_sync(&gpstates->timer);
 }
 
+static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	int index;
+	struct powernv_smp_call_data freq_data;
+
+	cpufreq_frequency_table_target(policy, policy->freq_table,
+				       target_freq,
+				       CPUFREQ_RELATION_C, &index);
+	if (index < 0 || index >= powernv_pstate_info.nr_pstates)
+		return CPUFREQ_ENTRY_INVALID;
+	freq_data.pstate_id = powernv_freqs[index].driver_data;
+	freq_data.gpstate_id = powernv_freqs[index].driver_data;
+	set_pstate(&freq_data);
+
+	return pstate_id_to_freq(-index);
+}
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -861,6 +881,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.exit		= powernv_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
+	.fast_switch	= powernv_fast_switch,
 	.get		= powernv_cpufreq_get,
 	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
-- 
1.9.3
