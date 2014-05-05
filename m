From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/7] ARM: EXYNOS: add support for firmware-assisted c15resume
Date: Mon, 05 May 2014 12:57:14 +0200
Message-ID: <1399287439-31376-3-git-send-email-b.zolnierkie@samsung.com>
References: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1399287439-31376-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

From: Tomasz Figa <t.figa@samsung.com>

This change is a preparation for adding secure firmware support to
EXYNOS cpuidle driver.

This patch shouldn't cause any functionality changes.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
[bzolnier: splitted out from bigger patch]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/include/asm/firmware.h | 4 ++++
 arch/arm/mach-exynos/firmware.c | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index c72ec47..70883c7 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -41,6 +41,10 @@ struct firmware_ops {
 	 * Initializes L2 cache
 	 */
 	int (*l2x0_init)(void);
+	/*
+	 * Restores coprocessor 15 registers
+	 */
+	int (*c15resume)(u32 *regs);
 };
 
 /* Global pointer for current firmware_ops structure, can't be NULL. */
diff --git a/arch/arm/mach-exynos/firmware.c b/arch/arm/mach-exynos/firmware.c
index 932129e..581c7bf 100644
--- a/arch/arm/mach-exynos/firmware.c
+++ b/arch/arm/mach-exynos/firmware.c
@@ -40,10 +40,18 @@ static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
+static int exynos_c15resume(u32 *regs)
+{
+	exynos_smc(SMC_CMD_C15RESUME, regs[0], regs[1], 0);
+
+	return 0;
+}
+
 static const struct firmware_ops exynos_firmware_ops = {
 	.do_idle		= exynos_do_idle,
 	.set_cpu_boot_addr	= exynos_set_cpu_boot_addr,
 	.cpu_boot		= exynos_cpu_boot,
+	.c15resume	= exynos_c15resume,
 };
 
 void __init exynos_firmware_init(void)
-- 
1.8.2.3
