From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 3/7] ARM: EXYNOS: add AFTR mode support to firmware do_idle
 method
Date: Mon, 05 May 2014 12:57:15 +0200
Message-ID: <1399287439-31376-4-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On some platforms (i.e. EXYNOS ones) more than one idle mode is
available and we need to distinguish them in firmware do_idle method.

Add mode parameter to do_idle firmware method and AFTR mode support
to EXYNOS do_idle implementation.

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

This patch shouldn't cause any functionality changes (please note
that do_idle firmware method is unused currently).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/include/asm/firmware.h |  7 ++++++-
 arch/arm/mach-exynos/firmware.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 70883c7..63989c3 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -28,7 +28,7 @@ struct firmware_ops {
 	/*
 	 * Enters CPU idle mode
 	 */
-	int (*do_idle)(void);
+	int (*do_idle)(int mode);
 	/*
 	 * Sets boot address of specified physical CPU
 	 */
@@ -47,6 +47,11 @@ struct firmware_ops {
 	int (*c15resume)(u32 *regs);
 };
 
+enum {
+	FW_DO_IDLE_NORMAL,
+	FW_DO_IDLE_AFTR,
+};
+
 /* Global pointer for current firmware_ops structure, can't be NULL. */
 extern const struct firmware_ops *firmware_ops;
 
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 581c7bf..71fe169 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -20,9 +20,15 @@
 
 #include "smc.h"
 
-static int exynos_do_idle(void)
+static int exynos_do_idle(int mode)
 {
-	exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+	switch (mode) {
+	case FW_DO_IDLE_AFTR:
+		exynos_smc(SMC_CMD_CPU0AFTR, 0, 0, 0);
+		break;
+	case FW_DO_IDLE_NORMAL:
+		exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
+	}
 	return 0;
 }
 
-- 
1.8.2.3
