From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH RFC 2/5] ARM: mvebu: Use shorter register definition in pmsu.c
Date: Fri,  3 Jul 2015 08:11:54 +0200
Message-ID: <1435903917-20486-3-git-send-email-gregory.clement@free-electrons.com>
References: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55187 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754410AbbGCGMN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 02:12:13 -0400
In-Reply-To: <1435903917-20486-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

The register definition were too verbose. Shorten them in order to
have something more readable and avoiding having most of the
instruction on two lines.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 102 +++++++++++++++++++++++----------------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 4f4e22206ae5..d207f5fc13a6 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -46,27 +46,29 @@
 #define PMSU_REG_SIZE	    0x1000
 
 /* PMSU MP registers */
-#define PMSU_CONTROL_AND_CONFIG(cpu)	    ((cpu * 0x100) + 0x104)
-#define PMSU_CONTROL_AND_CONFIG_DFS_REQ		BIT(18)
-#define PMSU_CONTROL_AND_CONFIG_PWDDN_REQ	BIT(16)
-#define PMSU_CONTROL_AND_CONFIG_L2_PWDDN	BIT(20)
+#define PMSU_CTL_CFG(cpu)		((cpu * 0x100) + 0x104)
+#define PMSU_CTL_CFG_CPU0_FRQ_ID_SFT		4
+#define PMSU_CTL_CFG_CPU0_FRQ_ID_MSK		0xF
+#define PMSU_CTL_CFG_DFS_REQ			BIT(18)
+#define PMSU_CTL_CFG_PWDDN_REQ			BIT(16)
+#define PMSU_CTL_CFG_L2_PWDDN			BIT(20)
 
 #define PMSU_CPU_POWER_DOWN_CONTROL(cpu)    ((cpu * 0x100) + 0x108)
 
 #define PMSU_CPU_POWER_DOWN_DIS_SNP_Q_SKIP	BIT(0)
 
-#define PMSU_STATUS_AND_MASK(cpu)	    ((cpu * 0x100) + 0x10c)
-#define PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT	BIT(16)
-#define PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT	BIT(17)
-#define PMSU_STATUS_AND_MASK_IRQ_WAKEUP		BIT(20)
-#define PMSU_STATUS_AND_MASK_FIQ_WAKEUP		BIT(21)
-#define PMSU_STATUS_AND_MASK_DBG_WAKEUP		BIT(22)
-#define PMSU_STATUS_AND_MASK_IRQ_MASK		BIT(24)
-#define PMSU_STATUS_AND_MASK_FIQ_MASK		BIT(25)
+#define PMSU_STATUS_MSK(cpu)	    ((cpu * 0x100) + 0x10c)
+#define PMSU_STATUS_MSK_CPU_IDLE_WAIT		BIT(16)
+#define PMSU_STATUS_MSK_SNP_Q_EMPTY_WAIT	BIT(17)
+#define PMSU_STATUS_MSK_IRQ_WAKEUP		BIT(20)
+#define PMSU_STATUS_MSK_FIQ_WAKEUP		BIT(21)
+#define PMSU_STATUS_MSK_DBG_WAKEUP		BIT(22)
+#define PMSU_STATUS_MSK_IRQ_MASK		BIT(24)
+#define PMSU_STATUS_MSK_FIQ_MASK		BIT(25)
 
-#define PMSU_EVENT_STATUS_AND_MASK(cpu)     ((cpu * 0x100) + 0x120)
-#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE        BIT(1)
-#define PMSU_EVENT_STATUS_AND_MASK_DFS_DONE_MASK   BIT(17)
+#define PMSU_EVENT_STATUS_MSK(cpu)     ((cpu * 0x100) + 0x120)
+#define PMSU_EVENT_STATUS_MSK_DFS_DONE        BIT(1)
+#define PMSU_EVENT_STATUS_MSK_DFS_DONE_MASK   BIT(17)
 
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu) ((cpu * 0x100) + 0x124)
 
@@ -238,23 +240,23 @@ static int mvebu_v7_pmsu_idle_prepare(unsigned long flags)
 	 * IRQ and FIQ as wakeup events, set wait for snoop queue empty
 	 * indication and mask IRQ and FIQ from CPU
 	 */
-	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
-	reg |= PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT    |
-	       PMSU_STATUS_AND_MASK_IRQ_WAKEUP       |
-	       PMSU_STATUS_AND_MASK_FIQ_WAKEUP       |
-	       PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT |
-	       PMSU_STATUS_AND_MASK_IRQ_MASK         |
-	       PMSU_STATUS_AND_MASK_FIQ_MASK;
-	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
-
-	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+	reg = readl(pmsu_mp_base + PMSU_STATUS_MSK(hw_cpu));
+	reg |= PMSU_STATUS_MSK_CPU_IDLE_WAIT    |
+	       PMSU_STATUS_MSK_IRQ_WAKEUP       |
+	       PMSU_STATUS_MSK_FIQ_WAKEUP       |
+	       PMSU_STATUS_MSK_SNP_Q_EMPTY_WAIT |
+	       PMSU_STATUS_MSK_IRQ_MASK         |
+	       PMSU_STATUS_MSK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_MSK(hw_cpu));
+
+	reg = readl(pmsu_mp_base + PMSU_CTL_CFG(hw_cpu));
 	/* ask HW to power down the L2 Cache if needed */
 	if (flags & PMSU_PREPARE_DEEP_IDLE)
