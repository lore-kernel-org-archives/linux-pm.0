From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 37/44] cpufreq: tegra: use cpufreq_table_validate_and_show()
Date: Mon, 16 Sep 2013 18:56:39 +0530
Message-ID: <bc57d8e446d63275d2c832a15fa28208adb56aa3.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379309339.git.viresh.kumar@linaro.org>
References: <cover.1379309339.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index a7b876f..d45c1d8 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -215,8 +215,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 	clk_prepare_enable(emc_clk);
 	clk_prepare_enable(cpu_clk);
 
-	cpufreq_frequency_table_cpuinfo(policy, freq_table);
-	cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
+	cpufreq_table_validate_and_show(policy, freq_table);
 	policy->cur = tegra_getspeed(policy->cpu);
 	target_cpu_speed[policy->cpu] = policy->cur;
 
-- 
1.7.12.rc2.18.g61b472e

