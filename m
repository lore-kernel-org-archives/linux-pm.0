From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 01/11] cpufreq: tegra20: Change module description
Date: Fri, 18 May 2018 23:06:32 +0300
Message-ID: <20180518200642.24815-2-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Change module description to be in line with the other Tegra drivers, just
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 2bd62845e9d5..10793498355e 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -210,7 +210,7 @@ static void __exit tegra_cpufreq_exit(void)
 
 
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
-MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
+MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
 module_init(tegra_cpufreq_init);
 module_exit(tegra_cpufreq_exit);
-- 
2.17.0
