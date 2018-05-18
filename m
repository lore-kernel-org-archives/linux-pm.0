From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 06/11] cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
Date: Fri, 18 May 2018 23:06:37 +0300
Message-ID: <20180518200642.24815-7-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove checking of the CPU number for consistency as it won't ever fail
unless there is a severe bug in the cpufreq core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index ea186d3f0faf..df25e350c8e6 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -35,8 +35,6 @@ static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = CPUFREQ_TABLE_END },
 };
 
-#define NUM_CPUS	2
-
 static struct clk *cpu_clk;
 static struct clk *pll_x_clk;
 static struct clk *pll_p_clk;
@@ -122,9 +120,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (policy->cpu >= NUM_CPUS)
-		return -EINVAL;
-
 	clk_prepare_enable(cpu_clk);
 
 	/* FIXME: what's the actual transition time? */
-- 
2.17.0
