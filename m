From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1 02/11] cpufreq: tegra20: Clean up whitespaces in the code
Date: Thu, 17 May 2018 21:00:47 +0300
Message-ID: <20180517180056.13336-3-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove unneeded blank line and replace whitespaces with a tab in the code
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 10793498355e..dd8a76a64a8e 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -203,12 +203,11 @@ static int __init tegra_cpufreq_init(void)
 
 static void __exit tegra_cpufreq_exit(void)
 {
-        cpufreq_unregister_driver(&tegra_cpufreq_driver);
+	cpufreq_unregister_driver(&tegra_cpufreq_driver);
 	clk_put(emc_clk);
 	clk_put(cpu_clk);
 }
 
-
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.17.0
