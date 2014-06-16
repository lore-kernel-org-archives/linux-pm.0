From: Chander Kashyap <k.chander@samsung.com>
Subject: [Patch v7 5/6] exynos: cpuidle: do not allow cpuidle registration for Exynos5420
Date: Mon, 16 Jun 2014 15:56:22 +0530
Message-ID: <1402914383-20471-6-git-send-email-k.chander@samsung.com>
References: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, tomasz.figa@gmail.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Chander Kashyap <chander.kashyap@linaro.org>

Exynos5420 is big.Little Soc. It uses cpuidle-big-litle generic cpuidle driver.
Hence do not allow exynos cpuidle driver registration for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
Changes in v6:
	1. Move cpuidle registration check to exynos.c from cpuidle.c and
	   use "samsung,exynos5420" compatible string to avvoid registration
 arch/arm/mach-exynos/exynos.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 90aab4d..f4c08d6 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -271,7 +271,9 @@ static void __init exynos_dt_machine_init(void)
 		}
 	}
 
-	exynos_cpuidle_init();
+	if (!of_machine_is_compatible("samsung,exynos5420"))
+		exynos_cpuidle_init();
+
 	exynos_cpufreq_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.9.5
