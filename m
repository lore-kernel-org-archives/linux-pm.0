From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 4/8] arm64: kernel: introduce cpu_init_idle CPU
 operation
Date: Wed, 3 Sep 2014 13:16:01 -0600
Message-ID: <20140903191601.GJ92149@ilina-mac.local>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409585324-3678-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20140903173437.GI92149@ilina-mac.local>
 <20140903174645.GK1824@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39863 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbaICTQP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 15:16:15 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so17989780pac.5
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 12:16:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140903174645.GK1824@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@sam>

On Wed, Sep 03 2014 at 11:46 -0600, Lorenzo Pieralisi wrote:
>On Wed, Sep 03, 2014 at 06:34:37PM +0100, Lina Iyer wrote:
>> On Mon, Sep 01 2014 at 09:28 -0600, Lorenzo Pieralisi wrote:
>> >The CPUidle subsystem on ARM64 machines requires the idle states
>> >implementation back-end to initialize idle states parameter upon
>> >boot. This patch adds a hook in the CPU operations structure that
>> >should be initialized by the CPU operations back-end in order to
>> >provide a function that initializes cpu idle states.
>> >
>> >This patch also adds the infrastructure to arm64 kernel required
>> >to export the CPU operations based initialization interface, so
>> >that drivers (ie CPUidle) can use it when they are initialized
>> >at probe time.
>> >
>> I like the change for ARM64.
>> However, that raises a question, how do I have the same driver that
>> should get probed by a platform device (on 32 bit ARM) and getting called
>> from cpu_init_idle on ARM64?
>
>I am not following you sorry. The ARM64 CPUidle driver calls the arm64
>cpu_init_idle hooks to initialize idle states (in a generic way from
>a driver perspective), not the other way around.
>
>On ARM64 your idle driver rely on an arm64 suspend back-end (eg PSCI) to
>enter idle states, it works in a different way from ARM, on purpose.
>
>Have a look at what the code does, it won't be the same driver that's
>for certain, since on arm64 I do not want to cope with per-platform
>CPUidle state enter functions anymore, the arm64 cpu_ops suspend hook
>implements the idle state enter method.

Ah, I was working on the premise that I may be using the same cpuidle
driver for ARM64. I guess I will worry about ARM64 with non-PSCI drivers
when and if I have to. Thanks!

>
>Lorenzo
>
>> >Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >---
>> > arch/arm64/include/asm/cpu_ops.h |  3 +++
>> > arch/arm64/include/asm/cpuidle.h | 13 +++++++++++++
>> > arch/arm64/kernel/Makefile       |  1 +
>> > arch/arm64/kernel/cpuidle.c      | 31 +++++++++++++++++++++++++++++++
>> > 4 files changed, 48 insertions(+)
>> > create mode 100644 arch/arm64/include/asm/cpuidle.h
>> > create mode 100644 arch/arm64/kernel/cpuidle.c
>> >
>> >diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
>> >index d7b4b38..47dfa31 100644
>> >--- a/arch/arm64/include/asm/cpu_ops.h
>> >+++ b/arch/arm64/include/asm/cpu_ops.h
>> >@@ -28,6 +28,8 @@ struct device_node;
>> >  *		enable-method property.
>> >  * @cpu_init:	Reads any data necessary for a specific enable-method from the
>> >  *		devicetree, for a given cpu node and proposed logical id.
>> >+ * @cpu_init_idle: Reads any data necessary to initialize CPU idle states from
>> >+ *		devicetree, for a given cpu node and proposed logical id.
>> >  * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
>> >  *		mechanism for doing so, tests whether it is possible to boot
>> >  *		the given CPU.
>> >@@ -47,6 +49,7 @@ struct device_node;
>> > struct cpu_operations {
>> > 	const char	*name;
>> > 	int		(*cpu_init)(struct device_node *, unsigned int);
>> >+	int		(*cpu_init_idle)(struct device_node *, unsigned int);
>> > 	int		(*cpu_prepare)(unsigned int);
>> > 	int		(*cpu_boot)(unsigned int);
>> > 	void		(*cpu_postboot)(void);
>> >diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
>> >new file mode 100644
>> >index 0000000..b52a993
>> >--- /dev/null
>> >+++ b/arch/arm64/include/asm/cpuidle.h
>> >@@ -0,0 +1,13 @@
>> >+#ifndef __ASM_CPUIDLE_H
>> >+#define __ASM_CPUIDLE_H
>> >+
>> >+#ifdef CONFIG_CPU_IDLE
>> >+extern int cpu_init_idle(unsigned int cpu);
>> >+#else
>> >+static inline int cpu_init_idle(unsigned int cpu)
>> >+{
>> >+	return -EOPNOTSUPP;
>> >+}
>> >+#endif
>> >+
>> >+#endif
>> >diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> >index 383d81d..be78980 100644
>> >--- a/arch/arm64/kernel/Makefile
>> >+++ b/arch/arm64/kernel/Makefile
>> >@@ -27,6 +27,7 @@ arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
>> > arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
>> > arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>> > arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
>> >+arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>> > arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>> > arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>> > arm64-obj-$(CONFIG_EFI)			+= efi.o efi-stub.o efi-entry.o
>> >diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
>> >new file mode 100644
>> >index 0000000..19d17f5
>> >--- /dev/null
>> >+++ b/arch/arm64/kernel/cpuidle.c
>> >@@ -0,0 +1,31 @@
>> >+/*
>> >+ * ARM64 CPU idle arch support
>> >+ *
>> >+ * Copyright (C) 2014 ARM Ltd.
>> >+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >+ *
>> >+ * This program is free software; you can redistribute it and/or modify
>> >+ * it under the terms of the GNU General Public License version 2 as
>> >+ * published by the Free Software Foundation.
>> >+ */
>> >+
>> >+#include <linux/of.h>
>> >+#include <linux/of_device.h>
>> >+
>> >+#include <asm/cpuidle.h>
>> >+#include <asm/cpu_ops.h>
>> >+
>> >+int cpu_init_idle(unsigned int cpu)
>> >+{
>> >+	int ret = -EOPNOTSUPP;
>> >+	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
>> >+
>> >+	if (!cpu_node)
>> >+		return -ENODEV;
>> >+
>> >+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_init_idle)
>> >+		ret = cpu_ops[cpu]->cpu_init_idle(cpu_node, cpu);
>> >+
>> >+	of_node_put(cpu_node);
>> >+	return ret;
>> >+}
>> >--
>> >1.9.1
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
