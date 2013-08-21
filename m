From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/14] cpufreq: dbx500: use cpufreq_generic_init() routine
Date: Wed, 21 Aug 2013 20:12:22 +0530
Message-ID: <580c144ac4a85899ddc3d6350e50761c9d69b1fe.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index f66cb72..0e67ab9 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -44,26 +44,7 @@ static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
 
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
