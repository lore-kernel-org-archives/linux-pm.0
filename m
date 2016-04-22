From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/9] cpufreq: dt: Mark platdev machines array as __initconst
Date: Fri, 22 Apr 2016 16:58:39 +0530
Message-ID: <acd42b2684729379fa8d07e22ae524b3e2c928c8.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The machines array in cpufreq-dt-platdev is used only once at boot time
and so should be marked with __initconst, so that kernel can free up
memory used for it, if required.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae7ad99a3c..00da8c8bee6c 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -11,7 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-static const struct of_device_id machines[] = {
+static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
 	{ .compatible = "samsung,exynos4212", },
-- 
2.7.1.410.g6faf27b
