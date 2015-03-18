From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 4/4] ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250
 SoC
Date: Wed, 18 Mar 2015 17:00:53 +0100
Message-ID: <1426694453-3242-5-git-send-email-b.zolnierkie@samsung.com>
References: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426694453-3242-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
cpuidle driver usage on this SoC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4031a96..a140872 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -219,6 +219,7 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos4212") ||
 	    (of_machine_is_compatible("samsung,exynos4412") &&
 	     of_machine_is_compatible("samsung,trats2")) ||
+	    of_machine_is_compatible("samsung,exynos3250") ||
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.8.2.3
