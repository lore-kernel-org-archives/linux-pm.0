From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] [loongson] 2f: add suspend support
	framework
Date: Wed, 11 Nov 2009 14:57:05 +0800
Message-ID: <1257922625.2922.97.camel__35162.9631048583$1257922702$gmane$org@falcon.domain.org>
References: <cover.1257920162.git.wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1257920162.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257922151.git.wuzhangjin@gmail.com>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Len Brown <len.brown@intel.com>, yanh@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

(Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)

This patch add basic suspend support for loongson2f family machines,
loongson2f have a specific feature: when we set it's frequency to ZERO,
it will go into a wait mode, and then can be waked up by the external
interrupt. so, if we setup suitable interrupts before putting it into
wait mode, we will be able wake it up whenever we want via sending the
relative interrupts to it.

These interrupts are board-specific, Yeeloong2F use the keyboard
interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
interrupts connected to the processors directly. and BTW: some old
LingLoong and FuLoong2F have no such interrupts connected, so, there is
no way to wake them up from suspend mode. and therefore, please do not
enable the kernel support for them.

The board-specific support will be added in the coming patches.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/Kconfig         |    5 +
 arch/mips/loongson/common/Makefile |    6 ++
 arch/mips/loongson/common/pm.c     |  157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/loongson/common/pm.c

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index a214127..029360f 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -61,3 +61,8 @@ endchoice
 
 config CS5536
 	bool
+
+config LOONGSON_SUSPEND
+	bool
+	default y
+	depends on CPU_SUPPORT_CPUFREQ && SUSPEND
diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index a82527f..a21724d 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -16,3 +16,9 @@ obj-$(CONFIG_SERIAL_8250) += serial.o
 # space
 #
 obj-$(CONFIG_CS5536) += cs5536/
+
+#
+# Suspend Support
+#
+
+obj-$(CONFIG_LOONGSON_SUSPEND) += pm.o
diff --git a/arch/mips/loongson/common/pm.c b/arch/mips/loongson/common/pm.c
new file mode 100644
index 0000000..4e5c56e
--- /dev/null
+++ b/arch/mips/loongson/common/pm.c
@@ -0,0 +1,157 @@
+/*
+ * loongson-specific suspend support
+ *
+ *  Copyright (C) 2009 Lemote Inc.
+ *  Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+
+#include <asm/i8259.h>
+#include <asm/mipsregs.h>
+
+#include <loongson.h>
+
+static unsigned int __maybe_unused cached_master_mask;	/* i8259A */
+static unsigned int __maybe_unused cached_slave_mask;
+static unsigned int __maybe_unused cached_bonito_irq_mask; /* bonito */
+
+void arch_suspend_disable_irqs(void)
+{
+	/* disable all mips events */
+	local_irq_disable();
+#ifdef CONFIG_I8259
+	/* disable all events of i8259A */
+	cached_slave_mask = inb(PIC_SLAVE_IMR);
+	cached_master_mask = inb(PIC_MASTER_IMR);
+
+	outb(0xff, PIC_SLAVE_IMR);
+	inb(PIC_SLAVE_IMR);
+	outb(0xff, PIC_MASTER_IMR);
+	inb(PIC_MASTER_IMR);
+#endif
+	/* disable all events of bonito */
+	cached_bonito_irq_mask = LOONGSON_INTEN;
+	LOONGSON_INTENCLR = 0xffff;
+	(void)LOONGSON_INTENCLR;
+}
+
+void arch_suspend_enable_irqs(void)
+{
+	/* enable all mips events */
+	local_irq_enable();
+#ifdef CONFIG_I8259
+	/* only enable the cached events of i8259A */
+	outb(cached_slave_mask, PIC_SLAVE_IMR);
+	outb(cached_master_mask, PIC_MASTER_IMR);
+#endif
+	/* enable all cached events of bonito */
+	LOONGSON_INTENSET = cached_bonito_irq_mask;
+	(void)LOONGSON_INTENSET;
+}
+
+/* setup the board-specific events for waking up loongson from wait mode */
+void __weak setup_wakeup_events(void)
+{
+}
+
+/* check wakeup events */
+int __weak wakeup_loongson(void)
+{
+	return 1;
+}
+
+/* if the events are really what we want to wakeup cpu, wake up it, otherwise,
+ * we Put CPU into wait mode again.
+ */
+static void wait_for_wakeup_events(void)
+{
+	while (!wakeup_loongson())
+		LOONGSON_CHIPCFG0 &= ~0x7;
+}
+
+/* stop all perf counters by default
+ *   $24 is the control register of loongson perf counter
+ */
+static inline void stop_perf_counters(void)
+{
+	__write_64bit_c0_register($24, 0, 0);
+}
+
+
+static void loongson_suspend_enter(void)
+{
+	static unsigned int cached_cpu_freq;
+
+	/* setup wakeup events via enabling the IRQs */
+	setup_wakeup_events();
+
+	/* stop all perf counters */
+	stop_perf_counters();
+
+	cached_cpu_freq = LOONGSON_CHIPCFG0;
+
+	/* Put CPU into wait mode */
+	LOONGSON_CHIPCFG0 &= ~0x7;
+
+	/* wait for the given events to wakeup cpu from wait mode */
+	wait_for_wakeup_events();
+
+	LOONGSON_CHIPCFG0 = cached_cpu_freq;
+	mmiowb();
+}
+
+void __weak mach_suspend(void)
+{
+}
+
+void __weak mach_resume(void)
+{
+}
+
+static int loongson_pm_enter(suspend_state_t state)
+{
+	/* mach specific suspend */
+	mach_suspend();
+
+	/* processor specific suspend */
+	loongson_suspend_enter();
+
+	/* mach specific resume */
+	mach_resume();
+
+	return 0;
+}
+
+static int loongson_pm_valid_state(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_ON:
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		return 1;
+
+	default:
+		return 0;
+	}
+}
+
+static struct platform_suspend_ops loongson_pm_ops = {
+	.valid	= loongson_pm_valid_state,
+	.enter	= loongson_pm_enter,
+};
+
+static int __init loongson_pm_init(void)
+{
+	suspend_set_ops(&loongson_pm_ops);
+
+	return 0;
+}
+arch_initcall(loongson_pm_init);
-- 
1.6.2.1
