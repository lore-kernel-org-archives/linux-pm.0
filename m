From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 05/11] cpufreq: tegra20: Release clocks properly
Date: Fri, 18 May 2018 23:06:36 +0300
Message-ID: <20180518200642.24815-6-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Properly put requested clocks in the module init/exit code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 4b09a8b410c4..ea186d3f0faf 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -161,24 +161,45 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
 
 static int __init tegra_cpufreq_init(void)
 {
+	int err;
+
 	cpu_clk = clk_get_sys(NULL, "cclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
 	pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(pll_x_clk))
-		return PTR_ERR(pll_x_clk);
+	if (IS_ERR(pll_x_clk)) {
+		err = PTR_ERR(pll_x_clk);
+		goto put_cpu;
+	}
 
 	pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(pll_p_clk))
-		return PTR_ERR(pll_p_clk);
+	if (IS_ERR(pll_p_clk)) {
+		err = PTR_ERR(pll_p_clk);
+		goto put_pll_x;
+	}
+
+	err = cpufreq_register_driver(&tegra_cpufreq_driver);
+	if (err)
+		goto put_pll_p;
+
+	return 0;
+
+put_pll_p:
+	clk_put(pll_p_clk);
+put_pll_x:
+	clk_put(pll_x_clk);
+put_cpu:
+	clk_put(cpu_clk);
 
-	return cpufreq_register_driver(&tegra_cpufreq_driver);
+	return err;
 }
 
 static void __exit tegra_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&tegra_cpufreq_driver);
+	clk_put(pll_p_clk);
+	clk_put(pll_x_clk);
 	clk_put(cpu_clk);
 }
 
-- 
2.17.0
