From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 5/5] ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12
 SoCs
Date: Fri, 05 Sep 2014 15:51:28 +0200
Message-ID: <1409925088-4705-6-git-send-email-b.zolnierkie@samsung.com>
References: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1409925088-4705-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Register cpuidle platform device on Exynos4x12 SoCs allowing EXYNOS
cpuidle driver usage on these SoCs.

AFTR mode reduces power consumption on Trats2 board (Exynos4412 SoC
with secure firmware enabled) by ~12% when EXYNOS cpuidle driver is
enabled (in both cases the default exynos_defconfig config is used
and CPU1-3 are offlined).

Currently Exynos4412 SoC support is limited to Trats2 board.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
v6:
- limit Exynos4412 SoC support to Trats2 board for now

 arch/arm/mach-exynos/exynos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 6a24e11..f5a78d7 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -317,7 +317,10 @@ static void __init exynos_dt_machine_init(void)
 		exynos_sysram_init();
 
 	if (of_machine_is_compatible("samsung,exynos4210") ||
-			of_machine_is_compatible("samsung,exynos5250"))
+	    of_machine_is_compatible("samsung,exynos4212") ||
+	    (of_machine_is_compatible("samsung,exynos4412") &&
+	     of_machine_is_compatible("samsung,trats2")) ||
+	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
 	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-- 
1.8.2.3
