From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [RFC][PATCH] ARM: Add initial hibernation support for
	Cortex A8 and A9
Date: Tue, 21 Dec 2010 14:43:59 +0900
Message-ID: <1292910239-4313-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, kyungmin.park@samsung.com, myungjoo.ham@gmail.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hibernation (Suspend-To-Disk) support for ARM Cortex A8 and A9.

This patch is based on the work of Hiroshi DOYU at Nokia, which is
stated to be based on the original work of Romit and Raghu at TI.

The hibernation support is tested with S5PC210 (ARM Cortex A9 MP2). In
order to add support for Cortex A9 on the original patch of Hiroshi
DOYU, which support Cortex A8 only, we have edited the list of registers
to be saved in the case of A9.

In the original work of Hiroshi DOYU, arch/arm/kernel/vmlinux.lds.S was
modified; however, we have reverted it because it only created build
failure in our tested system.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig                |    4 +
 arch/arm/include/asm/memory.h   |    1 +
 arch/arm/include/asm/suspend.h  |    6 +
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/hibernate.c     |  323 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/hibernate_asm.S |  135 ++++++++++++++++
 6 files changed, 470 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/suspend.h
 create mode 100644 arch/arm/kernel/hibernate.c
 create mode 100644 arch/arm/kernel/hibernate_asm.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c..f6e8b58 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -187,6 +187,10 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+	depends on CPU_V7
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 23c2e8e..9f09ad2 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -203,6 +203,7 @@ static inline void *phys_to_virt(unsigned long x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x), 0))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
new file mode 100644
index 0000000..8857c79
--- /dev/null
+++ b/arch/arm/include/asm/suspend.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+#endif	/* __ASM_ARM_SUSPEND_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5b9b268..0b88a62 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HIBERNATION)       += hibernate.o hibernate_asm.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
new file mode 100644
index 0000000..c154f1a
--- /dev/null
+++ b/arch/arm/kernel/hibernate.c
@@ -0,0 +1,323 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+
+
+/* The following architectures are known to be CORTEX_A9 */
+#if defined(CONFIG_ARCH_S5PV310) || defined(CONFIG_ARCH_U8500)
+#define CORTEX_A9
+#else
+/* Assume CORTEX_A8 as default */
+#define CORTEX_A8
+#endif
+
+/*
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW)
+ */
+struct saved_context {
+/*
+ * FIXME: Only support for Cortex A8 and Cortex A9 now
+ */
+	/* CR0 */
+	u32 cssr;	/* Cache Size Selection */
+	/* CR1 */
+#ifdef CORTEX_A8
+	u32 cr;		/* Control */
+	u32 cacr;	/* Coprocessor Access Control */
+#elif defined(CORTEX_A9)
+	u32 cr;
+	u32 actlr;
+	u32 cacr;
+	u32 sder;
+	u32 vcr;
+#endif
+	/* CR2 */
+	u32 ttb_0r;	/* Translation Table Base 0 */
+	u32 ttb_1r;	/* Translation Table Base 1 */
+	u32 ttbcr;	/* Translation Talbe Base Control */
+	/* CR3 */
+	u32 dacr;	/* Domain Access Control */
+	/* CR5 */
+	u32 d_fsr;	/* Data Fault Status */
+	u32 i_fsr;	/* Instruction Fault Status */
+	u32 d_afsr;	/* Data Auxilirary Fault Status */	 ;
+	u32 i_afsr;	/* Instruction Auxilirary Fault Status */;
+	/* CR6 */
+	u32 d_far;	/* Data Fault Address */
+	u32 i_far;	/* Instruction Fault Address */
+	/* CR7 */
+	u32 par;	/* Physical Address */
+	/* CR9 */	/* FIXME: Are they necessary? */
+	u32 pmcontrolr;	/* Performance Monitor Control */
+	u32 cesr;	/* Count Enable Set */
+	u32 cecr;	/* Count Enable Clear */
+	u32 ofsr;	/* Overflow Flag Status */
+#ifdef CORTEX_A8
+	u32 sir;	/* Software Increment */
+#endif
+	u32 pcsr;	/* Performance Counter Selection */
+	u32 ccr;	/* Cycle Count */
+	u32 esr;	/* Event Selection */
+	u32 pmcountr;	/* Performance Monitor Count */
+	u32 uer;	/* User Enable */
+	u32 iesr;	/* Interrupt Enable Set */
+	u32 iecr;	/* Interrupt Enable Clear */
+#ifdef CORTEX_A8
+	u32 l2clr;	/* L2 Cache Lockdown */
+#endif
+	/* CR10 */
+	u32 d_tlblr;	/* Data TLB Lockdown Register */
+#ifdef CORTEX_A8
+	u32 i_tlblr;	/* Instruction TLB Lockdown Register */
+#endif
+	u32 prrr;	/* Primary Region Remap Register */
+	u32 nrrr;	/* Normal Memory Remap Register */
+	/* CR11 */
+#ifdef CORTEX_A8
+	u32 pleuar;	/* PLE User Accessibility */
+	u32 plecnr;	/* PLE Channel Number */
+	u32 plecr;	/* PLE Control */
+	u32 pleisar;	/* PLE Internal Start Address */
+	u32 pleiear;	/* PLE Internal End Address */
+	u32 plecidr;	/* PLE Context ID */
+#endif
+	/* CR12 */
+#ifdef CORTEX_A8
+	u32 snsvbar;	/* Secure or Nonsecure Vector Base Address */
+#elif defined(CORTEX_A9)
+	u32 vbar;
+	u32 mvbar;
+	u32 vir;
+#endif
+	/* CR13 */
+	u32 fcse;	/* FCSE PID */
+	u32 cid;	/* Context ID */
+	u32 urwtpid;	/* User read/write Thread and Process ID */
+	u32 urotpid;	/* User read-only Thread and Process ID */
+	u32 potpid;	/* Privileged only Thread and Process ID */
+	/* CR15 */
+#ifdef CORTEX_A9
+	u32 mtlbar;
+#endif
+} __attribute__((packed));
+
+/* Used in hibernate_asm.S */
+#define USER_CONTEXT_SIZE (15 * sizeof(u32))
+unsigned long saved_context_r0[USER_CONTEXT_SIZE];
+unsigned long saved_cpsr;
+unsigned long saved_context_r13_svc;
+unsigned long saved_context_r14_svc;
+unsigned long saved_spsr_svc;
+
+static struct saved_context saved_context;
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+/*
+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin)
+		>> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end))
+		>> PAGE_SHIFT;
+
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+static inline void __save_processor_state(struct saved_context *ctxt)
+{
+	/* CR0 */
+	asm volatile ("mrc p15, 2, %0, c0, c0, 0" : "=r"(ctxt->cssr));
+	/* CR1 */
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->cr));
+	asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->cacr));
+#elif defined(CORTEX_A9)
+	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->cr));
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r"(ctxt->actlr));
+	asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->cacr));
+	asm volatile ("mrc p15, 0, %0, c1, c1, 1" : "=r"(ctxt->sder));
+	asm volatile ("mrc p15, 0, %0, c1, c1, 3" : "=r"(ctxt->vcr));
+#endif
+	/* CR2 */
+	asm volatile ("mrc p15, 0, %0, c2, c0, 0" : "=r"(ctxt->ttb_0r));
+	asm volatile ("mrc p15, 0, %0, c2, c0, 1" : "=r"(ctxt->ttb_1r));
+	asm volatile ("mrc p15, 0, %0, c2, c0, 2" : "=r"(ctxt->ttbcr));
+	/* CR3 */
+	asm volatile ("mrc p15, 0, %0, c3, c0, 0" : "=r"(ctxt->dacr));
+	/* CR5 */
+	asm volatile ("mrc p15, 0, %0, c5, c0, 0" : "=r"(ctxt->d_fsr));
+	asm volatile ("mrc p15, 0, %0, c5, c0, 1" : "=r"(ctxt->i_fsr));
+	asm volatile ("mrc p15, 0, %0, c5, c1, 0" : "=r"(ctxt->d_afsr));
+	asm volatile ("mrc p15, 0, %0, c5, c1, 1" : "=r"(ctxt->i_afsr));
+	/* CR6 */
+	asm volatile ("mrc p15, 0, %0, c6, c0, 0" : "=r"(ctxt->d_far));
+	asm volatile ("mrc p15, 0, %0, c6, c0, 2" : "=r"(ctxt->i_far));
+	/* CR7 */
+	asm volatile ("mrc p15, 0, %0, c7, c4, 0" : "=r"(ctxt->par));
+	/* CR9 */
+	asm volatile ("mrc p15, 0, %0, c9, c12, 0" : "=r"(ctxt->pmcontrolr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 1" : "=r"(ctxt->cesr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 2" : "=r"(ctxt->cecr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 3" : "=r"(ctxt->ofsr));
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 0, %0, c9, c12, 4" : "=r"(ctxt->sir));
+#endif
+	asm volatile ("mrc p15, 0, %0, c9, c12, 5" : "=r"(ctxt->pcsr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 0" : "=r"(ctxt->ccr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 1" : "=r"(ctxt->esr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 2" : "=r"(ctxt->pmcountr));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 0" : "=r"(ctxt->uer));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 1" : "=r"(ctxt->iesr));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 2" : "=r"(ctxt->iecr));
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 1, %0, c9, c0, 0" : "=r"(ctxt->l2clr));
+#endif
+	/* CR10 */
+	asm volatile ("mrc p15, 0, %0, c10, c0, 0" : "=r"(ctxt->d_tlblr));
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 0, %0, c10, c0, 1" : "=r"(ctxt->i_tlblr));
+#endif
+	asm volatile ("mrc p15, 0, %0, c10, c2, 0" : "=r"(ctxt->prrr));
+	asm volatile ("mrc p15, 0, %0, c10, c2, 1" : "=r"(ctxt->nrrr));
+	/* CR11 */
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 0, %0, c11, c1, 0" : "=r"(ctxt->pleuar));
+	asm volatile ("mrc p15, 0, %0, c11, c2, 0" : "=r"(ctxt->plecnr));
+	asm volatile ("mrc p15, 0, %0, c11, c4, 0" : "=r"(ctxt->plecr));
+	asm volatile ("mrc p15, 0, %0, c11, c5, 0" : "=r"(ctxt->pleisar));
+	asm volatile ("mrc p15, 0, %0, c11, c7, 0" : "=r"(ctxt->pleiear));
+	asm volatile ("mrc p15, 0, %0, c11, c15, 0" : "=r"(ctxt->plecidr));
+#endif
+	/* CR12 */
+#ifdef CORTEX_A8
+	asm volatile ("mrc p15, 0, %0, c12, c0, 0" : "=r"(ctxt->snsvbar));
+#elif defined(CORTEX_A9)
+	asm volatile ("mrc p15, 0, %0, c12, c0, 0" : "=r"(ctxt->vbar));
+	asm volatile ("mrc p15, 0, %0, c12, c0, 1" : "=r"(ctxt->mvbar));
+	asm volatile ("mrc p15, 0, %0, c12, c1, 1" : "=r"(ctxt->vir));
+#endif
+	/* CR13 */
+	asm volatile ("mrc p15, 0, %0, c13, c0, 0" : "=r"(ctxt->fcse));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 1" : "=r"(ctxt->cid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 2" : "=r"(ctxt->urwtpid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 3" : "=r"(ctxt->urotpid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 4" : "=r"(ctxt->potpid));
+	/* CR15*/
+#ifdef CORTEX_A9
+	asm volatile ("mrc p15, 5, %0, c15, c7, 2" : "=r"(ctxt->mtlbar));
+#endif
+}
+
+static inline void __restore_processor_state(struct saved_context *ctxt)
+{
+	/* CR0 */
+	asm volatile ("mcr p15, 2, %0, c0, c0, 0" : : "r"(ctxt->cssr));
+	/* CR1 */
+#if defined(CORTEX_A8)
+	asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r"(ctxt->cr));
+	asm volatile ("mcr p15, 0, %0, c1, c0, 2" : : "r"(ctxt->cacr));
+#elif defined(CORTEX_A9)
+	asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r"(ctxt->cr));
+	asm volatile ("mcr p15, 0, %0, c1, c0, 1" : : "r"(ctxt->actlr));
+	asm volatile ("mcr p15, 0, %0, c1, c0, 2" : : "r"(ctxt->cacr));
+	asm volatile ("mcr p15, 0, %0, c1, c1, 1" : : "r"(ctxt->sder));
+	asm volatile ("mcr p15, 0, %0, c1, c1, 3" : : "r"(ctxt->vcr));
+#endif
+	/* CR2 */
+	asm volatile ("mcr p15, 0, %0, c2, c0, 0" : : "r"(ctxt->ttb_0r));
+	asm volatile ("mcr p15, 0, %0, c2, c0, 1" : : "r"(ctxt->ttb_1r));
+	asm volatile ("mcr p15, 0, %0, c2, c0, 2" : : "r"(ctxt->ttbcr));
+	/* CR3 */
+	asm volatile ("mcr p15, 0, %0, c3, c0, 0" : : "r"(ctxt->dacr));
+	/* CR5 */
+	asm volatile ("mcr p15, 0, %0, c5, c0, 0" : : "r"(ctxt->d_fsr));
+	asm volatile ("mcr p15, 0, %0, c5, c0, 1" : : "r"(ctxt->i_fsr));
+	asm volatile ("mcr p15, 0, %0, c5, c1, 0" : : "r"(ctxt->d_afsr));
+	asm volatile ("mcr p15, 0, %0, c5, c1, 1" : : "r"(ctxt->i_afsr));
+	/* CR6 */
+	asm volatile ("mcr p15, 0, %0, c6, c0, 0" : : "r"(ctxt->d_far));
+	asm volatile ("mcr p15, 0, %0, c6, c0, 2" : : "r"(ctxt->i_far));
+	/* CR7 */
+	asm volatile ("mcr p15, 0, %0, c7, c4, 0" : : "r"(ctxt->par));
+	/* CR9 */
+	asm volatile ("mcr p15, 0, %0, c9, c12, 0" : : "r"(ctxt->pmcontrolr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 1" : : "r"(ctxt->cesr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 2" : : "r"(ctxt->cecr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 3" : : "r"(ctxt->ofsr));
+#ifdef CORTEX_A8
+	asm volatile ("mcr p15, 0, %0, c9, c12, 4" : : "r"(ctxt->sir));
+#endif
+	asm volatile ("mcr p15, 0, %0, c9, c12, 5" : : "r"(ctxt->pcsr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 0" : : "r"(ctxt->ccr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 1" : : "r"(ctxt->esr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 2" : : "r"(ctxt->pmcountr));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 0" : : "r"(ctxt->uer));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 1" : : "r"(ctxt->iesr));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 2" : : "r"(ctxt->iecr));
+#ifdef CORTEX_A8
+	asm volatile ("mcr p15, 1, %0, c9, c0, 0" : : "r"(ctxt->l2clr));
+#endif
+	/* CR10 */
+	asm volatile ("mcr p15, 0, %0, c10, c0, 0" : : "r"(ctxt->d_tlblr));
+#ifdef CORTEX_A8
+	asm volatile ("mcr p15, 0, %0, c10, c0, 1" : : "r"(ctxt->i_tlblr));
+#endif
+	asm volatile ("mcr p15, 0, %0, c10, c2, 0" : : "r"(ctxt->prrr));
+	asm volatile ("mcr p15, 0, %0, c10, c2, 1" : : "r"(ctxt->nrrr));
+	/* CR11 */
+#ifdef CORTEX_A8
+	asm volatile ("mcr p15, 0, %0, c11, c1, 0" : : "r"(ctxt->pleuar));
+	asm volatile ("mcr p15, 0, %0, c11, c2, 0" : : "r"(ctxt->plecnr));
+	asm volatile ("mcr p15, 0, %0, c11, c4, 0" : : "r"(ctxt->plecr));
+	asm volatile ("mcr p15, 0, %0, c11, c5, 0" : : "r"(ctxt->pleisar));
+	asm volatile ("mcr p15, 0, %0, c11, c7, 0" : : "r"(ctxt->pleiear));
+	asm volatile ("mcr p15, 0, %0, c11, c15, 0" : : "r"(ctxt->plecidr));
+#endif
+	/* CR12 */
+#ifdef CORTEX_A8
+	asm volatile ("mcr p15, 0, %0, c12, c0, 0" : : "r"(ctxt->snsvbar));
+#elif defined(CORTEX_A9)
+	asm volatile ("mcr p15, 0, %0, c12, c0, 0" : : "r"(ctxt->vbar));
+	asm volatile ("mcr p15, 0, %0, c12, c0, 1" : : "r"(ctxt->mvbar));
+	asm volatile ("mcr p15, 0, %0, c12, c1, 1" : : "r"(ctxt->vir));
+#endif
+	/* CR13 */
+	asm volatile ("mcr p15, 0, %0, c13, c0, 0" : : "r"(ctxt->fcse));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 1" : : "r"(ctxt->cid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 2" : : "r"(ctxt->urwtpid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 3" : : "r"(ctxt->urotpid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 4" : : "r"(ctxt->potpid));
+	/* CR15 */
+#ifdef CORTEX_A9
+	asm volatile ("mcr p15, 5, %0, c15, c7, 2" : : "r"(ctxt->mtlbar));
+#endif
+}
+
+void save_processor_state(void)
+{
+	preempt_disable();
+	__save_processor_state(&saved_context);
+}
+
+void restore_processor_state(void)
+{
+	__restore_processor_state(&saved_context);
+	preempt_enable();
+}
diff --git a/arch/arm/kernel/hibernate_asm.S b/arch/arm/kernel/hibernate_asm.S
new file mode 100644
index 0000000..6fc199c
--- /dev/null
+++ b/arch/arm/kernel/hibernate_asm.S
@@ -0,0 +1,135 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/linkage.h>
+	.text
+ENTRY(swsusp_arch_suspend)
+	/*
+	 * Save current program status register
+	 */
+	ldr     r3, .Lsaved_cpsr
+	mrs     r0, cpsr
+	str     r0, [r3]
+
+	/*
+	 * Change to system(user) mode
+	 */
+	mov     r1, r0
+	orr     r1, r1, #0x1f
+	msr     cpsr_c, r1
+
+	/*
+	 * Save User context
+	 */
+	ldr     r3, .Lsaved_context_r0
+	stmia   r3, {r0-r14}
+
+	/*
+	 * Go back to original SVC mode
+	 */
+	msr     cpsr_c, r0
+
+	/*
+	 * Save SVC context
+	 */
+	ldr     r3, .Lsaved_context_r13_svc
+	stmia   r3, {r13-r14}
+	ldr     r3, .Lsaved_spsr_svc
+	mrs     r1, spsr
+	str     r1, [r3]
+
+	bl      swsusp_save
+
+	/*
+	 * Restore return address
+	 */
+	ldr     r3, .Lsaved_context_r14_svc
+	ldr     lr, [r3]
+	mov     pc, lr
+ENDPROC(swsusp_arch_suspend)
+
+ENTRY(swsusp_arch_resume)
+	/*
+	 * Restore_pblist is the starting point for loaded pages
+	 */
+	ldr     r0, .Lrestore_pblist
+	ldr     r6, [r0]
+
+.Lcopy_loop:
+	ldr     r4, [r6]     /* src IOW present address */
+	ldr     r5, [r6, #4] /* dst IOW original address*/
+	mov     r9, #1024    /* No. of entries in one page, where each entry is 4 bytes */
+
+.Lcopy_one_page:
+	/*
+	 * This loop could be optimized by using stm and ldm.
+	 */
+	ldr     r8, [r4], #4
+	str     r8, [r5], #4
+	subs    r9, r9, #1
+	bne     .Lcopy_one_page
+
+	/* The last field of struct pbe is a pointer to the next pbe structure */
+	ldr     r6, [r6, #8]
+	cmp     r6, #0
+	bne     .Lcopy_loop
+
+	/*
+	 * Restore SVC context
+	 */
+	ldr     r3, .Lsaved_context_r13_svc
+	ldmia   r3, {r13-r14}
+	ldr     r3, .Lsaved_spsr_svc
+	ldr     r1, [r3]
+	msr     spsr_cxsf, r1
+
+	mrs     r0, cpsr	/* Save current mode into r0 */
+
+	/*
+	 * Change to system(user) mode
+	 */
+	mov     r1, r0
+	orr     r1, r1, #0x1f
+	msr     cpsr_c, r1
+
+	/*
+	 * Restore User context
+	 */
+	ldr     r3, .Lsaved_context_r0
+	ldmia   r3, {r0-r14}
+	ldr     r3, .Lsaved_cpsr
+	ldr     r1, [r3]
+	msr     cpsr_cxsf, r1
+
+	msr     cpsr_c, r0	/* Restore original mode from r0 */
+
+	/*
+	 * Flush TLB (Invalidate unified TLB unlocked entries)
+	 */
+	mov     r1, #0
+	mcr     p15, 0, r1, c8, c7, 0
+
+	/* Set the return value */
+	mov	r0, #0
+
+	/* Restore return address */
+	ldr     r3, .Lsaved_context_r14_svc
+	ldr     lr, [r3]
+	mov     pc, lr
+ENDPROC(swsusp_arch_resume)
+	.align	4
+.Lsaved_context_r0:		.long	saved_context_r0
+.Lsaved_cpsr:			.long	saved_cpsr
+.Lsaved_context_r13_svc: 	.long	saved_context_r13_svc
+.Lsaved_context_r14_svc:	.long	saved_context_r14_svc
+.Lsaved_spsr_svc:		.long	saved_spsr_svc
+.Lrestore_pblist:		.long	restore_pblist
-- 
1.7.1
