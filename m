From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/7] cpufreq: dt: Identify cpu-sharing for platforms without operating-points-v2
Date: Wed, 27 Apr 2016 08:52:24 +0530
Message-ID: <63799f4fb97a958852ab5f5c055358f669da4772.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, sboyd@codeaurora.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Existing platforms, which do not support operating-points-v2, can
explicitly tell the opp core that some of the CPUs share opp tables,
with help of dev_pm_opp_set_sharing_cpus().

For such platforms, explicitly ask the opp core to provide list of CPUs
sharing the opp table with current cpu device, before falling back to
platform data.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 5f8dbe640a20..aca9bec00f91 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -147,7 +147,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
-	bool opp_v1 = false;
+	bool fallback = false;
 	const char *name;
 	int ret;
 
@@ -167,14 +167,16 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
+		if (ret != -ENOENT)
+			goto out_put_clk;
+
 		/*
 		 * operating-points-v2 not supported, fallback to old method of
-		 * finding shared-OPPs for backward compatibility.
+		 * finding shared-OPPs for backward compatibility if the
+		 * platform hasn't set sharing CPUs.
 		 */
-		if (ret == -ENOENT)
-			opp_v1 = true;
-		else
-			goto out_put_clk;
+		if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
+			fallback = true;
 	}
 
 	/*
@@ -214,7 +216,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
-	if (opp_v1) {
+	if (fallback) {
 		struct cpufreq_dt_platform_data *pd = cpufreq_get_driver_data();
 
 		if (!pd || !pd->independent_clocks)
-- 
2.7.1.410.g6faf27b
