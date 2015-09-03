From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Thu,  3 Sep 2015 13:58:34 -0600
Message-ID: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36792 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbbICT66 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:58 -0400
Received: by pacwi10 with SMTP id wi10so211671pac.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:57 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
index 0496b48..077c55f 100644
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
@@ -271,6 +271,16 @@ void __cpu_die(unsigned int cpu)
 void __ref cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
+	struct device *cpu_dev;
+
+	/*
+	 * We dont need the CPU device anymore.
+	 * Lets do this before IRQs are disabled to allow
+	 * runtime PM to suspend the domain as well.
+	 */
+	cpu_dev = get_cpu_device(cpu);
+	if (cpu_dev)
+		pm_runtime_put_sync(cpu_dev);
 
 	idle_task_exit();
 
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

