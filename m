From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 046/228] cpufreq: tegra: fix implementation of ->exit()
Date: Fri, 13 Sep 2013 18:29:52 +0530
Message-ID: <33874a6a319c05a4fb9eb5b7b5b358548b8b04fc.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

->exit() of drivers should call cpufreq_frequency_table_put_attr() if they have
called cpufreq_frequency_table_get_attr() earlier in init() and they aren't
required to validate their cpufreq table in exit by calling
cpufreq_frequency_table_cpuinfo(). Tegra's driver wasn't calling
cpufreq_frequency_table_put_attr() and was calling
cpufreq_frequency_table_cpuinfo() in exit.

Fix both these issues in it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index d45c1d8..e014077 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -232,7 +232,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
-	cpufreq_frequency_table_cpuinfo(policy, freq_table);
+	cpufreq_frequency_table_put_attr(policy->cpu);
 	clk_disable_unprepare(emc_clk);
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e
