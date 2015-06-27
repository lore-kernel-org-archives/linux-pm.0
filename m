From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 09/16] arm: domain: Add platform callbacks for domain power on/off
Date: Fri, 26 Jun 2015 21:02:29 -0600
Message-ID: <1435374156-19214-10-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35898 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbF0DC6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:58 -0400
Received: by pdcu2 with SMTP id u2so84847014pdc.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:58 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Platform drivers may have additional setup inorder before the domain can
be powered off. Allow, platform drivers to register power on/off
callbacks against a domain provider.

While registering the callback ensure that the domain is neither in
power on/off state. The domain should be active. To ensure that the
platform callback registration doesntrace with genpd power on/off,
execute the registration from a CPU on that domain.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/include/asm/cpu.h       |  1 -
 arch/arm/include/asm/pm_domain.h | 27 ++++++++++++++
 arch/arm/kernel/domains.c        | 81 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/pm_domain.h

diff --git a/arch/arm/include/asm/cpu.h b/arch/arm/include/asm/cpu.h
index 2744f06..4a7e346 100644
--- a/arch/arm/include/asm/cpu.h
+++ b/arch/arm/include/asm/cpu.h
@@ -22,5 +22,4 @@ struct cpuinfo_arm {
 };
 
 DECLARE_PER_CPU(struct cpuinfo_arm, cpu_data);
-
 #endif
diff --git a/arch/arm/include/asm/pm_domain.h b/arch/arm/include/asm/pm_domain.h
new file mode 100644
index 0000000..d13c291
--- /dev/null
+++ b/arch/arm/include/asm/pm_domain.h
@@ -0,0 +1,27 @@
+/*
+ *  arch/arm/include/asm/pm_domain.h
+ *
+ *  Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_PM_DOMAIN_H
+#define __ASM_ARM_PM_DOMAIN_H
+
+#include <linux/pm_domain.h>
+
+#if IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)
+extern int register_platform_domain_handlers(struct of_phandle_args *args,
+		int (*pd_down)(struct generic_pm_domain *),
+		int (*pd_up)(struct generic_pm_domain *));
+#else
+static inline
+int register_platform_domain_handlers(struct of_phandle_args *args,
+		int (*pd_down)(struct generic_pm_domain *),
+		int (*pd_up)(struct generic_pm_domain *))
+{ return -ENODEV; }
+#endif
+
+#endif
diff --git a/arch/arm/kernel/domains.c b/arch/arm/kernel/domains.c
index 680c3fb..2f5ba3f 100644
--- a/arch/arm/kernel/domains.c
+++ b/arch/arm/kernel/domains.c
@@ -9,10 +9,19 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include <asm/pm_domain.h>
+
 #define NAME_MAX 16
 
+struct platform_cb {
+	int (*power_off)(struct generic_pm_domain *);
+	int (*power_on)(struct generic_pm_domain *);
+};
+
 struct arm_pm_domain {
 	struct generic_pm_domain genpd;
+	struct platform_cb plat_handler;
+	struct spinlock_t lock;
 };
 
 static inline
@@ -23,16 +32,85 @@ struct arm_pm_domain *to_arm_pd(struct generic_pm_domain *d)
 
 static int arm_pd_power_down(struct generic_pm_domain *genpd)
 {
+	struct arm_pm_domain *arm_pd = to_arm_pd(genpd);
+
+	if (arm_pd->plat_handler.power_off)
+		return arm_pd->plat_handler.power_off(genpd);
+
 	/* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
 	return 0;
 }
 
 static int arm_pd_power_up(struct generic_pm_domain *genpd)
 {
+	struct arm_pm_domain *arm_pd = to_arm_pd(genpd);
+
+	if (arm_pd->plat_handler.power_on)
+		return arm_pd->plat_handler.power_on(genpd);
+
 	/* pr_info("KJH: %s: %s\n", __func__, genpd->name); */
 	return 0;
 }
 
+static void __register_platform_domain_handlers(void *data)
+{
+	struct device *cpu_dev = get_cpu_device(smp_processor_id());
+	struct generic_pm_domain *genpd;
+	struct arm_pm_domain *arm_pd;
+	unsigned long flags;
+	struct platform_cb *handler = data;
+
+	genpd = pd_to_genpd(cpu_dev->pm_domain);
+	BUG_ON(IS_ERR_OR_NULL(genpd));
+	arm_pd = to_arm_pd(genpd);
+
+	/*
+	 * Lock to avoid race with other CPUs in the same domain
+	 * trying to set the function pointers.
+	 */
+	spin_lock_irqsave(&arm_pd->lock, flags);
+	arm_pd->plat_handler.power_on = handler->power_on;
+	arm_pd->plat_handler.power_off = handler->power_off;
+	spin_unlock_irqrestore(&arm_pd->lock, flags);
+}
+
+int register_platform_domain_handlers(struct of_phandle_args *args,
+		int (*power_on)(struct generic_pm_domain *),
+		int (*power_off)(struct generic_pm_domain *))
+{
+	struct platform_cb handler;
+	struct generic_pm_domain *genpd, *p;
+	struct device *cpu_dev;
+	int cpu;
+
+	handler.power_on = power_on;
+	handler.power_off = power_off;
+
+	genpd = of_genpd_get_from_provider(args);
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		p = pm_genpd_lookup_dev(cpu_dev);
+		/*
+		 * Execute the registration on the requested 'cpu', so we dont
+		 * race with the domain->power_off or ->power_on calls.
+		 * By executing on that 'cpu', we are assured that the 'cpu' is
+		 * awake, therefore the domain. This will avoid a spin lock
+		 * between power on/off calls and this function.
+		 */
+		if (p == genpd) {
+			smp_call_function_single(cpu,
+				__register_platform_domain_handlers,
+				&handler, true);
+			break;
+		}
+	}
+	put_online_cpus();
+
+	return 0;
+}
+EXPORT_SYMBOL(register_platform_domain_handlers);
+
 static void run_cpu(void *unused)
 {
 	struct device *cpu_dev = get_cpu_device(smp_processor_id());
@@ -91,7 +169,7 @@ static int arm_domain_cpu_init(void)
 		/* FIXME: this is open-coding of_cpu_device_node_get(), but I want handle to cpu_dev */
 		cpu_dev = get_cpu_device(cpuid);
 		if (!cpu_dev) {
- 			pr_warn("%s: Unable to get device for CPU%d\n", __func__, cpuid);
+			pr_warn("%s: Unable to get device for CPU%d\n", __func__, cpuid);
 			return -ENODEV;
 		}
 
@@ -152,6 +230,7 @@ static int arm_domain_init(void)
 		pd->genpd.power_off = arm_pd_power_down;
 		pd->genpd.power_on = arm_pd_power_up;
 		pd->genpd.flags |= GENPD_FLAG_IRQ_SAFE;
+		spin_lock_init(&pd->lock);
 		platform_set_drvdata(pdev, pd);
 
 		dev_dbg(dev, "adding as generic power domain.\n");
-- 
2.1.4

