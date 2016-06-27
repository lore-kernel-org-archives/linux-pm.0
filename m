From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC PATCH 3/4] cpufreq: exynos: remove big.LITTLE switcher dependency
Date: Mon, 27 Jun 2016 13:26:09 +0200
Message-ID: <1467026770-5699-4-git-send-email-b.zolnierkie@samsung.com>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nico@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove no longeer needed workaround for big.LITTLE switcher support.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3646b14..88d4090 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -38,10 +38,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "samsung,exynos4212", },
 	{ .compatible = "samsung,exynos4412", },
 	{ .compatible = "samsung,exynos5250", },
-#ifndef CONFIG_BL_SWITCHER
 	{ .compatible = "samsung,exynos5420", },
 	{ .compatible = "samsung,exynos5800", },
-#endif
 
 	{ .compatible = "renesas,emev2", },
 	{ .compatible = "renesas,r7s72100", },
-- 
1.9.1
