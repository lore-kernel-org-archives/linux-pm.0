From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 3/4] ARM: exynos: Add exynos3250 compatible to use generic
 cpufreq driver
Date: Thu, 25 Sep 2014 16:05:06 +0900
Message-ID: <1411628707-8496-4-git-send-email-cw00.choi@samsung.com>
References: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50367 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaIYHFW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 03:05:22 -0400
In-reply-to: <1411628707-8496-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, kyungmin.park@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>

This patch add exynos3250 compatible string to exynos_cpufreq_matches
for supporting generic cpufreq driver on Exynos3250.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8923d37..1318d69 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -285,6 +285,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-cpu0" },
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-cpu0" },
+	{ .compatible = "samsung,exynos3250", .data = "cpufreq-cpu0" },
 	{ .compatible = "samsung,exynos5440", .data = "exynos5440-cpufreq" },
 	{ /* sentinel */ }
 };
-- 
1.8.0

