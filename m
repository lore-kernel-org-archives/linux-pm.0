From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Check  negative value returned by cpufreq_table_find_index_dl()
Date: Mon, 12 Feb 2018 15:51:16 +0530
Message-ID: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

This patch fixes the below Coverity warning:

*** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
1002     					unsigned int target_freq)
1003     {
1004     	int index;
1005     	struct powernv_smp_call_data freq_data;
1006
1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "index" as an index to array "powernv_freqs".
1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
1010     	set_pstate(&freq_data);
1011
1012     	return powernv_freqs[index].frequency;
1013     }

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 29cdec1..69edfe9 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
 	struct powernv_smp_call_data freq_data;
 
 	index = cpufreq_table_find_index_dl(policy, target_freq);
+	if (unlikely(index < 0))
+		index = get_nominal_index();
+
 	freq_data.pstate_id = powernv_freqs[index].driver_data;
 	freq_data.gpstate_id = powernv_freqs[index].driver_data;
 	set_pstate(&freq_data);
-- 
1.8.3.1
