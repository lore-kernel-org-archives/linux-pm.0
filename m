From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] cpufreq: dt: Check OPP count before marking them shared
Date: Wed,  2 Sep 2015 14:36:48 +0530
Message-ID: <e0d14cbedb773c0f18fa9b1380e3e3ccd78bbb4c.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1441184706.git.viresh.kumar@linaro.org>
References: <cover.1441184706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We need to explicitly mark OPPs as shared, when they are not defined
with OPP-v2 bindings. But this isn't required to be done if we failed to
initialize OPP table.

Reorder code to verify OPP count before marking them shared.

Fixes: 2e02d8723edf ("cpufreq: dt: Add support for operating-points-v2 bindings")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cdfadbd..8c38b5192baa 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -239,6 +239,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	of_cpumask_init_opp_table(policy->cpus);
 
+	/*
+	 * But we need OPP table to function so if it is not there let's
+	 * give platform code chance to provide it for us.
+	 */
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		pr_debug("OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_opp;
+	}
+
 	if (need_update) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
 
@@ -256,17 +267,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		transition_latency = dev_pm_opp_get_max_clock_latency(cpu_dev);
 	}
 
-	/*
-	 * But we need OPP table to function so if it is not there let's
-	 * give platform code chance to provide it for us.
-	 */
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
-		pr_debug("OPP table is not ready, deferring probe\n");
-		ret = -EPROBE_DEFER;
-		goto out_free_opp;
-	}
-
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-- 
2.4.0
