From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: [PATCH v9 2/2] ARM hibernation / suspend-to-disk
Date: Tue, 18 Mar 2014 14:40:58 -0700
Message-ID: <1395178858-27343-3-git-send-email-sebastian.capella@linaro.org>
References: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Russ Dill <Russ.Dill@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Capella <sebastian.capella@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Jonathan Austin <jonathan.austin@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@codeaurora.org>, Victor Kamensky <victor.kamensky@linaro.org>, Sricharan R <r.sricharan@ti.com>, Jiang Liu <liuj97@gmail.com>, Laura Abbott <lauraa@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

=46rom: Russ Dill <Russ.Dill@ti.com>

Enable hibernation for ARM architectures and provide ARM
architecture specific calls used during hibernation.

The swsusp hibernation framework depends on the
platform first having functional suspend/resume.

Then, in order to enable hibernation on a given platform, a
platform_hibernation_ops structure may need to be registered with
the system in order to save/restore any SoC-specific / cpu specific
state needing (re)init over a suspend-to-disk/resume-from-disk cycle.

=46or example:

     - "secure" SoCs that have different sets of control registers
       and/or different CR reg access patterns.

     - SoCs with L2 caches as the activation sequence there is
       SoC-dependent; a full off-on cycle for L2 is not done
       by the hibernation support code.

     - SoCs requiring steps on wakeup _before_ the "generic" parts
       done by cpu_suspend / cpu_resume can work correctly.

     - SoCs having persistent state which is maintained during suspend
       and resume, but will be lost during the power off cycle after
       suspend-to-disk.

This is a rebase/rework of Frank Hofmann's v5 hibernation patchset.

Acked-by: Russ Dill <Russ.Dill@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Len Brown <len.brown@intel.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Austin <jonathan.austin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com
Cc: Victor Kamensky <victor.kamensky@linaro.org>
Cc: Sricharan R <r.sricharan@ti.com>
Cc: Jiang Liu <liuj97@gmail.com>
Cc: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/Kconfig              |    5 ++
 arch/arm/include/asm/memory.h |    1 +
 arch/arm/kernel/Makefile      |    1 +
 arch/arm/kernel/hibernate.c   |  107 +++++++++++++++++++++++++++++++++=
++++++++
 include/linux/suspend.h       |    2 +
 5 files changed, 116 insertions(+)
 create mode 100644 arch/arm/kernel/hibernate.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1594945..d204231 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2279,6 +2279,11 @@ config ARCH_SUSPEND_POSSIBLE
 config ARM_CPU_SUSPEND
 	def_bool PM_SLEEP
=20
+config ARCH_HIBERNATION_POSSIBLE
+	bool
+	depends on MMU
+	default y if ARCH_SUSPEND_POSSIBLE
+
 endmenu
=20
 source "net/Kconfig"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memor=
y.h
index 4afb376..47347dd 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -289,6 +289,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
=20
 extern phys_addr_t (*arch_virt_to_idmap)(unsigned long x);
=20
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a30fc9b..8afa848 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARTHUR)		+=3D arthur.o
 obj-$(CONFIG_ISA_DMA)		+=3D dma-isa.o
 obj-$(CONFIG_PCI)		+=3D bios32.o isa.o
 obj-$(CONFIG_ARM_CPU_SUSPEND)	+=3D sleep.o suspend.o
+obj-$(CONFIG_HIBERNATION)	+=3D hibernate.o
 obj-$(CONFIG_SMP)		+=3D smp.o
 ifdef CONFIG_MMU
 obj-$(CONFIG_SMP)		+=3D smp_tlb.o
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
new file mode 100644
index 0000000..bb8b796
--- /dev/null
+++ b/arch/arm/kernel/hibernate.c
@@ -0,0 +1,107 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Derived from work on ARM hibernation support by:
+ *
+ * Ubuntu project, hibernation support for mach-dove
+ * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
+ * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
+ *  https://lkml.org/lkml/2010/6/18/4
+ *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/02=
7422.html
+ *  https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/system_misc.h>
+#include <asm/idmap.h>
+#include <asm/suspend.h>
+#include <asm/memory.h>
+
+extern const void __nosave_begin, __nosave_end;
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn =3D virt_to_pfn(&__nosave_begin);
+	unsigned long nosave_end_pfn =3D virt_to_pfn(&__nosave_end - 1);
+
+	return (pfn >=3D nosave_begin_pfn) && (pfn <=3D nosave_end_pfn);
+}
+
+void notrace save_processor_state(void)
+{
+	WARN_ON(num_online_cpus() !=3D 1);
+	local_fiq_disable();
+}
+
+void notrace restore_processor_state(void)
+{
+	local_fiq_enable();
+}
+
+/*
+ * Snapshot kernel memory and reset the system.
+ *
+ * swsusp_save() is executed in the suspend finisher so that the CPU
+ * context pointer and memory are part of the saved image, which is
+ * required by the resume kernel image to restart execution from
+ * swsusp_arch_suspend().
+ *
+ * soft_restart is not technically needed, but is used to get success
+ * returned from cpu_suspend.
+ *
+ * When soft reboot completes, the hibernation snapshot is written out=
=2E
+ */
+static int notrace arch_save_image(unsigned long unused)
+{
+	int ret;
+
+	ret =3D swsusp_save();
+	if (ret =3D=3D 0)
+		soft_restart(virt_to_phys(cpu_resume));
+	return ret;
+}
+
+/*
+ * Save the current CPU state before suspend / poweroff.
+ */
+int notrace swsusp_arch_suspend(void)
+{
+	return cpu_suspend(0, arch_save_image);
+}
+
+/*
+ * Restore page contents for physical pages that were in use during lo=
ading
+ * hibernation image.  Switch to idmap_pgd so the physical page tables
+ * are overwritten with the same contents.
+ */
+static void notrace arch_restore_image(void *unused)
+{
+	struct pbe *pbe;
+
+	cpu_switch_mm(idmap_pgd, &init_mm);
+	for (pbe =3D restore_pblist; pbe; pbe =3D pbe->next)
+		copy_page(pbe->orig_address, pbe->address);
+
+	soft_restart(virt_to_phys(cpu_resume));
+}
+
+static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
+
+/*
+ * Resume from the hibernation image.
+ * Due to the kernel heap / data restore, stack contents change undern=
eath
+ * and that would make function calls impossible; switch to a temporar=
y
+ * stack within the nosave region to avoid that problem.
+ */
+int swsusp_arch_resume(void)
+{
+	extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
+	call_with_stack(arch_restore_image, 0,
+		resume_stack + ARRAY_SIZE(resume_stack));
+	return 0;
+}
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index f73cabf..38bbf95 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -320,6 +320,8 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 extern void hibernation_set_ops(const struct platform_hibernation_ops =
*ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
+asmlinkage int swsusp_save(void);
+extern struct pbe *restore_pblist;
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned lo=
ng e) {}
 static inline void register_nosave_region_late(unsigned long b, unsign=
ed long e) {}
--=20
1.7.9.5
