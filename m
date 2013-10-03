From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 78/92] cpufreq: dbx500: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:12 +0530
Message-ID: <89b857e87f9980fde2dd4e0f7d0e51b3c316ab69.1380783079.git.viresh.kumar@linaro.org>
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index ae1aa60..a60f769 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -74,26 +74,7 @@ static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
 
 static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int res;
-
-	/* get policy fields based on the table */
-	res = cpufreq_table_validate_and_show(policy, freq_table);
-	if (res) {
-		pr_err("dbx500-cpufreq: Failed to read policy table\n");
-		return res;
-	}
-
-	/*
-	 * FIXME : Need to take time measurement across the target()
-	 *	   function with no/some/all drivers in the notification
-	 *	   list.
-	 */
-	policy->cpuinfo.transition_latency = 20 * 1000; /* in ns */
-
-	/* policy sharing between dual CPUs */
-	cpumask_setall(policy->cpus);
-
-	return 0;
+	return cpufreq_generic_init(policy, freq_table, 20 * 1000);
 }
 
 static struct cpufreq_driver dbx500_cpufreq_driver = {
-- 
1.7.12.rc2.18.g61b472e

