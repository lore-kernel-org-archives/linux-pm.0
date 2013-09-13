From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 140/228] cpufreq: pmac32: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:26 +0530
Message-ID: <6c271510b5635b33d09b34211ca6e2265932f45c.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pmac32-cpufreq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 672b7f4..6eac1e2 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -392,12 +392,7 @@ static int pmac_cpufreq_target(	struct cpufreq_policy *policy,
 
 static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	if (policy->cpu != 0)
-		return -ENODEV;
-
-	policy->cpuinfo.transition_latency	= transition_latency;
-
-	return cpufreq_table_validate_and_show(policy, pmac_cpu_freqs);
+	return cpufreq_generic_init(policy, pmac_cpu_freqs, transition_latency);
 }
 
 static u32 read_gpio(struct device_node *np)
-- 
1.7.12.rc2.18.g61b472e
