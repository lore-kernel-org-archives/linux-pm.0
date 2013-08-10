From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/44] cpufreq: omap: call cpufreq_frequency_table_put_attr()
Date: Sat, 10 Aug 2013 12:14:01 +0530
Message-ID: <813a5373449195cdefa62490df1c0ce5f6db58aa.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-pm@vger.kernel.org

Drivers which have an exit path must call cpufreq_frequency_table_put_attr() if
they have called cpufreq_frequency_table_get_attr() in their init path.

This driver was missing this part and is fixed with this patch.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index b68ce4e..091f233 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -221,6 +221,7 @@ fail_ck:
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	freq_table_free();
 	clk_put(mpu_clk);
 	return 0;
-- 
1.7.12.rc2.18.g61b472e
