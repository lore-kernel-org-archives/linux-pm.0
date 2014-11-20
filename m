From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/4] ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC
Date: Thu, 20 Nov 2014 16:11:49 +0100
Message-ID: <1416496309-27602-5-git-send-email-b.zolnierkie@samsung.com>
References: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
cpuidle driver usage on this SoC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 847cd0a..6efdbbe 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -297,6 +297,7 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos4212") ||
 	    (of_machine_is_compatible("samsung,exynos4412") &&
 	     of_machine_is_compatible("samsung,trats2")) ||
+	    of_machine_is_compatible("samsung,exynos3250") ||
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.8.2.3
