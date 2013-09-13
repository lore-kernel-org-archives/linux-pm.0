From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 145/228] cpufreq: spear: use cpufreq_generic_init() routine
Date: Fri, 13 Sep 2013 18:31:31 +0530
Message-ID: <be773b3d7b00a128c366a7b7201c2e255a6f2460.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index aacdb61..2a03158 100644
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
