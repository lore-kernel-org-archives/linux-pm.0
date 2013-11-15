From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [RFC v2 4/4] ARM: SAMSUNG: Register static platform device for ASV for Exynos5
Date: Fri, 15 Nov 2013 17:11:31 +0530
Message-ID: <1384515691-26299-5-git-send-email-sachin.kamat@linaro.org>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, kgene.kim@samsung.com, tomasz.figa@gmail.com, yadi.brar01@gmail.com, sachin.kamat@linaro.org, myungjoo.ham@samsung.com, Yadwinder Singh Brar <yadi.brar@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Yadwinder Singh Brar <yadi.brar@samsung.com>

Since ASV is not a hardware controller, we can't add device tree node
for it. This patch registers a static platform device for Exynos ASV.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 602c5d7111d0..831b7222aab6 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -24,6 +24,7 @@ static void __init exynos5_dt_machine_init(void)
 	struct device_node *i2c_np;
 	const char *i2c_compat = "samsung,s3c2440-i2c";
 	unsigned int tmp;
+	struct platform_device_info devinfo = { .name = "exynos-asv", };
 
 	/*
 	 * Exynos5's legacy i2c controller and new high speed i2c
@@ -47,6 +48,7 @@ static void __init exynos5_dt_machine_init(void)
 	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_full(&devinfo);
 }
 
 static char const *exynos5_dt_compat[] __initdata = {
-- 
1.7.9.5
