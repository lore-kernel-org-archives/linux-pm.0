From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 05/10] ARM: Exynos: use generic cpufreq driver for Exynos5420
Date: Fri, 04 Dec 2015 18:30:30 +0100
Message-ID: <1449250235-9613-6-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic arm_big_little_dt
cpufreq driver for Exynos5420.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch
- disable cpufreq if big.LITTLE switcher support is enabled

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 1c47aee..6d97145 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -230,6 +230,13 @@ static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
+/*
+ * FIXME: When big.LITTLE switcher is enabled system lockups during
+ * ondemand governor stress testing (observed on ODROID-XU3 board).
+ */
+#ifndef CONFIG_BL_SWITCHER
+	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+#endif
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
