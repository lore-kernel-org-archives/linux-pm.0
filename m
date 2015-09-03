From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 6/7] ARM64: smp: Add runtime PM support for CPU hotplug
Date: Thu,  3 Sep 2015 13:58:33 -0600
Message-ID: <1441310314-8857-7-git-send-email-lina.iyer@linaro.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35837 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbICT64 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:56 -0400
Received: by pacfv12 with SMTP id fv12so247614pac.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:55 -0700 (PDT)
In-Reply-To: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Enable runtime PM for CPU devices. Do a runtime get of the CPU device
when the CPU is hotplugged in and runtime put of the CPU device when the
CPU is hotplugged off. When all the CPUs in a domain are hotplugged off,
the domain may also be powered off and cluster_pm_enter/exit()
notifications are be sent out.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm64/kernel/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacd..4076962 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -135,6 +135,7 @@ asmlinkage void secondary_start_kernel(void)
 {
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu = smp_processor_id();
+	struct device *cpu_dev;
 
 	/*
 	 * All kernel threads share the same mm context; grab a
@@ -185,6 +186,11 @@ asmlinkage void secondary_start_kernel(void)
 	local_irq_enable();
 	local_async_enable();
 
+	/* We are running, enable runtime PM for the CPU. */
+	cpu_dev = get_cpu_device(cpu);
+	if (cpu_dev)
+		pm_runtime_get_sync(cpu_dev);
+
 	/*
 	 * OK, it's off to the idle thread for us
 	 */
@@ -292,6 +298,16 @@ void __cpu_die(unsigned int cpu)
 void cpu_die(void)
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
 
-- 
2.1.4

