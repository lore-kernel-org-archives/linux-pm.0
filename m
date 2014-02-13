From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 11/13] ARM: mvebu: Register notifier callback for the cpuidle transition
Date: Thu, 13 Feb 2014 18:33:34 +0100
Message-ID: <1392312816-17657-12-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:51939 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752637AbaBMReK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2014 12:34:10 -0500
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

In order to have well encapsulated code use notifier callback for
CPU_PM_ENTER and CPU_PM_EXIT inside the mvebu power management code.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 24 ++++++++++++++++++++++++
 arch/arm/mach-mvebu/pmsu.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 162ae1399f2a..0e54077c31cb 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -16,6 +16,7 @@
  * other SOC units
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
@@ -189,4 +190,27 @@ static noinline void armada_370_xp_pmsu_idle_restore(void)
 	writel(reg, pmsu_mp_base + PMSU_STATUS_AND_MASK(hw_cpu));
 }
 
+static int armada_370_xp_cpu_pm_notify(struct notifier_block *self,
+				    unsigned long action, void *hcpu)
+{
+	if (action == CPU_PM_ENTER) {
+		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+		armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume,
+						hw_cpu);
+	} else if (action == CPU_PM_EXIT) {
+		armada_370_xp_pmsu_idle_restore();
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block armada_370_xp_cpu_pm_notifier = {
+	.notifier_call = armada_370_xp_cpu_pm_notify,
+};
+
+int __init armada_370_xp_cpu_pm_init(void)
+{
+	return cpu_pm_register_notifier(&armada_370_xp_cpu_pm_notifier);
+}
+
 early_initcall(armada_370_xp_pmsu_init);
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index 054cdd8b0ece..e7a766fba757 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -13,5 +13,6 @@
 
 int armada_xp_boot_cpu(unsigned int cpu_id, void *phys_addr);
 void armada_370_xp_pmsu_enable_l2_powerdown_onidle(void);
+int armada_370_xp_cpu_pm_init(void);
 
 #endif	/* __MACH_370_XP_PMSU_H */
-- 
1.8.1.2

