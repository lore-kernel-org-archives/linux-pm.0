From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH V3 2/4] cpufreq: exynos: Remove error return even if no soc is found
Date: Thu,  7 Mar 2013 09:43:45 +0530
Message-ID: <1362629627-10012-2-git-send-email-amit.daniel@samsung.com>
References: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362629627-10012-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Inderpal Singh <inderpal.singh@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch helps to have single binary for exynos5440 and previous
exynos soc's. This change is needed for adding exynos5440 cpufreq driver
which does not uses exynos-cpufreq common file and adds it own driver.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 78057a3..ee75997 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -297,7 +297,7 @@ static int __init exynos_cpufreq_init(void)
 	else if (soc_is_exynos5250())
 		ret = exynos5250_cpufreq_init(exynos_info);
 	else
-		pr_err("%s: CPU type not found\n", __func__);
+		return 0;
 
 	if (ret)
 		goto err_vdd_arm;
-- 
1.7.1
