From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/7] ARM: EXYNOS: PM: use c15resume firmware method if secure
 firmware is enabled
Date: Mon, 05 May 2014 12:57:17 +0200
Message-ID: <1399287439-31376-6-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36485 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbaEEK7k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 May 2014 06:59:40 -0400
In-reply-to: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com

Use c15resume firmware method instead of accessing the registers
directly in exynos_cpu_restore_register() if secure firmware is
enabled.  This affects both PM resume method and cpuidle AFTR mode.

This patch shouldn't cause any functionality changes on boards that
don't use secure firmware.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 1679c51..18f6bf8 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -26,6 +26,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
+#include <asm/firmware.h>
 
 #include <plat/cpu.h>
 #include <plat/pm-common.h>
@@ -167,6 +168,9 @@ static void exynos_cpu_restore_register(void)
 {
 	unsigned long tmp;
 
+	if (call_firmware_op(c15resume, save_arm_register) == 0)
+		return;
+
 	/* Restore Power control register */
 	tmp = save_arm_register[0];
 
-- 
1.8.2.3

