From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 026/228] cpufreq: longhaul: use cpufreq_table_validate_and_show()
Date: Fri, 13 Sep 2013 18:29:32 +0530
Message-ID: <6f33640445b8b2129544a6ade3e365e917a85805.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/longhaul.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 4ada1cc..70b66fd 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -921,13 +921,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = 200000;	/* nsec */
 	policy->cur = calc_speed(longhaul_get_cpu_mult());
 
-	ret = cpufreq_frequency_table_cpuinfo(policy, longhaul_table);
-	if (ret)
-		return ret;
-
-	cpufreq_frequency_table_get_attr(longhaul_table, policy->cpu);
-
-	return 0;
+	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
 
 static int longhaul_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e

