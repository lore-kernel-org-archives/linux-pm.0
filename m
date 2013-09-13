From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 172/228] cpufreq: s3c2416: Convert to light weight ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:58 +0530
Message-ID: <9e42a0a329defc8f0934c0b64f116d0da83a658d.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c2416-cpufreq.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 26a35d1..4188acc 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -217,24 +217,15 @@ static int s3c2416_cpufreq_leave_dvs(struct s3c2416_data *s3c_freq, int idx)
 }
 
 static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
-				      unsigned int target_freq,
-				      unsigned int relation)
+				      unsigned int index)
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
 	struct cpufreq_freqs freqs;
 	int idx, ret, to_dvs = 0;
-	unsigned int i;
 
 	mutex_lock(&cpufreq_lock);
 
-	pr_debug("cpufreq: to %dKHz, relation %d\n", target_freq, relation);
-
-	ret = cpufreq_frequency_table_target(policy, s3c_freq->freq_table,
-					     target_freq, relation, &i);
-	if (ret != 0)
-		goto out;
-
-	idx = s3c_freq->freq_table[i].driver_data;
+	idx = s3c_freq->freq_table[index].driver_data;
 
 	if (idx == SOURCE_HCLK)
 		to_dvs = 1;
@@ -256,7 +247,7 @@ static int s3c2416_cpufreq_set_target(struct cpufreq_policy *policy,
 	 */
 	freqs.new = (s3c_freq->is_dvs && !to_dvs)
 				? clk_get_rate(s3c_freq->hclk) / 1000
-				: s3c_freq->freq_table[i].frequency;
+				: s3c_freq->freq_table[index].frequency;
 
 	pr_debug("cpufreq: Transition %d-%dkHz\n", freqs.old, freqs.new);
 
@@ -505,7 +496,7 @@ err_hclk:
 static struct cpufreq_driver s3c2416_cpufreq_driver = {
 	.flags          = 0,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= s3c2416_cpufreq_set_target,
+	.target_index	= s3c2416_cpufreq_set_target,
 	.get		= s3c2416_cpufreq_get_speed,
 	.init		= s3c2416_cpufreq_driver_init,
 	.name		= "s3c2416",
-- 
1.7.12.rc2.18.g61b472e
