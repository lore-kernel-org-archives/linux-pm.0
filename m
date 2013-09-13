From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 167/228] cpufreq: pasemi: Convert to light weight ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:53 +0530
Message-ID: <22f63c67f0716afd1245ae5efd81c0ec6e2c7684.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 1cca332..17424dd 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -240,19 +240,11 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 }
 
 static int pas_cpufreq_target(struct cpufreq_policy *policy,
-			      unsigned int target_freq,
-			      unsigned int relation)
+			      unsigned int pas_astate_new)
 {
 	struct cpufreq_freqs freqs;
-	int pas_astate_new;
 	int i;
 
-	cpufreq_frequency_table_target(policy,
-				       pas_freqs,
-				       target_freq,
-				       relation,
-				       &pas_astate_new);
-
 	freqs.old = policy->cur;
 	freqs.new = pas_freqs[pas_astate_new].frequency;
 
@@ -282,7 +274,7 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 	.init		= pas_cpufreq_cpu_init,
 	.exit		= pas_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= pas_cpufreq_target,
+	.target_index	= pas_cpufreq_target,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
1.7.12.rc2.18.g61b472e

