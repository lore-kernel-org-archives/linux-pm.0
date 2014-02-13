From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 09/13] ARM: mvebu: Add the PMSU related part of the cpu idle functions
Date: Thu, 13 Feb 2014 18:33:32 +0100
Message-ID: <1392312816-17657-10-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51923 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638AbaBMReI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:08 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

The cpu idle support will need to access to Power Management Service
Unit. This commit adds the prepare and restore functions that will be
used in the idle path of the cpuidle driver.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 36d946d53f54..ec745d59fea8 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -29,6 +29,24 @@ static void __iomem *pmsu_reset_base;
 static void __iomem *pmsu_fabric_base;
 
 /* PMSU MP registers */
+#define PMSU_CONTROL_AND_CONFIG(cpu)	    ((cpu * 0x100) + 0x4)
+#define PMSU_CONTROL_AND_CONFIG_DFS_REQ		BIT(18)
+#define PMSU_CONTROL_AND_CONFIG_PWDDN_REQ	BIT(16)
+#define PMSU_CONTROL_AND_CONFIG_L2_PWDDN	BIT(20)
+
+#define PMSU_CPU_POWER_DOWN_CONTROL(cpu)    ((cpu * 0x100) + 0x8)
+
+#define PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP	BIT(0)
+
+#define PMSU_STATUS_AND_MASK(cpu)	    ((cpu * 0x100) + 0xc)
+#define PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT	BIT(16)
+#define PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT	BIT(17)
+#define PMSU_STATUS_AND_MASK_IRQ_WAKEUP		BIT(20)
+#define PMSU_STATUS_AND_MASK_FIQ_WAKEUP		BIT(21)
+#define PMSU_STATUS_AND_MASK_DBG_WAKEUP		BIT(22)
+#define PMSU_STATUS_AND_MASK_IRQ_MASK		BIT(24)
+#define PMSU_STATUS_AND_MASK_FIQ_MASK		BIT(25)
+
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x24)
 
 /* PMSU reset registers */
@@ -99,4 +117,71 @@ void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 	writel(reg, pmsu_fabric_base + L2C_NFABRIC_PM_CTL);
 }
 
+static void armada_370_xp_cpu_resume(void)
+{
+	asm volatile("bl    ll_set_cpu_coherent_and_smp\n\t"
+		     "b	    cpu_resume\n\t");
+}
+
+/* No locking is needed because we only access per-CPU registers */
+void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	u32 reg;
+
+	if (pmsu_mp_base == NULL)
+		return;
+
+	/*
+	 * Adjust the PMSU configuration to wait for WFI signal, enable
+	 * IRQ and FIQ as wakeup events, set wait for snoop queue empty
+	 * indication and mask IRQ and FIQ from CPU
+	 */
+	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
+	reg |= PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT    |
+	       PMSU_STATUS_AND_MASK_IRQ_WAKEUP       |
+	       PMSU_STATUS_AND_MASK_FIQ_WAKEUP       |
+	       PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT |
+	       PMSU_STATUS_AND_MASK_IRQ_MASK         |
+	       PMSU_STATUS_AND_MASK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
+
+	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+	/* ask HW to power down the L2 Cache if needed */
+	if (deepidle)
+		reg |= PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
+
+	/* request power down */
+	reg |= PMSU_CONTROL_AND_CONFIG_PWDDN_REQ;
+	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* Disable snoop disable by HW - SW is taking care of it */
+	reg = readl(pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	reg |= PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
+	writel(reg, pmsu_mp_base + PMSU_CPU_POWER_DOWN_CONTROL(hw_cpu));
+}
+
+/* No locking is needed because we only access per-CPU registers */
+static noinline void armada_370_xp_pmsu_idle_restore(void)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	u32 reg;
+
+	if (pmsu_mp_base == NULL)
+		return;
+
+	/* cancel ask HW to power down the L2 Cache if possible */
+	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+	reg &= ~PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
+	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* cancel Enable wakeup events and mask interrupts */
+	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
+	reg &= ~(PMSU_STATUS_AND_MASK_IRQ_WAKEUP | PMSU_STATUS_AND_MASK_FIQ_WAKEUP);
+	reg &= ~PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT;
+	reg &= ~PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
+	reg &= ~(PMSU_STATUS_AND_MASK_IRQ_MASK | PMSU_STATUS_AND_MASK_FIQ_MASK);
+	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
+}
+
 early_initcall(armada_370_xp_pmsu_init);
-- 
1.8.1.2

