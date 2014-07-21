From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/3] ARM: EXYNOS: Enable cpuidle in WFI on all SoCs
Date: Mon, 21 Jul 2014 10:36:10 +0200
Message-ID: <1405931771-24100-2-git-send-email-k.kozlowski@samsung.com>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sachin Kamat <sachin.kamat@samsung.com>, Tushar Behera <tushar.behera@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add cpuidle device for each SoC but set AFTR enter function only on
supported ones (for now these are only Exynos4210 and Exynos5250). For
other chipsets use only WFI.

This actually does not give any special energy-saving benefits but
allows to track the idle time of each core.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2a43a1734eca..4109d592f6fc 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -171,14 +171,20 @@ static void exynos_restart(enum reboot_mode mode, const char *cmd)
 
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
-	.dev.platform_data = exynos_enter_aftr,
+	/*
+	 * Currently AFTR is not implemented for each SoC.
+	 * Set this to exynos_enter_aftr() only for supported SoCs.
+	 */
+	.dev.platform_data = NULL,
 	.id                = -1,
 };
 
 void __init exynos_cpuidle_init(void)
 {
 	if (soc_is_exynos4210() || soc_is_exynos5250())
-		platform_device_register(&exynos_cpuidle);
+		exynos_cpuidle.dev.platform_data = exynos_enter_aftr;
+
+	platform_device_register(&exynos_cpuidle);
 }
 
 void __init exynos_cpufreq_init(void)
-- 
1.9.1
