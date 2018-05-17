From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 08/11] cpufreq: tegra20: Remove unneeded variable initialization
Date: Thu, 17 May 2018 21:00:53 +0300
Message-ID: <20180517180056.13336-9-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove unneeded variable initialization solely for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 797c61c74b65..c0a7b5a78aa6 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -84,7 +84,7 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	unsigned long rate = freq_table[index].frequency;
 	unsigned int ifreq = clk_get_rate(pll_p_clk) / 1000;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
-- 
2.17.0
