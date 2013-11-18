From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: exynos: Remove unwanted EXPORT_SYMBOL
Date: Mon, 18 Nov 2013 17:21:26 +0530
Message-ID: <1384775486-31660-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, sachin.kamat@linaro.org
List-Id: linux-pm@vger.kernel.org

The init functions are linked statically (no support for
dynamic loading) and have no other users. Hence remove
EXPORT_SYMBOL for these functions.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/cpufreq/exynos4210-cpufreq.c |    1 -
 drivers/cpufreq/exynos4x12-cpufreq.c |    1 -
 drivers/cpufreq/exynos5250-cpufreq.c |    1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index f2c75065ce19..dfd1643b0b2f 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -157,4 +157,3 @@ err_moutcore:
 	pr_debug("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
-EXPORT_SYMBOL(exynos4210_cpufreq_init);
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 8683304ce62c..efad5e657f6f 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -211,4 +211,3 @@ err_moutcore:
 	pr_debug("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
-EXPORT_SYMBOL(exynos4x12_cpufreq_init);
diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 9fae466d7746..8feda86fe42c 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -236,4 +236,3 @@ err_moutcore:
 	pr_err("%s: failed initialization\n", __func__);
 	return -EINVAL;
 }
-EXPORT_SYMBOL(exynos5250_cpufreq_init);
-- 
1.7.9.5