-		reg |= PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
+		reg |= PMSU_CTL_CFG_L2_PWDDN;
 
 	/* request power down */
-	reg |= PMSU_CONTROL_AND_CONFIG_PWDDN_REQ;
-	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+	reg |= PMSU_CTL_CFG_PWDDN_REQ;
+	writel(reg, pmsu_mp_base + PMSU_CTL_CFG(hw_cpu));
 
 	if (flags & PMSU_PREPARE_SNOOP_DISABLE) {
 		/* Disable snoop disable by HW - SW is taking care of it */
@@ -347,17 +349,17 @@ void mvebu_v7_pmsu_idle_exit(void)
 	if (pmsu_mp_base == NULL)
 		return;
 	/* cancel ask HW to power down the L2 Cache if possible */
-	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
-	reg &= ~PMSU_CONTROL_AND_CONFIG_L2_PWDDN;
-	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(hw_cpu));
+	reg = readl(pmsu_mp_base + PMSU_CTL_CFG(hw_cpu));
+	reg &= ~PMSU_CTL_CFG_L2_PWDDN;
+	writel(reg, pmsu_mp_base + PMSU_CTL_CFG(hw_cpu));
 
 	/* cancel Enable wakeup events and mask interrupts */
-	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
-	reg &= ~(PMSU_STATUS_AND_MASK_IRQ_WAKEUP | PMSU_STATUS_AND_MASK_FIQ_WAKEUP);
-	reg &= ~PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT;
-	reg &= ~PMSU_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
-	reg &= ~(PMSU_STATUS_AND_MASK_IRQ_MASK | PMSU_STATUS_AND_MASK_FIQ_MASK);
-	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
+	reg = readl(pmsu_mp_base + PMSU_STATUS_MSK(hw_cpu));
+	reg &= ~(PMSU_STATUS_MSK_IRQ_WAKEUP | PMSU_STATUS_MSK_FIQ_WAKEUP);
+	reg &= ~PMSU_STATUS_MSK_CPU_IDLE_WAIT;
+	reg &= ~PMSU_STATUS_MSK_SNP_Q_EMPTY_WAIT;
+	reg &= ~(PMSU_STATUS_MSK_IRQ_MASK | PMSU_STATUS_MSK_FIQ_MASK);
+	writel(reg, pmsu_mp_base + PMSU_STATUS_MSK(hw_cpu));
 }
 
 static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
@@ -521,16 +523,16 @@ static void mvebu_pmsu_dfs_request_local(void *data)
 	local_irq_save(flags);
 
 	/* Prepare to enter idle */
-	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
-	reg |= PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT |
-	       PMSU_STATUS_AND_MASK_IRQ_MASK     |
-	       PMSU_STATUS_AND_MASK_FIQ_MASK;
-	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+	reg = readl(pmsu_mp_base + PMSU_STATUS_MSK(cpu));
+	reg |= PMSU_STATUS_MSK_CPU_IDLE_WAIT |
+	       PMSU_STATUS_MSK_IRQ_MASK     |
+	       PMSU_STATUS_MSK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_MSK(cpu));
 
 	/* Request the DFS transition */
-	reg = readl(pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
-	reg |= PMSU_CONTROL_AND_CONFIG_DFS_REQ;
-	writel(reg, pmsu_mp_base + PMSU_CONTROL_AND_CONFIG(cpu));
+	reg = readl(pmsu_mp_base + PMSU_CTL_CFG(cpu));
+	reg |= PMSU_CTL_CFG_DFS_REQ;
+	writel(reg, pmsu_mp_base + PMSU_CTL_CFG(cpu));
 
 	/* The fact of entering idle will trigger the DFS transition */
 	wfi();
@@ -539,9 +541,9 @@ static void mvebu_pmsu_dfs_request_local(void *data)
 	 * We're back from idle, the DFS transition has completed,
 	 * clear the idle wait indication.
 	 */
-	reg = readl(pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
-	reg &= ~PMSU_STATUS_AND_MASK_CPU_IDLE_WAIT;
-	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(cpu));
+	reg = readl(pmsu_mp_base + PMSU_STATUS_MSK(cpu));
+	reg &= ~PMSU_STATUS_MSK_CPU_IDLE_WAIT;
+	writel(reg, pmsu_mp_base + PMSU_STATUS_MSK(cpu));
 
 	local_irq_restore(flags);
 }
@@ -569,8 +571,8 @@ int mvebu_pmsu_dfs_request(int cpu)
 	/* Poll until the DFS done event is generated */
 	timeout = jiffies + HZ;
 	while (time_before(jiffies, timeout)) {
-		reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_AND_MASK(hwcpu));
-		if (reg & PMSU_EVENT_STATUS_AND_MASK_DFS_DONE)
+		reg = readl(pmsu_mp_base + PMSU_EVENT_STATUS_MSK(hwcpu));
+		if (reg & PMSU_EVENT_STATUS_MSK_DFS_DONE)
 			break;
 		udelay(10);
 	}
-- 
2.1.0

