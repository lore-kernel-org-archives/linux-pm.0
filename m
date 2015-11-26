From: James Morse <james.morse@arm.com>
Subject: [PATCH v3 10/10] arm64: kernel: Add support for hibernate/suspend-to-disk.
Date: Thu, 26 Nov 2015 17:32:48 +0000
Message-ID: <1448559168-8363-11-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46312 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbbKZRea (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 26 Nov 2015 12:34:30 -0500
In-Reply-To: <1448559168-8363-1-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, James Morse <james.morse@arm.com>

Add support for hibernate/suspend-to-disk.

Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
before calling swsusp_save() to save the memory image.

Restore creates a set of temporary page tables, covering the kernel and the
linear map, copies the restore code to a 'safe' page, then uses the copy to
restore the memory image. It calls into cpu_resume(),
and then follows the normal cpu_suspend() path back into the suspend code.

The implementation assumes that exactly the same kernel is booted on the
same hardware, and that the kernel is loaded at the same physical address.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/arm64/Kconfig                |   3 +
 arch/arm64/include/asm/suspend.h  |   8 +
 arch/arm64/kernel/Makefile        |   1 +
 arch/arm64/kernel/asm-offsets.c   |   4 +
 arch/arm64/kernel/hibernate-asm.S | 119 ++++++++++++
 arch/arm64/kernel/hibernate.c     | 376 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S   |  15 ++
 7 files changed, 526 insertions(+)
 create mode 100644 arch/arm64/kernel/hibernate-asm.S
 create mode 100644 arch/arm64/kernel/hibernate.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ac16a482ff1..b15d831f4016 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -769,6 +769,9 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 5faa3ce1fa3a..e75ad7aa268c 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -1,3 +1,5 @@
+#include <linux/suspend.h>
+
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
@@ -34,6 +36,12 @@ struct sleep_stack_data {
 	unsigned long		callee_saved_regs[NR_CALLEE_SAVED_REGS];
 };
 
+extern int swsusp_arch_suspend(void);
+extern int swsusp_arch_resume(void);
+int swsusp_arch_suspend_enter(struct cpu_suspend_ctx *ptr);
+void __noreturn swsusp_arch_suspend_exit(phys_addr_t tmp_pg_dir,
+					 phys_addr_t swapper_pg_dir,
+					 void *kernel_start, void *kernel_end);
 extern int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
 int __cpu_suspend_enter(struct sleep_stack_data *state);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 474691f8b13a..71da22197963 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -41,6 +41,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_HIBERNATION)		+= hibernate.o hibernate-asm.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7e0be84e1bdc..15c36aae6fac 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
+#include <linux/suspend.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/smp_plat.h>
@@ -160,5 +161,8 @@ int main(void)
   DEFINE(SLEEP_STACK_DATA_SYSTEM_REGS,	offsetof(struct sleep_stack_data, system_regs));
   DEFINE(SLEEP_STACK_DATA_CALLEE_REGS,	offsetof(struct sleep_stack_data, callee_saved_regs));
 #endif
