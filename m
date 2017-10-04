From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 7/7] cpufreq: dt: Remove support for Exynos4212 SoCs
Date: Wed, 04 Oct 2017 08:38:28 +0200
Message-ID: <20171004063828.22068-8-m.szyprowski@samsung.com>
References: <20171004063828.22068-1-m.szyprowski@samsung.com>
        <CGME20171004063837eucas1p2a2c9dbc268fbb37da5253c329a0a8683@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54548 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdJDGik (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 02:38:40 -0400
In-reply-to: <20171004063828.22068-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

Support for Exynos4212 SoCs has been removed by commit bca9085e0ae9 ("ARM:
dts: exynos: remove Exynos4212 support (dead code)"), so there is no need
to keep remaining dead code related to this SoC version.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a753c50e9e41..4946ac528b72 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -48,7 +48,6 @@ static const struct of_device_id whitelist[] __initconst = {
 
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
-	{ .compatible = "samsung,exynos4212", },
 	{ .compatible = "samsung,exynos5250", },
 #ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5800", },
-- 
2.14.2
