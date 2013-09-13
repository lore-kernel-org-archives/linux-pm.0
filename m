From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 217/228] cpufreq: davinci: use cpufreq_generic_get() routine
Date: Fri, 13 Sep 2013 18:32:43 +0530
Message-ID: <9306a1c54e69d9fc30afe77c023d0780c84592d7.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pm@vger.kernel.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 5e8a854..cd7fb6e 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -58,14 +58,6 @@ static int davinci_verify_speed(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static unsigned int davinci_getspeed(unsigned int cpu)
-{
-	if (cpu)
-		return 0;
-
-	return clk_get_rate(cpufreq.armclk) / 1000;
-}
-
 static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
@@ -73,7 +65,7 @@ static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 	unsigned int old_freq, new_freq;
 	int ret = 0;
 
-	old_freq = davinci_getspeed(0);
+	old_freq = policy->cur;
 	new_freq = pdata->freq_table[idx].frequency;
 
 	/* if moving to higher frequency, up the voltage beforehand */
@@ -116,6 +108,8 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 			return result;
 	}
 
+	policy->clk = cpufreq.armclk;
+
 	/*
 	 * Time measurement across the target() function yields ~1500-1800us
 	 * time taken with no drivers on notification list.
@@ -129,7 +123,7 @@ static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= davinci_verify_speed,
 	.target_index	= davinci_target,
-	.get		= davinci_getspeed,
+	.get		= cpufreq_generic_get,
 	.init		= davinci_cpu_init,
 	.exit		= cpufreq_generic_exit,
 	.name		= "davinci",
-- 
1.7.12.rc2.18.g61b472e