+  DEFINE(HIBERN_PBE_ORIG,	offsetof(struct pbe, orig_address));
+  DEFINE(HIBERN_PBE_ADDR,	offsetof(struct pbe, address));
+  DEFINE(HIBERN_PBE_NEXT,	offsetof(struct pbe, next));
   return 0;
 }
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
new file mode 100644
index 000000000000..db3e4d6bb68e
--- /dev/null
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -0,0 +1,119 @@
+#include <linux/linkage.h>
+#include <linux/errno.h>
+
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+#include <asm/cputype.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+
+/*
+ * Corrupt memory.
+ *
+ * Loads temporary page tables then restores the memory image.
+ * Finally branches to cpu_resume() to restore the state saved by
+ * swsusp_arch_suspend().
+ *
+ * Because this code has to be copied to a safe_page, it can't call out to
+ * other functions by PC-relative address. Also remember that it may be
+ * mid-way through over-writing other functions. For this reason it contains
+ * a copy of copy_page() and code from flush_icache_range().
+ *
+ * All of memory gets written to, including code. We need to clean the kernel
+ * text to the Point of Coherence (PoC) before secondary cores can be booted.
+ * Because the kernel modules and executable pages mapped to user space are
+ * also written as data,  we clean all pages we touch to the Point of
+ * Unification (PoU).
+ *
+ * x0: physical address of temporary page tables
+ * x1: physical address of swapper page tables
+ * x2: address of kernel_start
+ * x3: address of kernel_end
+ */
+.pushsection    ".hibernate_exit.text", "ax"
+ENTRY(swsusp_arch_suspend_exit)
+	/* Temporary page tables are a copy, so no need for a trampoline here */
+	msr	ttbr1_el1, x0
+	isb
+	tlbi	vmalle1is
+	ic	ialluis
+	isb
+
+	mov	x21, x1
+	mov	x22, x2
+	mov	x23, x3
+
+	/* walk the restore_pblist and use copy_page() to over-write memory */
+	ldr	x19, =restore_pblist
+	ldr	x19, [x19]
+
+2:	ldr	x10, [x19, #HIBERN_PBE_ORIG]
+	mov	x0, x10
+	ldr	x1, [x19, #HIBERN_PBE_ADDR]
+
+	/* arch/arm64/lib/copy_page.S:copy_page() */
+	prfm	pldl1strm, [x1, #64]
+3:	ldp	x2, x3, [x1]
+	ldp	x4, x5, [x1, #16]
+	ldp	x6, x7, [x1, #32]
+	ldp	x8, x9, [x1, #48]
+	add	x1, x1, #64
+	prfm	pldl1strm, [x1, #64]
+	stnp	x2, x3, [x0]
+	stnp	x4, x5, [x0, #16]
+	stnp	x6, x7, [x0, #32]
+	stnp	x8, x9, [x0, #48]
+	add	x0, x0, #64
+	tst	x1, #(PAGE_SIZE - 1)
+	b.ne	3b
+
+	dsb	ish		//  memory restore must finish before cleaning
+
+	add	x1, x10, #PAGE_SIZE
+	/* Clean the copied page to PoU - based on flush_icache_range() */
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x4, x10, x3
+4:	dc	cvau, x4	// clean D line / unified line
+	add	x4, x4, x2
+	cmp	x4, x1
+	b.lo	4b
+
+	ldr	x19, [x19, #HIBERN_PBE_NEXT]
+	cbnz	x19, 2b
+
+	/* Clean the kernel text to PoC - based on flush_icache_range() */
+	dcache_line_size x2, x3
+	sub	x3, x2, #1
+	bic	x4, x22, x3
+5:	dc	cvac, x4
+	add	x4, x4, x2
+	cmp	x4, x23
+	b.lo	5b
+
+	/*
+	 * branch into the restored kernel - so that when we restore the page
+	 * tables, code continues to be executable.
+	 */
+	ldr	x1, =__hibernate_exit
+	mov	x0, x21		// physical address of swapper page tables.
+	br	x1
+
+	.ltorg
+ENDPROC(swsusp_arch_suspend_exit)
+.popsection
+
+/*
+ * Reset the page tables, and wake up in cpu_resume().
+ * Temporary page tables were a copy, so again, no trampoline here.
+ *
+ * x0: physical address of swapper_pg_dir
+ */
+ENTRY(__hibernate_exit)
+	msr	ttbr1_el1, x0
+	isb
+	tlbi	vmalle1is
+	ic	ialluis
+	isb
+	b	_cpu_resume
+ENDPROC(__hibernate_exit)
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
new file mode 100644
index 000000000000..ff2fe72e7d95
--- /dev/null
+++ b/arch/arm64/kernel/hibernate.c
@@ -0,0 +1,376 @@
+/*:
+ * Hibernate support specific for ARM64
+ *
+ * Derived from work on ARM hibernation support by:
+ *
+ * Ubuntu project, hibernation support for mach-dove
+ * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
+ * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
+ *  https://lkml.org/lkml/2010/6/18/4
+ *  https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
+ *  https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#define pr_fmt(x) "hibernate: " x
+#include <linux/kvm_host.h>
+#include <linux/mm.h>
+#include <linux/pm.h>
+#include <linux/sched.h>
+#include <linux/suspend.h>
+#include <linux/version.h>
+
+#include <asm/barrier.h>
+#include <asm/cacheflush.h>
+#include <asm/irqflags.h>
+#include <asm/memory.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/pgtable-hwdef.h>
+#include <asm/sections.h>
+#include <asm/suspend.h>
+
+/* These are necessary to build without ifdefery */
+#ifndef pmd_index
+#define pmd_index(x)	0
+#endif
+#ifndef pud_index
+#define pud_index(x)	0
+#endif
+
+/*
+ * Start/end of the hibernate exit code, this must be copied to a 'safe'
+ * location in memory, and executed from there.
+ */
+extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
+	unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
+
+	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
+}
+
+void notrace save_processor_state(void)
+{
+	WARN_ON(num_online_cpus() != 1);
+	local_fiq_disable();
+}
+
+void notrace restore_processor_state(void)
+{
+	local_fiq_enable();
+}
+
+/*
+ * Copies src_length bytes, starting at src_start into an new page,
+ * perform cache maintentance, then map it at the top of memory as executable.
+ *
+ * This is used by hibernate to copy the code it needs to execute when
+ * overwriting the kernel text.
+ *
+ * Suggested allocators are get_safe_page() or get_zeroed_page(). Your chosen
+ * mask must cause zero'd pages to be returned.
+ */
+static int create_safe_exec_page(void *src_start, size_t length,
+				 void **dst_addr,
+				 unsigned long (*allocator)(gfp_t mask),
+				 gfp_t mask)
+{
+	int rc = 0;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	unsigned long dst = allocator(mask);
+
+	if (!dst) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	memcpy((void *)dst, src_start, length);
+	flush_icache_range(dst, dst + length);
+
+	pgd = pgd_offset(&init_mm, (unsigned long)-1);
+	if (!pgd_val(*pgd) && PTRS_PER_PGD > 1) {
+		pud = (pud_t *)allocator(mask);
+		if (!pud) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pgd(pgd, __pgd(virt_to_phys(pud) | PUD_TYPE_TABLE));
+	}
+
+	pud = pud_offset(pgd, (unsigned long)-1);
+	if (!pud_val(*pud) && PTRS_PER_PUD > 1) {
+		pmd = (pmd_t *)allocator(mask);
+		if (!pmd) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pud(pud, __pud(virt_to_phys(pmd) | PUD_TYPE_TABLE));
+	}
+
+	pmd = pmd_offset(pud, (unsigned long)-1);
+	if (!pmd_val(*pmd) && PTRS_PER_PMD > 1) {
+		pte = (pte_t *)allocator(mask);
+		if (!pte) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		set_pmd(pmd, __pmd(virt_to_phys(pte) | PMD_TYPE_TABLE));
+	}
+
+	pte = pte_offset_kernel(pmd, (unsigned long)-1);
+	set_pte_at(&init_mm, dst, pte,
+		   __pte(virt_to_phys((void *)dst)
+			 | pgprot_val(PAGE_KERNEL_EXEC)));
+
+	/* this is a new mapping, so no need for a tlbi */
+
+	*dst_addr = (void *)((unsigned long)-1 & PAGE_MASK);
+
+out:
+	return rc;
+}
+
+
+int swsusp_arch_suspend(void)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct sleep_stack_data state;
+	struct mm_struct *mm = current->active_mm;
+
+	local_dbg_save(flags);
+
+	if (__cpu_suspend_enter(&state))
+		ret = swsusp_save();
+	else
+		__cpu_suspend_exit(mm);
+
+	local_dbg_restore(flags);
+
+	return ret;
+}
+
+static int copy_pte(pmd_t *dst, pmd_t *src, unsigned long *start_addr)
+{
+	int i;
+	pte_t *old_pte = pte_offset_kernel(src, *start_addr);
+	pte_t *new_pte = pte_offset_kernel(dst, *start_addr);
+
+	for (i = pte_index(*start_addr); i < PTRS_PER_PTE;
+	     i++, old_pte++, new_pte++) {
+		if (pte_val(*old_pte))
+			set_pte(new_pte,
+				__pte(pte_val(*old_pte) & ~PTE_RDONLY));
+	}
+
+	*start_addr &= PAGE_MASK;
+
+	return 0;
+}
+
+static int copy_pmd(pud_t *dst, pud_t *src, unsigned long *start_addr)
+{
+	int i;
+	int rc = 0;
+	pte_t *new_pte;
+	pmd_t *old_pmd = pmd_offset(src, *start_addr);
+	pmd_t *new_pmd = pmd_offset(dst, *start_addr);
+
+	for (i = pmd_index(*start_addr); i < PTRS_PER_PMD;
+	     i++, *start_addr += PMD_SIZE, old_pmd++, new_pmd++) {
+		if (!pmd_val(*old_pmd))
+			continue;
+
+		if (pmd_table(*(old_pmd))) {
+			new_pte = (pte_t *)get_safe_page(GFP_ATOMIC);
+			if (!new_pte) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pmd(new_pmd, __pmd(virt_to_phys(new_pte)
+					       | PMD_TYPE_TABLE));
+
+			rc = copy_pte(new_pmd, old_pmd, start_addr);
+			if (rc)
+				break;
+		} else
+			set_pmd(new_pmd,
+				__pmd(pmd_val(*old_pmd) & ~PMD_SECT_RDONLY));
+
+		*start_addr &= PMD_MASK;
+	}
+
+	return rc;
+}
+
+static int copy_pud(pgd_t *dst, pgd_t *src, unsigned long *start_addr)
+{
+	int i;
+	int rc = 0;
+	pmd_t *new_pmd;
+	pud_t *old_pud = pud_offset(src, *start_addr);
+	pud_t *new_pud = pud_offset(dst, *start_addr);
+
+	for (i = pud_index(*start_addr); i < PTRS_PER_PUD;
+	     i++, *start_addr += PUD_SIZE, old_pud++, new_pud++) {
+		if (!pud_val(*old_pud))
+			continue;
+
+		if (pud_table(*(old_pud))) {
+			if (PTRS_PER_PMD != 1) {
+				new_pmd = (pmd_t *)get_safe_page(GFP_ATOMIC);
+				if (!new_pmd) {
+					rc = -ENOMEM;
+					break;
+				}
+
+				set_pud(new_pud, __pud(virt_to_phys(new_pmd)
+						       | PUD_TYPE_TABLE));
+			}
+
+			rc = copy_pmd(new_pud, old_pud, start_addr);
+			if (rc)
+				break;
+		} else
+			set_pud(new_pud,
+				__pud(pud_val(*old_pud) & ~PMD_SECT_RDONLY));
+
+		*start_addr &= PUD_MASK;
+	}
+
+	return rc;
+}
+
+static int copy_page_tables(pgd_t *new_pgd, unsigned long start_addr)
+{
+	int i;
+	int rc = 0;
+	pud_t *new_pud;
+	pgd_t *old_pgd = pgd_offset_k(start_addr);
+
+	new_pgd += pgd_index(start_addr);
+
+	for (i = pgd_index(start_addr); i < PTRS_PER_PGD;
+	     i++, start_addr += PGDIR_SIZE, old_pgd++, new_pgd++) {
+		if (!pgd_val(*old_pgd))
+			continue;
+
+		if (PTRS_PER_PUD != 1) {
+			new_pud = (pud_t *)get_safe_page(GFP_ATOMIC);
+			if (!new_pud) {
+				rc = -ENOMEM;
+				break;
+			}
+
+			set_pgd(new_pgd, __pgd(virt_to_phys(new_pud)
+					       | PUD_TYPE_TABLE));
+		}
+
+		rc = copy_pud(new_pgd, old_pgd, &start_addr);
+		if (rc)
+			break;
+
+		start_addr &= PGDIR_MASK;
+	}
+
+	return rc;
+}
+
+/*
+ * Setup then Resume from the hibernate image using swsusp_arch_suspend_exit().
+ *
+ * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
+ * we don't need to free it here.
+ *
+ * Allocate a safe zero page to use as ttbr0, as all existing page tables, and
+ * even the empty_zero_page will be overwritten.
+ */
+int swsusp_arch_resume(void)
+{
+	int rc = 0;
+	size_t exit_size;
+	pgd_t *tmp_pg_dir;
+	void *safe_zero_page_mem;
+	unsigned long tmp_pg_start;
+	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t,
+					  void *, void *);
+
+	/* Copy swsusp_arch_suspend_exit() to a safe page. */
+	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
+	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
+			(void **)&hibernate_exit, get_safe_page, GFP_ATOMIC);
+	if (rc) {
+		pr_err("Failed to create safe executable page for"
+		       " hibernate_exit code.");
+		goto out;
+	}
+
+	/*
+	 * Even the zero page may get overwritten during restore.
+	 * get_safe_page() only returns zero'd pages.
+	 */
+	safe_zero_page_mem = (void *)get_safe_page(GFP_ATOMIC);
+	if (!safe_zero_page_mem) {
+		pr_err("Failed to allocate memory for zero page.");
+		rc = -ENOMEM;
+		goto out;
+	}
+	empty_zero_page = virt_to_page(safe_zero_page_mem);
+	cpu_set_reserved_ttbr0();
+
+	/*
+	 * Restoring the memory image will overwrite the ttbr1 page tables.
+	 * Create a second copy, of the kernel and linear map, and use this
+	 * when restoring.
+	 */
+	tmp_pg_dir = (pgd_t *)get_safe_page(GFP_ATOMIC);
+	if (!tmp_pg_dir) {
+		pr_err("Failed to allocate memory for temporary page tables.");
+		rc = -ENOMEM;
+		goto out;
+	}
+	tmp_pg_start = min((unsigned long)KERNEL_START,
+			   (unsigned long)PAGE_OFFSET);
+	rc = copy_page_tables(tmp_pg_dir, tmp_pg_start);
+	if (rc)
+		goto out;
+
+	/*
+	 * EL2 may get upset if we overwrite its page-tables/stack.
+	 * kvm_arch_hardware_disable() returns EL2 to the hyp stub. This
+	 * isn't needed on normal suspend/resume as PSCI prevents us from
+	 * ruining EL2.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_ARM_HOST))
+		kvm_arch_hardware_disable();
+
+	/*
+	 * Some pages are read directly into their final location by
+	 * kernel/power/snapshot.c, these are listed in
+	 * restored_inplace_pblist. Some of them may be executable, we
+	 * need to clean them to the PoU.
+	 */
+	while (restored_inplace_pblist != NULL) {
+		struct pbe *pbe = restored_inplace_pblist;
+
+		flush_icache_range((unsigned long)pbe->address,
+				   (unsigned long)pbe->address + PAGE_SIZE);
+		restored_inplace_pblist = pbe->next;
+	}
+
+	hibernate_exit(virt_to_phys(tmp_pg_dir), virt_to_phys(swapper_pg_dir),
+		       KERNEL_START, KERNEL_END);
+
+out:
+	return rc;
+}
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1ee2c3937d4e..87addff02009 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -45,6 +45,16 @@ jiffies = jiffies_64;
 	*(.idmap.text)					\
 	VMLINUX_SYMBOL(__idmap_text_end) = .;
 
+#ifdef CONFIG_HIBERNATION
+#define HIBERNATE_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	VMLINUX_SYMBOL(__hibernate_exit_text_start) = .;\
+	*(.hibernate_exit.text)				\
+	VMLINUX_SYMBOL(__hibernate_exit_text_end) = .;
+#else
+#define HIBERNATE_TEXT
+#endif
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -106,6 +116,7 @@ SECTIONS
 			LOCK_TEXT
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
+			HIBERNATE_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -185,6 +196,10 @@ ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"HYP init code too big or misaligned")
 ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
+#ifdef CONFIG_HIBERNATION
+ASSERT(__hibernate_exit_text_end - (__hibernate_exit_text_start & ~(SZ_4K - 1))
+	<= SZ_4K, "Hibernate exit text too big or misaligned")
+#endif
 
 /*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
-- 
2.6.2

