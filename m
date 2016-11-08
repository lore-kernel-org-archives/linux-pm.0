From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Tue,  8 Nov 2016 19:03:27 +0530
Message-ID: <1478612008-20703-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Adding fast_switch which does light weight operation to set the desired
pstate. Both global and local pstates are set to the same desired pstate.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes from v2 :
- No changes.
Changes from v1 :
- Removed unnecessary check for index out of bound.

 drivers/cpufreq/powernv-cpufreq.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index d3ffde8..4a4380d 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	spin_lock_init(&gpstates->gpstate_lock);
 	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
 
-	if (ret < 0)
+	if (ret < 0) {
 		kfree(policy->driver_data);
+		return ret;
+	}
 
+	policy->fast_switch_possible = true;
 	return ret;
 }
 
@@ -897,6 +900,20 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	del_timer_sync(&gpstates->timer);
 }
 
+static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
+					unsigned int target_freq)
+{
+	int index;
+	struct powernv_smp_call_data freq_data;
+
+	index = cpufreq_table_find_index_dl(policy, target_freq);
+	freq_data.pstate_id = powernv_freqs[index].driver_data;
+	freq_data.gpstate_id = powernv_freqs[index].driver_data;
+	set_pstate(&freq_data);
+
+	return powernv_freqs[index].frequency;
+}
+
 static struct cpufreq_driver powernv_cpufreq_driver = {
 	.name		= "powernv-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
@@ -904,6 +921,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
 	.exit		= powernv_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= powernv_cpufreq_target_index,
+	.fast_switch	= powernv_fast_switch,
 	.get		= powernv_cpufreq_get,
 	.stop_cpu	= powernv_cpufreq_stop_cpu,
 	.attr		= powernv_cpu_freq_attr,
-- 
2.5.5
