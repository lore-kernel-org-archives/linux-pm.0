From: Leo Yan <leoy@marvell.com>
Subject: Re: [Question] Verification For arm64: suspend/resume implementation
Date: Mon, 23 Sep 2013 19:11:40 +0800
Message-ID: <524021EC.2000207@marvell.com>
References: <52327E41.1070904@marvell.com> <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------000707040702040708000103"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36953 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186Ab3IWLM1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Sep 2013 07:12:27 -0400
In-Reply-To: <20130913144001.GA28531@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Zhou Zhu <zzhu3@marvell.com>, Yu Tang <ytang5@marvell.com>, Neil Zhang <zhangwm@marvell.com>

--------------000707040702040708000103
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/13/2013 10:40 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 13, 2013 at 03:53:53AM +0100, Leo Yan wrote:
>> hi Lorenzo,
>>
>> I have applied your ARM64's suspend/resume related patches and can built
>> successfully. i want to verify these patches on foundation model
>> firstly, so below are my questions:
>>
>> "Code has been tested on AEM v8 models and a simple CPU idle driver that
>> enables a C-state where CPUs are reset when wfi is hit."
>>
>> 1. Can u help share this simple cpu idle driver?
>
> Yes, I will post a simple skeleton driver, PSCI based (bootwrapper
> implementation), by the end of September.
>
>> 2. On the foundation model, if the core is placed into reset state, then
>> if there have interrupt is routed to the core, the core still cannot be
>> waken up anymore; because the reset bit cannot be released by h/w. So
>> how can let the core return back from the reset state?
>
> Well, I am testing it with the AEM models power controller that is not
> publicly available yet, and _should_ be released with the new version of the
> foundation models.
>
> As a first step, I will write a PSCI suspend implementation that just executes
> wfi and resumes through the reset vector to emulate a power down as a means to
> make the suspend/resume code path usable to everyone.
>

Looking forward the related implementation; After them are ready, i'm 
glad have a trying.

At my side, i'm warming up related doc and tried to debug related tear 
down opreations according to CA53's TRM; pls see enclosed two patches.
Firstly clarify, these two patches are _ONLY_ for debugging purpose, i 
have no plan to commit them for Linux kernel.

0001-cpuidle-add-simple-driver-for-arm64.patch: it's a simple cpuidle 
driver;
0002-ARM64-add-cpu-tear-down-function-for-A53-s-power-mod.patch: i tried 
to wrote a tear down operations (disable D$/flush L1 cache/Disable SMP 
bit, etc);

But i found in the patch 2, if the core execute the instruction "mrs 
  x0, S3_1_C15_C2_1" to access CPUECTLR_EL1, the kernel will report the 
illegal instructions. So just like before i saw the discussion on 
mailing list, On ARMv8 we need operate the SMP bit in EL2/EL3/Secure EL1 
but not in non-secure EL1.

Here i tried two methods to try to fix this issue, but both of them were 
failure:
1. I tried to set the ACTLR_EL2 bit 1 in the boot wrapper code, but when 
in the non-secure world's kernel to access  CPUECTLR_EL1 it still will 
report the panic for illegal instruction;
2. I tried to modify the boot wrapper code to let the kernel stay in 
secure world's EL1, but looks like it also failed;

So do u have any suggestion for this failure?


Thx,
Leo Yan

--------------000707040702040708000103
Content-Type: text/x-patch;
	name="0001-cpuidle-add-simple-driver-for-arm64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-cpuidle-add-simple-driver-for-arm64.patch"

>From a1aa5dd0924b8c7493c6fec31c00b2feba7f5ad7 Mon Sep 17 00:00:00 2001
From: Leo Yan <leoy@marvell.com>
Date: Mon, 23 Sep 2013 17:05:42 +0800
Subject: [PATCH 1/2] cpuidle: add simple driver for arm64

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 drivers/cpuidle/Kconfig         |    6 ++
 drivers/cpuidle/Makefile        |    1 +
 drivers/cpuidle/cpuidle-arm64.c |  180 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c4cc27e..361325e 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -39,4 +39,10 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
