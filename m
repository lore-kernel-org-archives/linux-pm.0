From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] ARM: EXYNOS: Remove incorrect __init annotation from
 cpuidle driver
Date: Mon, 21 Oct 2013 10:53:03 +0900
Message-ID: <003701cece00$479e6d90$d6db48b0$%han@samsung.com>
References: <003601cece00$2affeba0$80ffc2e0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <003601cece00$2affeba0$80ffc2e0$%han@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Tomasz Figa' <t.figa@samsung.com>, 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

When platform_driver_probe() is not used, bind/unbind via sysfs is
enabled.  Thus, __init annotation should be removed from probe().
Also, this patch fixes section mismatch warning.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
- Based against pm-cpuidle branch
- Tested on Exynos5440

 arch/arm/mach-exynos/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 6616e0f..ddbfe87 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -193,7 +193,7 @@ static void __init exynos5_core_down_clk(void)
 	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
 }
 
-static int __init exynos_cpuidle_probe(struct platform_device *pdev)
+static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int cpu_id, ret;
 	struct cpuidle_device *device;
-- 
1.7.10.4
