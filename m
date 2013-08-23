From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 09/12] ARM: mvebu: Add the PMSU related part of the cpu idle functions
Date: Fri, 23 Aug 2013 08:53:14 +0200
Message-ID: <1377240797-4047-10-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47902 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754869Ab3HWGxn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 02:53:43 -0400
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

The cpu idle support will need to acces to the Power Mangement Service
Unit. This commit adds and exports the prepare and restore functions
that will be used by the CPU idle.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c         | 70 ++++++++++++++++++++++++++++++++++++++
 include/linux/armada-370-xp-pmsu.h |  2 ++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index bb7f606..974740e 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -30,6 +30,24 @@ static void __iomem *pmsu_fabric_base;
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
 
+#define PM_CONTROL_AND_CONFIG(cpu)	((cpu * 0x100) + 0x4)
+#define PM_CONTROL_AND_CONFIG_DFS_REQ		(1 << 18)
+#define PM_CONTROL_AND_CONFIG_PWDDN_REQ	(1 << 16)
+#define PM_CONTROL_AND_CONFIG_L2_PWDDN		(1 << 20)
+
+#define PM_CPU_POWER_DOWN_CONTROL(cpu)	((cpu * 0x100) + 0x8)
+
+#define PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP	(1 << 0)
+
+#define PM_STATUS_AND_MASK(cpu)	((cpu * 0x100) + 0xc)
+#define PM_STATUS_AND_MASK_CPU_IDLE_WAIT	(1 << 16)
+#define PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT	(1 << 17)
+#define PM_STATUS_AND_MASK_IRQ_WAKEUP		(1 << 20)
+#define PM_STATUS_AND_MASK_FIQ_WAKEUP		(1 << 21)
+#define PM_STATUS_AND_MASK_DBG_WAKEUP		(1 << 22)
+#define PM_STATUS_AND_MASK_IRQ_MASK		(1 << 24)
+#define PM_STATUS_AND_MASK_FIQ_MASK		(1 << 25)
+
 #define L2C_NFABRIC_PM_CTL		    0x4
 #define L2C_NFABRIC_PM_CTL_PWR_DOWN	    (1 << 20)
 
@@ -91,4 +109,56 @@ void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void)
 }
 EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_enable_l2_powerdown_onidle);
 
+void armada_370_xp_pmsu_idle_prepare(bool deepidle)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	int reg;
+
+	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+	/* set WaitMask fields - wait for WFI signal */
+	reg |= PM_STATUS_AND_MASK_CPU_IDLE_WAIT;
+	/* enable wakeup events */
+	reg |= PM_STATUS_AND_MASK_IRQ_WAKEUP | PM_STATUS_AND_MASK_FIQ_WAKEUP;
+	/* set wait for snoop queue empty indication */
+	reg |= PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
+	/* mask IRQ and FIQ from CPU */
+	reg |= PM_STATUS_AND_MASK_IRQ_MASK | PM_STATUS_AND_MASK_FIQ_MASK;
+	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+
+	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+	/* ask HW to power down the L2 Cache if needed */
+	if (deepidle)
+		reg |= PM_CONTROL_AND_CONFIG_L2_PWDDN;
+	/* request power down */
+	reg |= PM_CONTROL_AND_CONFIG_PWDDN_REQ;
+	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* Disable snoop disable by HW - SW is taking care of it */
+	reg = readl(pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
+	reg |= PM_CPU_POWER_DOWN_DIS_SNP_Q_SKIP;
+	writel(reg, pmsu_mp_base + PM_CPU_POWER_DOWN_CONTROL(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_prepare);
+
+noinline void armada_370_xp_pmsu_idle_restore(void)
+{
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+	int reg;
+
+	/* cancel ask HW to power down the L2 Cache if possible */
+	reg = readl(pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+	reg &= ~PM_CONTROL_AND_CONFIG_L2_PWDDN;
+	writel(reg, pmsu_mp_base + PM_CONTROL_AND_CONFIG(hw_cpu));
+
+	/* cancel Enable wakeup events */
+	reg = readl(pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+	reg &= ~(PM_STATUS_AND_MASK_IRQ_WAKEUP | PM_STATUS_AND_MASK_FIQ_WAKEUP);
+	reg &= ~PM_STATUS_AND_MASK_CPU_IDLE_WAIT;
+	reg &= ~PM_STATUS_AND_MASK_SNP_Q_EMPTY_WAIT;
+	/* Mask interrupts */
+	reg &= ~(PM_STATUS_AND_MASK_IRQ_MASK | PM_STATUS_AND_MASK_FIQ_MASK);
+	writel(reg, pmsu_mp_base + PM_STATUS_AND_MASK(hw_cpu));
+}
+EXPORT_SYMBOL_GPL(armada_370_xp_pmsu_idle_restore);
+
 early_initcall(armada_370_xp_pmsu_init);
diff --git a/include/linux/armada-370-xp-pmsu.h b/include/linux/armada-370-xp-pmsu.h
index f85cbf7..235a40c 100644
--- a/include/linux/armada-370-xp-pmsu.h
+++ b/include/linux/armada-370-xp-pmsu.h
@@ -12,5 +12,7 @@
 #define __ARMADA_370_XP__PMSU_H
 
 void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
+void armada_370_xp_pmsu_idle_prepare(bool deepidle);
+void armada_370_xp_pmsu_idle_restore(void);
 
 #endif	/* __ARMADA_370_XP__PMSU_H */
-- 
1.8.1.2

