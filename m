From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 9/9] ARM: smp: Add runtime PM support for CPU hotplug
Date: Tue,  4 Aug 2015 17:35:39 -0600
Message-ID: <1438731339-58317-10-git-send-email-lina.iyer@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35772 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbbHDXgU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:20 -0400
Received: by pdrg1 with SMTP id g1so10370027pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:20 -0700 (PDT)
In-Reply-To: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Enable runtime PM for CPU devices. Do a runtime get of the CPU device
when the CPU is hotplugged in and a runtime put of the CPU device when
the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
off, the domain may also be powered off and cluster_pm_enter/exit()
notifications are be sent out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/smp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0496b48..1d614b8 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -137,7 +138,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 	}
 
-
 	memset(&secondary_data, 0, sizeof(secondary_data));
 	return ret;
 }
@@ -205,6 +205,9 @@ int __cpu_disable(void)
 	unsigned int cpu = smp_processor_id();
 	int ret;
 
+	/* We dont need the CPU device anymore. */
+	pm_runtime_put_sync(get_cpu_device(cpu));
+
 	ret = platform_cpu_disable(cpu);
 	if (ret)
 		return ret;
@@ -272,6 +275,13 @@ void __ref cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
 
+	/*
+	 * We dont need the CPU device anymore.
+	 * Lets do this before IRQs are disabled to allow
+	 * runtime PM to suspend the domain as well.
+	 */
+	pm_runtime_put_sync(get_cpu_device(cpu));
+
 	idle_task_exit();
 
 	local_irq_disable();
@@ -352,6 +362,7 @@ asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;
+	struct device *cpu_dev;
 
 	/*
 	 * The identity mapping is uncached (strongly ordered), so
@@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
 	local_irq_enable();
 	local_fiq_enable();
 
+	/* We are running, enable runtime PM for the CPU. */
+	cpu_dev = get_cpu_device(cpu);
+	if (cpu_dev)
+		pm_runtime_get_sync(cpu_dev);
+
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
-- 
2.1.4

