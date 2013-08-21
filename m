From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/14] cpufreq: spear: use cpufreq_generic_init() routine
Date: Wed, 21 Aug 2013 20:12:32 +0530
Message-ID: <008f055ed70032794385522d6c42248d7c2510f8.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1377093938.git.viresh.kumar@linaro.org>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, spear-devel@list.st.com
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: spear-devel@list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 4ad35a5..d9a8c5f 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -156,18 +156,8 @@ static int spear_cpufreq_target(struct cpufreq_policy *policy,
 
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
