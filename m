From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 81/92] cpufreq: kirkwood: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:15 +0530
Message-ID: <0717b07202e390a4854505da1ff6a777ad4c5544.1380783079.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/kirkwood-cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index dc434c4..fff8653 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -120,10 +120,7 @@ static int kirkwood_cpufreq_target(struct cpufreq_policy *policy,
 /* Module init and exit code */
 static int kirkwood_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 5000; /* 5uS */
-
-	return cpufreq_table_validate_and_show(policy, kirkwood_freq_table);
+	return cpufreq_generic_init(policy, kirkwood_freq_table, 5000);
 }
 
 static struct cpufreq_driver kirkwood_cpufreq_driver = {
-- 
1.7.12.rc2.18.g61b472e

