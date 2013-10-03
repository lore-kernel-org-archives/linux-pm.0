From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 80/92] cpufreq: imx6q: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:14 +0530
Message-ID: <e223f79700b3f6de5bfde5d869508e1d4e9be337.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9d22dfa..d81062f 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -154,18 +154,7 @@ post_notify:
 
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
-
-	ret = cpufreq_table_validate_and_show(policy, freq_table);
-	if (ret) {
-		dev_err(cpu_dev, "invalid frequency table: %d\n", ret);
-		return ret;
-	}
-
-	policy->cpuinfo.transition_latency = transition_latency;
-	cpumask_setall(policy->cpus);
-
-	return 0;
+	return cpufreq_generic_init(policy, freq_table, transition_latency);
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-- 
1.7.12.rc2.18.g61b472e

