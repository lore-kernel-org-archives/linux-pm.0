From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 4/4] ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250
 SoC
Date: Wed, 18 Mar 2015 13:51:53 +0100
Message-ID: <1426683113-31209-5-git-send-email-b.zolnierkie@samsung.com>
References: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18327 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbbCRMwf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 08:52:35 -0400
In-reply-to: <1426683113-31209-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Register cpuidle platform device on Exynos3250 SoC allowing EXYNOS
cpuidle driver usage on this SoC.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 90ed2e5..204f0e6 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -244,6 +244,7 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos4212") ||
 	    (of_machine_is_compatible("samsung,exynos4412") &&
 	     of_machine_is_compatible("samsung,trats2")) ||
+	    of_machine_is_compatible("samsung,exynos3250") ||
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-- 
1.8.2.3