+config CPU_IDLE_ARM64
+	bool "CPU Idle Driver for ARM64"
+	depends on ARM64
+	help
+	  Select this to enable cpuidle on ARM64 processors.
+
 endif
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 0d8bd55..954b67f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
+obj-$(CONFIG_CPU_IDLE_ARM64) += cpuidle-arm64.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
new file mode 100644
index 0000000..7d376db
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,180 @@
+/*
+ * ARM64 CPU idle driver.
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
+#include <linux/debugfs.h>
+#include <linux/hrtimer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/tick.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/cacheflush.h>
+
+static int arm64_cpuidle_simple_enter(struct cpuidle_device *dev,
+		struct cpuidle_driver *drv, int index)
+{
+	ktime_t time_start, time_end;
+	s64 diff;
+
+	time_start = ktime_get();
+
+	cpu_do_idle();
+
+	time_end = ktime_get();
+
+	local_irq_enable();
+
+	diff = ktime_to_us(ktime_sub(time_end, time_start));
+	if (diff > INT_MAX)
+		diff = INT_MAX;
+
+	dev->last_residency = (int) diff;
+
+	return index;
+}
+
+static int arm64_enter_powerdown(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx);
+
+static struct cpuidle_state arm64_cpuidle_set[] __initdata = {
+	[0] = {
+		.enter                  = arm64_cpuidle_simple_enter,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.flags                  = CPUIDLE_FLAG_TIME_VALID,
+		.name                   = "WFI",
+		.desc                   = "ARM64 WFI",
+	},
+#if 1
+	[1] = {
+		.enter			= arm64_enter_powerdown,
+		.exit_latency		= 300,
+		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "C1",
+		.desc			= "ARM64 power down",
+	},
+#endif
+};
+
+struct cpuidle_driver arm64_idle_driver = {
+	.name = "arm64_idle",
+	.owner = THIS_MODULE,
+	.safe_state_index = 0
+};
+
+static DEFINE_PER_CPU(struct cpuidle_device, arm64_idle_dev);
+
+extern void arm64_cpu_tear_down(void);
+typedef void (*phys_reset_t)(unsigned long);
+
+static int notrace arm64_powerdown_finisher(unsigned long arg)
+{
+	phys_reset_t phys_reset;
+
+	setup_mm_for_reboot();
+
+	arm64_cpu_tear_down();
+	wfi();
+
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(virt_to_phys(cpu_resume));
+
+	/* should never get here */
+	BUG();
+}
+
+/*
+ * arm64_enter_powerdown - Programs CPU to enter the specified state
+ * @dev: cpuidle device
+ * @drv: The target state to be programmed
+ * @idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int arm64_enter_powerdown(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+	int ret;
+
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
+	BUG_ON(!irqs_disabled());
+
+	cpu_pm_enter();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	ret = cpu_suspend((unsigned long) dev, arm64_powerdown_finisher);
+	if (ret)
+		BUG();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	cpu_pm_exit();
+
+	getnstimeofday(&ts_postidle);
+	local_irq_enable();
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
+
+	dev->last_residency = ts_idle.tv_nsec / NSEC_PER_USEC +
+					ts_idle.tv_sec * USEC_PER_SEC;
+	return idx;
+}
+
+/*
+ * arm64_idle_init
+ *
+ * Registers the bl specific cpuidle driver with the cpuidle
+ * framework with the valid set of states.
+ */
+int __init arm64_idle_init(void)
+{
+	struct cpuidle_device *dev;
+	int i, cpu_id;
+	struct cpuidle_driver *drv = &arm64_idle_driver;
+
+	drv->state_count = (sizeof(arm64_cpuidle_set) /
+				       sizeof(struct cpuidle_state));
+
+	for (i = 0; i < drv->state_count; i++) {
+		memcpy(&drv->states[i], &arm64_cpuidle_set[i],
+				sizeof(struct cpuidle_state));
+	}
+
+	cpuidle_register_driver(drv);
+
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		pr_err("CPUidle for CPU%d registered\n", cpu_id);
+		dev = &per_cpu(arm64_idle_dev, cpu_id);
+		dev->cpu = cpu_id;
+
+		dev->state_count = drv->state_count;
+
+		if (cpuidle_register_device(dev)) {
+			printk(KERN_ERR "%s: Cpuidle register device failed\n",
+			       __func__);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+device_initcall(arm64_idle_init);
-- 
1.7.9.5


--------------000707040702040708000103
Content-Type: text/x-patch;
	name="0002-ARM64-add-cpu-tear-down-function-for-A53-s-power-mod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-ARM64-add-cpu-tear-down-function-for-A53-s-power-mod.pa";
	filename*1="tch"

>From e238ddfc426bd1f8b2ac3b5f396a31150cbe7e5c Mon Sep 17 00:00:00 2001
From: Leo Yan <leoy@marvell.com>
Date: Mon, 23 Sep 2013 17:06:20 +0800
Subject: [PATCH 2/2] ARM64: add cpu tear down function for A53's power mode

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 arch/arm64/kernel/Makefile        |    2 +-
 arch/arm64/kernel/cpu_tear_down.S |   90 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/cpu_tear_down.S

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 010550a..046fbf0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,7 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o smp_psci.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
-arm64-obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
+arm64-obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o cpu_tear_down.o
 
 arm64-obj-$(CONFIG_SUSPEND)		+= fake_suspend.o
 obj-y					+= $(arm64-obj-y) vdso/
diff --git a/arch/arm64/kernel/cpu_tear_down.S b/arch/arm64/kernel/cpu_tear_down.S
new file mode 100644
index 0000000..9f3d5d0
--- /dev/null
+++ b/arch/arm64/kernel/cpu_tear_down.S
@@ -0,0 +1,90 @@
+/*
+ * arch/arm64/mach-vexpress/sleep.S
+ *
+ * Copyright (c) 2013 Marvell Semiconductor Inc.
+ *
+ * Author: Leo Yan <leoy@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <asm/assembler.h>
+
+/*
+ * Exits SMP coherency.
+ */
+ENTRY(arm64_cpu_tear_down)
+	mov	x12, lr
+
+	mrs	x0, sctlr_el1
+	bic	x0, x0, #1 << 2			// clear SCTLR.C
+	msr	sctlr_el1, x0
+	isb
+
+	dsb	sy				// ensure ordering with previous memory accesses
+	mrs	x0, clidr_el1			// read clidr
+	and	x3, x0, #0x7000000		// extract loc from clidr
+	lsr	x3, x3, #23			// left align loc bit field
+	cbz	x3, finished			// if loc is 0, then no need to clean
+	mov	x10, #0				// start clean at cache level 0
+
+	add	x2, x10, x10, lsr #1		// work out 3x current cache level
+	lsr	x1, x0, x2			// extract cache type bits from clidr
+	and	x1, x1, #7			// mask of the bits for current cache only
+	cmp	x1, #2				// see what cache we have at this level
+	b.lt	skip				// skip if no cache, or just i-cache
+	save_and_disable_irqs x9		// make CSSELR and CCSIDR access atomic
+	msr	csselr_el1, x10			// select current cache level in csselr
+	isb					// isb to sych the new cssr&csidr
+	mrs	x1, ccsidr_el1			// read the new ccsidr
+	restore_irqs x9
+	and	x2, x1, #7			// extract the length of the cache lines
+	add	x2, x2, #4			// add 4 (line length offset)
+	mov	x4, #0x3ff
+	and	x4, x4, x1, lsr #3		// find maximum number on the way size
+	clz	w5, w4				// find bit position of way size increment
+	mov	x7, #0x7fff
+	and	x7, x7, x1, lsr #13		// extract max number of the index size
+loop2:
+	mov	x9, x4				// create working copy of max way size
+loop3:
+	lsl	x6, x9, x5
+	orr	x11, x10, x6			// factor way and cache number into x11
+	lsl	x6, x7, x2
+	orr	x11, x11, x6			// factor index number into x11
+	dc	cisw, x11			// clean & invalidate by set/way
+	subs	x9, x9, #1			// decrement the way
+	b.ge	loop3
+	subs	x7, x7, #1			// decrement the index
+	b.ge	loop2
+
+skip:
+finished:
+	mov	x10, #0				// swith back to cache level 0
+	msr	csselr_el1, x10			// select current cache level in csselr
+	dsb	sy
+	isb
+
+	mrs	x0, S3_1_C15_C2_1
+	bic	x0, x0, #0x1 << 6		// disable SMP bit
+	msr	S3_1_C15_C2_1, x0
+	dsb	sy
+	isb
+
+	ret	x12
+ENDPROC(arm64_cpu_tear_down)
+
-- 
1.7.9.5


--------------000707040702040708000103--
