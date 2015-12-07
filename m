From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 8/8] ARM: Exynos: use generic cpufreq driver for
 Exynos5422/5800
Date: Mon, 07 Dec 2015 19:18:20 +0100
Message-ID: <1449512300-17230-9-git-send-email-b.zolnierkie@samsung.com>
References: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45240 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbbLGSU0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 13:20:26 -0500
In-reply-to: <1449512300-17230-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic cpufreq-dt driver
for Exynos5422/5800.

Changes by Bartlomiej:
- split Exynos5800 support from the original patch
- disable cpufreq if big.LITTLE switcher support is enabled
- switch to using cpufreq-dt driver

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 7a89c9d..cec8aeb 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -232,6 +232,7 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
 #ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
+	{ .compatible = "samsung,exynos5800", .data = "cpufreq-dt" },
 #endif
 	{ /* sentinel */ }
 };
-- 
1.9.1

