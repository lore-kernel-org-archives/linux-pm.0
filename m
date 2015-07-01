From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 3/4] ARM: Exynos: switch to using generic cpufreq driver for
 Exynos5250
Date: Wed, 01 Jul 2015 15:10:37 +0200
Message-ID: <1435756238-845-4-git-send-email-b.zolnierkie@samsung.com>
References: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49656 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbbGANN6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 09:13:58 -0400
In-reply-to: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic CPUfreq driver.
Switch Exynos5250 to using generic cpufreq driver.

Changes by Bartlomiej:
- split Exynos5250 support from the original patch

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 5f8ddcd..4015ec3 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -226,6 +226,7 @@ static void __init exynos_init_irq(void)
 
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 	{ /* sentinel */ }
 };
 
-- 
1.9.1

