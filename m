From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 3/6] cpufreq: ondemand: Don't keep a copy of freq_table pointer
Date: Thu,  2 Jun 2016 19:34:57 +0530
Message-ID: <63fff92876e6918879dce10169784e44519a6576.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876229.git.viresh.kumar@linaro.org>
References: <cover.1464876229.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is absolutely no need to keep a copy to the freq-table in 'struct
od_policy_dbs_info'. Use policy->freq_table instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/amd_freq_sensitivity.c |  7 +++----
 drivers/cpufreq/cpufreq_ondemand.c     | 22 +++++++++++-----------
 drivers/cpufreq/cpufreq_ondemand.h     |  1 -
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 404360cad25c..bc86816693a8 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -48,9 +48,8 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *od_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = od_data->tuners;
-	struct od_policy_dbs_info *od_info = to_dbs_info(policy_dbs);
 
-	if (!od_info->freq_table)
+	if (!policy->freq_table)
 		return freq_next;
 
 	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_ACTUAL,
@@ -93,9 +92,9 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 			unsigned int index;
 
 			cpufreq_frequency_table_target(policy,
-				od_info->freq_table, policy->cur - 1,
+				policy->freq_table, policy->cur - 1,
 				CPUFREQ_RELATION_H, &index);
-			freq_next = od_info->freq_table[index].frequency;
+			freq_next = policy->freq_table[index].frequency;
 		}
 
 		data->freq_prev = freq_next;
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 4d2fe2710c5d..528353f204fd 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -71,28 +71,29 @@ static unsigned int generic_powersave_bias_target(struct cpufreq_policy *policy,
 	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+	struct cpufreq_frequency_table *freq_table = policy->freq_table;
 
-	if (!dbs_info->freq_table) {
+	if (!freq_table) {
 		dbs_info->freq_lo = 0;
 		dbs_info->freq_lo_delay_us = 0;
 		return freq_next;
 	}
 
-	cpufreq_frequency_table_target(policy, dbs_info->freq_table, freq_next,
-			relation, &index);
-	freq_req = dbs_info->freq_table[index].frequency;
+	cpufreq_frequency_table_target(policy, freq_table, freq_next, relation,
+				       &index);
+	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
 
 	/* Find freq bounds for freq_avg in freq_table */
 	index = 0;
-	cpufreq_frequency_table_target(policy, dbs_info->freq_table, freq_avg,
-			CPUFREQ_RELATION_H, &index);
-	freq_lo = dbs_info->freq_table[index].frequency;
+	cpufreq_frequency_table_target(policy, freq_table, freq_avg,
+				       CPUFREQ_RELATION_H, &index);
+	freq_lo = freq_table[index].frequency;
 	index = 0;
-	cpufreq_frequency_table_target(policy, dbs_info->freq_table, freq_avg,
-			CPUFREQ_RELATION_L, &index);
-	freq_hi = dbs_info->freq_table[index].frequency;
+	cpufreq_frequency_table_target(policy, freq_table, freq_avg,
+				       CPUFREQ_RELATION_L, &index);
+	freq_hi = freq_table[index].frequency;
 
 	/* Find out how long we have to be in hi and lo freqs */
 	if (freq_hi == freq_lo) {
@@ -113,7 +114,6 @@ static void ondemand_powersave_bias_init(struct cpufreq_policy *policy)
 {
 	struct od_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
-	dbs_info->freq_table = policy->freq_table;
 	dbs_info->freq_lo = 0;
 }
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.h b/drivers/cpufreq/cpufreq_ondemand.h
index f0121db3cd9e..640ea4e97106 100644
--- a/drivers/cpufreq/cpufreq_ondemand.h
+++ b/drivers/cpufreq/cpufreq_ondemand.h
@@ -13,7 +13,6 @@
 
 struct od_policy_dbs_info {
 	struct policy_dbs_info policy_dbs;
-	struct cpufreq_frequency_table *freq_table;
 	unsigned int freq_lo;
 	unsigned int freq_lo_delay_us;
 	unsigned int freq_hi_delay_us;
-- 
2.7.1.410.g6faf27b
