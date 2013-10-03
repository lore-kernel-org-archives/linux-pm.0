From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 91/92] cpufreq: spear: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:42:10 +0530
Message-ID: <40c50afd4421e4029b61543bc1ea9ae15d4f5c6d.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
 <854d6e8fa69d7d7d6dcd3c5461deaeed8d0f9b5b.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <854d6e8fa69d7d7d6dcd3c5461deaeed8d0f9b5b.1380783079.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/spear-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 34f04f4..8841366 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -171,18 +171,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 
 static int spear_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
-
-	ret = cpufreq_table_validate_and_show(policy, spear_cpufreq.freq_tbl);
-	if (ret) {
-		pr_err("cpufreq_table_validate_and_show() failed");
-		return ret;
-	}
-
-	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
-	cpumask_setall(policy->cpus);
-
-	return 0;
+	return cpufreq_generic_init(policy, spear_cpufreq.freq_tbl,
+			spear_cpufreq.transition_latency);
 }
 
 static struct cpufreq_driver spear_cpufreq_driver = {
-- 
1.7.12.rc2.18.g61b472e

