From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/5] cpufreq: exynos5440: don't initialize opp table
Date: Mon, 19 May 2014 11:47:25 +0530
Message-ID: <d6f95326b625df13fb3102ed9e70445eab5470f2.1400480033.git.viresh.kumar@linaro.org>
References: <cover.1400480033.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1400480033.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1400480033.git.viresh.kumar@linaro.org>
References: <cover.1400480033.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, inderpal.s@samsung.com, pavel@ucw.cz, nm@ti.com, chander.kashyap@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

OPP tables are already initialized for CPU0 by cpufreq core and so we don't need
to reinitialize them from exynos5440's driver.

Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index f33f25b..72a4206 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -360,12 +360,6 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		goto err_put_node;
 	}
 
-	ret = of_init_opp_table(dvfs_info->dev);
-	if (ret) {
-		dev_err(dvfs_info->dev, "failed to init OPP table: %d\n", ret);
-		goto err_put_node;
-	}
-
 	ret = dev_pm_opp_init_cpufreq_table(dvfs_info->dev,
 					    &dvfs_info->freq_table);
 	if (ret) {
-- 
2.0.0.rc2
