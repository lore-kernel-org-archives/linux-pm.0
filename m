From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 6/7] ARM: EXYNOS: PM: fix register setup on EXYNOS4x12 for AFTR
 mode code
Date: Mon, 05 May 2014 12:57:18 +0200
Message-ID: <1399287439-31376-7-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Add S5P_CENTRAL_SEQ_OPTION register setup for EXYNOS4x12 to AFTR
mode code.  Without this setup AFTR mode doesn't show any benefit
over WFI one.  When this setup is applied AFTR mode reduces power
consumption by ~12% (as measured on Trats2 board).

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 18f6bf8..3922968 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -391,6 +391,10 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 	case CPU_PM_ENTER:
 		if (cpu == 0) {
 			exynos_pm_central_suspend();
+			if (soc_is_exynos4212() || soc_is_exynos4412())
+				__raw_writel(S5P_USE_STANDBY_WFI0 |
+					     S5P_USE_STANDBY_WFE0,
+					     S5P_CENTRAL_SEQ_OPTION);
 			exynos_cpu_save_register();
 		}
 		break;
-- 
1.8.2.3
