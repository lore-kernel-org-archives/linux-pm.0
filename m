From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/5] ARM: EXYNOS: make exynos_core_restart() less verbose
Date: Fri, 20 Feb 2015 17:22:18 +0100
Message-ID: <1424449341-7782-3-git-send-email-b.zolnierkie@samsung.com>
References: <1424449341-7782-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424449341-7782-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

There is a kernel message about secondary CPU bootup when
exynos_core_restart() is called through CPU hotplug code-path
(the only exynos_core_restart() user currently) so there is no
need for an extra info on Exynos3250 SoC about software reset.
This also prepares exynos_core_restart() to be re-used in
coupled cpuidle code-path in the future.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/platsmp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 5b196fd..74b3351 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -211,7 +211,6 @@ static void exynos_core_restart(u32 core_id)
 	val |= S5P_CORE_WAKEUP_FROM_LOCAL_CFG;
 	pmu_raw_writel(val, EXYNOS_ARM_CORE_STATUS(core_id));
 
-	pr_info("CPU%u: Software reset\n", core_id);
 	pmu_raw_writel(EXYNOS_CORE_PO_RESET(core_id), EXYNOS_SWRESET);
 }
 
-- 
1.8.2.3
