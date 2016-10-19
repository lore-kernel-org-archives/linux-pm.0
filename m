From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] cpufreq: retire the Integrator cpufreq driver
Date: Wed, 19 Oct 2016 11:59:14 +0200
Message-ID: <1476871154-32243-6-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

After switching the core module clocks controlling the Integrator
clock frequencies to the common clock framework, defining the
operating points in the device tree, and activating the generic
DT-based CPUfreq driver, we can retire the old Integrator
cpufreq driver.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/cpufreq/Kconfig.arm          |   8 --
 drivers/cpufreq/Makefile             |   1 -
 drivers/cpufreq/integrator-cpufreq.c | 239 -----------------------------------
 3 files changed, 248 deletions(-)
 delete mode 100644 drivers/cpufreq/integrator-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index d89b8afe23b6..fdbc630272b3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -60,14 +60,6 @@ config ARM_IMX6Q_CPUFREQ
 
 	  If in doubt, say N.
 
-config ARM_INTEGRATOR
-	tristate "CPUfreq driver for ARM Integrator CPUs"
-	depends on ARCH_INTEGRATOR
-	default y
-	help
-	  This enables the CPUfreq driver for ARM Integrator CPUs.
-	  If in doubt, say Y.
-
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool MACH_KIRKWOOD
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 0a9b6a093646..7dde82179d62 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_UX500_SOC_DB8500)		+= dbx500-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
-obj-$(CONFIG_ARM_INTEGRATOR)		+= integrator-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
deleted file mode 100644
index 79e3ff2771a6..000000000000
--- a/drivers/cpufreq/integrator-cpufreq.c
+++ /dev/null
@@ -1,239 +0,0 @@
-/*
- *  Copyright (C) 2001-2002 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * CPU support functions
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/cpufreq.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <asm/mach-types.h>
-#include <asm/hardware/icst.h>
-
-static void __iomem *cm_base;
-/* The cpufreq driver only use the OSC register */
-#define INTEGRATOR_HDR_OSC_OFFSET       0x08
-#define INTEGRATOR_HDR_LOCK_OFFSET      0x14
-
-static struct cpufreq_driver integrator_driver;
-
-static const struct icst_params lclk_params = {
-	.ref		= 24000000,
-	.vco_max	= ICST525_VCO_MAX_5V,
-	.vco_min	= ICST525_VCO_MIN,
-	.vd_min		= 8,
-	.vd_max		= 132,
-	.rd_min		= 24,
-	.rd_max		= 24,
-	.s2div		= icst525_s2div,
-	.idx2s		= icst525_idx2s,
-};
-
-static const struct icst_params cclk_params = {
-	.ref		= 24000000,
-	.vco_max	= ICST525_VCO_MAX_5V,
-	.vco_min	= ICST525_VCO_MIN,
-	.vd_min		= 12,
-	.vd_max		= 160,
-	.rd_min		= 24,
-	.rd_max		= 24,
-	.s2div		= icst525_s2div,
-	.idx2s		= icst525_idx2s,
-};
-
-/*
- * Validate the speed policy.
- */
-static int integrator_verify_policy(struct cpufreq_policy *policy)
-{
-	struct icst_vco vco;
-
-	cpufreq_verify_within_cpu_limits(policy);
-
-	vco = icst_hz_to_vco(&cclk_params, policy->max * 1000);
-	policy->max = icst_hz(&cclk_params, vco) / 1000;
-
-	vco = icst_hz_to_vco(&cclk_params, policy->min * 1000);
-	policy->min = icst_hz(&cclk_params, vco) / 1000;
-
-	cpufreq_verify_within_cpu_limits(policy);
-	return 0;
-}
-
-
-static int integrator_set_target(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation)
-{
-	cpumask_t cpus_allowed;
-	int cpu = policy->cpu;
-	struct icst_vco vco;
-	struct cpufreq_freqs freqs;
-	u_int cm_osc;
-
-	/*
-	 * Save this threads cpus_allowed mask.
-	 */
-	cpus_allowed = current->cpus_allowed;
-
-	/*
-	 * Bind to the specified CPU.  When this call returns,
-	 * we should be running on the right CPU.
-	 */
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-	BUG_ON(cpu != smp_processor_id());
-
-	/* get current setting */
-	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
-
-	if (machine_is_integrator())
-		vco.s = (cm_osc >> 8) & 7;
-	else if (machine_is_cintegrator())
-		vco.s = 1;
-	vco.v = cm_osc & 255;
-	vco.r = 22;
-	freqs.old = icst_hz(&cclk_params, vco) / 1000;
-
-	/* icst_hz_to_vco rounds down -- so we need the next
-	 * larger freq in case of CPUFREQ_RELATION_L.
-	 */
-	if (relation == CPUFREQ_RELATION_L)
-		target_freq += 999;
-	if (target_freq > policy->max)
-		target_freq = policy->max;
-	vco = icst_hz_to_vco(&cclk_params, target_freq * 1000);
-	freqs.new = icst_hz(&cclk_params, vco) / 1000;
-
-	if (freqs.old == freqs.new) {
-		set_cpus_allowed_ptr(current, &cpus_allowed);
-		return 0;
-	}
-
-	cpufreq_freq_transition_begin(policy, &freqs);
-
-	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
-
-	if (machine_is_integrator()) {
-		cm_osc &= 0xfffff800;
-		cm_osc |= vco.s << 8;
-	} else if (machine_is_cintegrator()) {
-		cm_osc &= 0xffffff00;
-	}
-	cm_osc |= vco.v;
-
-	__raw_writel(0xa05f, cm_base + INTEGRATOR_HDR_LOCK_OFFSET);
-	__raw_writel(cm_osc, cm_base + INTEGRATOR_HDR_OSC_OFFSET);
-	__raw_writel(0, cm_base + INTEGRATOR_HDR_LOCK_OFFSET);
-
-	/*
-	 * Restore the CPUs allowed mask.
-	 */
-	set_cpus_allowed_ptr(current, &cpus_allowed);
-
-	cpufreq_freq_transition_end(policy, &freqs, 0);
-
-	return 0;
-}
-
-static unsigned int integrator_get(unsigned int cpu)
-{
-	cpumask_t cpus_allowed;
-	unsigned int current_freq;
-	u_int cm_osc;
-	struct icst_vco vco;
-
-	cpus_allowed = current->cpus_allowed;
-
-	set_cpus_allowed_ptr(current, cpumask_of(cpu));
-	BUG_ON(cpu != smp_processor_id());
-
-	/* detect memory etc. */
-	cm_osc = __raw_readl(cm_base + INTEGRATOR_HDR_OSC_OFFSET);
-
-	if (machine_is_integrator())
-		vco.s = (cm_osc >> 8) & 7;
-	else
-		vco.s = 1;
-	vco.v = cm_osc & 255;
-	vco.r = 22;
-
-	current_freq = icst_hz(&cclk_params, vco) / 1000; /* current freq */
-
-	set_cpus_allowed_ptr(current, &cpus_allowed);
-
-	return current_freq;
-}
-
-static int integrator_cpufreq_init(struct cpufreq_policy *policy)
-{
-
-	/* set default policy and cpuinfo */
-	policy->max = policy->cpuinfo.max_freq = 160000;
-	policy->min = policy->cpuinfo.min_freq = 12000;
-	policy->cpuinfo.transition_latency = 1000000; /* 1 ms, assumed */
-
-	return 0;
-}
-
-static struct cpufreq_driver integrator_driver = {
-	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= integrator_verify_policy,
-	.target		= integrator_set_target,
-	.get		= integrator_get,
-	.init		= integrator_cpufreq_init,
-	.name		= "integrator",
-};
-
-static int __init integrator_cpufreq_probe(struct platform_device *pdev)
-{
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	cm_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!cm_base)
-		return -ENODEV;
-
-	return cpufreq_register_driver(&integrator_driver);
-}
-
-static int __exit integrator_cpufreq_remove(struct platform_device *pdev)
-{
-	return cpufreq_unregister_driver(&integrator_driver);
-}
-
-static const struct of_device_id integrator_cpufreq_match[] = {
-	{ .compatible = "arm,core-module-integrator"},
-	{ },
-};
-
-MODULE_DEVICE_TABLE(of, integrator_cpufreq_match);
-
-static struct platform_driver integrator_cpufreq_driver = {
-	.driver = {
-		.name = "integrator-cpufreq",
-		.of_match_table = integrator_cpufreq_match,
-	},
-	.remove = __exit_p(integrator_cpufreq_remove),
-};
-
-module_platform_driver_probe(integrator_cpufreq_driver,
-			     integrator_cpufreq_probe);
-
-MODULE_AUTHOR("Russell M. King");
-MODULE_DESCRIPTION("cpufreq driver for ARM Integrator CPUs");
-MODULE_LICENSE("GPL");
-- 
2.7.4
