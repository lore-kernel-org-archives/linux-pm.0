From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 06/12] powerpc: fix suspend states again
Date: Wed, 07 Feb 2007 13:45:42 +0100
Message-ID: <20070207124612.612467000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=fix-powermac-suspend-again.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

In commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2 (a very long time ago,
May 2006), I fixed a bug that caused powermacs to crash when you tried
entering standby/mem suspend states.

As I'm now getting more familiar with the suspend code I notice a few
more things:
 1. we previously misunderstood what pm_ops is for, it isn't supposed to be
    for doing platform dependent suspend/resume stuff that needs to be done
    for suspend to disk (as we currently try to use it!), it is instead for
    entering platform dependent suspend states ("standby", "mem").
 2. due to the first point, we never properly save FPU and altivec states
    when suspending to disk. It probably hasn't hurt yet because the process
    that writes the "disk" to /sys/power/state uses neither and its context
    is used.

This patch addresses these points as follows:
 1. remove all pm_ops from powermac, powermac suspend to ram isn't currently
    usable via /sys/power/state but is done via the PMU instead.
 2. move the code responsible for storing FPU/altivec state into a new
    arch_prepare_suspend function (previously, this was only present for
    32-bit platforms from asm-ppc.)

I removed
	set_context(current->active_mm->context.id, current->active_mm->pgd);
because
 1. it works without and
 2. I don't know what the point is

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-07 0=
2:55:27.388884289 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2007-02-07 02:55:=
32.107884289 +0100
@@ -420,76 +420,11 @@ static void __init find_boot_device(void
 #endif
 }
 =

-/* TODO: Merge the suspend-to-ram with the common code !!!
- * currently, this is a stub implementation for suspend-to-disk
- * only
- */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-static int pmac_pm_prepare(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	return 0;
-}
-
-static int pmac_pm_enter(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Giveup the lazy FPU & vec so we don't have to back them
-	 * up from the low level code
-	 */
-	enable_kernel_fp();
-
-#ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
-		enable_kernel_altivec();
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static int pmac_pm_finish(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
-
-	return 0;
-}
-
-static int pmac_pm_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_DISK:
-		return 1;
-	/* can't do any other states via generic mechanism yet */
-	default:
-		return 0;
-	}
-}
-
-static struct pm_ops pmac_pm_ops =3D {
-	.pm_disk_mode	=3D PM_DISK_SHUTDOWN,
-	.prepare	=3D pmac_pm_prepare,
-	.enter		=3D pmac_pm_enter,
-	.finish		=3D pmac_pm_finish,
-	.valid		=3D pmac_pm_valid,
-};
-
-#endif /* CONFIG_SOFTWARE_SUSPEND */
-
 static int initializing =3D 1;
 =

 static int pmac_late_init(void)
 {
 	initializing =3D 0;
-#ifdef CONFIG_SOFTWARE_SUSPEND
-	pm_set_ops(&pmac_pm_ops);
-#endif /* CONFIG_SOFTWARE_SUSPEND */
 	/* this is udbg (which is __init) and we can later use it during
 	 * cpu hotplug (in smp_core99_kick_cpu) */
 	ppc_md.progress =3D NULL;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/include/asm-powerpc/suspend.h	2007-02-07 02:55:32.1248842=
89 +0100
@@ -0,0 +1,9 @@
+#ifndef __ASM_POWERPC_SUSPEND_H
+#define __ASM_POWERPC_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+void save_processor_state(void);
+static inline void restore_processor_state(void) {}
+
+#endif /* __ASM_POWERPC_SUSPEND_H */
--- linux-2.6-git.orig/arch/powerpc/kernel/Makefile	2007-02-07 02:55:00.582=
884289 +0100
+++ linux-2.6-git/arch/powerpc/kernel/Makefile	2007-02-07 02:55:32.13488428=
9 +0100
@@ -35,6 +35,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+=3D smp-tbsy
 obj-$(CONFIG_CRASH_DUMP)	+=3D crash_dump.o
 obj-$(CONFIG_6xx)		+=3D idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+=3D tau_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+=3D swsusp.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) +=3D swsusp_32.o
 obj32-$(CONFIG_MODULES)		+=3D module_32.o
 =

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-git/arch/powerpc/kernel/swsusp.c	2007-02-07 02:55:32.15288428=
9 +0100
@@ -0,0 +1,26 @@
+/*
+ * Common powerpc suspend code for 32 and 64 bits
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <asm/cputable.h>
+#include <asm/system.h>
+
+
+int save_processor_state(void)
+{
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	return 0;
+}

--
