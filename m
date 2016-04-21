From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/8] cpufreq: rockchip: Use generic platdev driver
Date: Thu, 21 Apr 2016 14:13:50 +0530
Message-ID: <fe4bc7afb55990b316b541b7704269b150a016ed.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Heiko Stuebner <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-rockchip/rockchip.c    | 1 -
 drivers/cpufreq/cpufreq-dt-platdev.c | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index 3f07cc5dfe5f..beb71da5d9c8 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -74,7 +74,6 @@ static void __init rockchip_dt_init(void)
 {
 	rockchip_suspend_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-dt", 0, NULL, 0);
 }
 
 static const char * const rockchip_board_dt_compat[] = {
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3d7d459aed25..b831f1463227 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -29,6 +29,13 @@ static const struct of_device_id machines[] = {
 	{ .compatible = "samsung,exynos5800", },
 #endif
 
+	{ .compatible = "rockchip,rk2928", },
+	{ .compatible = "rockchip,rk3066a", },
+	{ .compatible = "rockchip,rk3066b", },
+	{ .compatible = "rockchip,rk3188", },
+	{ .compatible = "rockchip,rk3228", },
+	{ .compatible = "rockchip,rk3288", },
+
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.7.1.410.g6faf27b
