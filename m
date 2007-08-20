From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/4] Hibernation: Arbitrary boot kernel
	support on x86_64
Date: Mon, 20 Aug 2007 15:11:33 +0200
Message-ID: <200708201511.34254.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708201510.03734.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: discuss@x86-64.org, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to restore a hibernation image on x86_64 with the help of a
kernel different from the one in the image.

The idea is to split the core restoration code into two separate parts and to
place each of them in a different page.  The first part belongs to the boot
kernel and is executed as the last step of the image kernel's memory restoration
procedure.  It restores all of the image kernel's memory that has not been
restored yet except for the one page containing the very code that is being
executed at that time.  The final operation performed by it is a jump to the
second part of the core restoration code that belongs to the image kernel and
has just been restored.  This code restores the last remaining page of the image
kernel's memory containing the first, already executed, part of the core
restoration code (temporary page tables created by the boot kernel are used at
this stage).  It also makes the CPU switch to the image kernel's page tables and
restores the state of general purpose registers (including the stack pointer)
from before the hibernation.

The main issue with this idea is that in order to jump to the second part of the
restoration code the boot kernel needs to know its address.  However, this
address may be passed to it in the image header.  Namely, the part of the image
header previously used for checking if the version of the image kernel is
correct can be replaced with an architecture specific data that will allow the
boot kernel to jump to the right address within the image kernel.  This data
should also be used for checking if the image kernel is compatible with the boot
kernel (as far as the memory restroration procedure is concerned).  It can be
done, for example, with the help of a "magic" value that has to be equal in both
kernels, so that they can be regarded as compatible.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86_64/kernel/suspend.c     |   43 +++++++++++++++++++++++++++
 arch/x86_64/kernel/suspend_asm.S |   61 +++++++++++++++++++++++++++++++++------
 include/asm-x86_64/suspend.h     |    6 +++
 kernel/power/power.h             |    6 ++-
 kernel/power/snapshot.c          |   60 ++++++++++++++++++++++++++++----------
 5 files changed, 150 insertions(+), 26 deletions(-)

Index: linux-2.6.23-rc3/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.23-rc3.orig/arch/x86_64/kernel/suspend_asm.S	2007-08-19 14:43:19.000000000 +0200
+++ linux-2.6.23-rc3/arch/x86_64/kernel/suspend_asm.S	2007-08-19 19:12:56.000000000 +0200
@@ -2,8 +2,8 @@
  *
  * Distribute under GPLv2.
  *
- * swsusp_arch_resume may not use any stack, nor any variable that is
- * not "NoSave" during copying pages:
+ * swsusp_arch_resume must not use any stack or any nonlocal variables while
+ * copying pages:
  *
  * Its rewriting one kernel image with another. What is stack in "old"
  * image could very well be data page in "new" image, and overwriting
@@ -36,10 +36,20 @@ ENTRY(swsusp_arch_suspend)
 	pushfq
 	popq	pt_regs_eflags(%rax)
 
+	/* save the address of restore_registers */
+	movq	$restore_registers, %rax
+	movq	%rax, restore_jump_address(%rip)
+
 	call swsusp_save
 	ret
 
 ENTRY(restore_image)
+	/* compute the address of the page we are at and store it in R9 */
+	movq	$(restore_image - __START_KERNEL_map), %rax
+	movq	$__PAGE_OFFSET, %r9
+	addq	%rax, %r9
+	andq	$PAGE_MASK, %r9
+
 	/* switch to temporary page tables */
 	movq	$__PAGE_OFFSET, %rdx
 	movq	temp_level4_pgt(%rip), %rax
@@ -54,6 +64,11 @@ ENTRY(restore_image)
 	movq	%rcx, %cr3;
 	movq	%rax, %cr4;  # turn PGE back on
 
+	/* prepare to jump to the image kernel */
+	movq	restore_jump_address(%rip), %rax
+
+	/* copy image data to their original locations */
+	xorq	%r10, %r10
 	movq	restore_pblist(%rip), %rdx
 loop:
 	testq	%rdx, %rdx
@@ -62,16 +77,44 @@ loop:
 	/* get addresses from the pbe and copy the page */
 	movq	pbe_address(%rdx), %rsi
 	movq	pbe_orig_address(%rdx), %rdi
-	movq	$512, %rcx
+	/* skip the page we are at (address stored in R9) */
+	cmpq	%rdi, %r9
+	jne	1f
+	movq	%rsi, %r10
+	jmp	2f
+1:	movq	$(PAGE_SIZE >> 3), %rcx
 	rep
 	movsq
 
 	/* progress to the next pbe */
-	movq	pbe_next(%rdx), %rdx
+2:	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* jump to the restore_registers address from the image header */
+	jmpq	*%rax
+	/*
+	 * NOTE: This assumes that the boot kernel's text mapping covers the
+	 * image kernel's page containing restore_registers and the address of
+	 * this page is the same as in the image kernel's text mapping (it
+	 * should always be true, because the text mapping is linear, starting
+	 * from 0, and is supposed to cover the entire kernel text for every
+	 * kernel).
+	 */
+
+.balign PAGE_SIZE
+ENTRY(restore_registers)
+	/* we are in the image kernel's text now */
+	testq	%r10, %r10
+	jz	1f
+	/* copy the skipped page */
+	movq	%r10, %rsi
+	movq	%r9, %rdi
+	movq	$(PAGE_SIZE >> 3), %rcx
+	rep
+	movsq
+
 	/* go back to the original page tables */
-	movq    $(init_level4_pgt - __START_KERNEL_map), %rax
+1:	movq    $(init_level4_pgt - __START_KERNEL_map), %rax
 	addq    phys_base(%rip), %rax
 	movq    %rax, %cr3
 
@@ -84,10 +127,7 @@ done:
 	movq	%rcx, %cr3
 	movq	%rax, %cr4;  # turn PGE back on
 
-	movl	$24, %eax
-	movl	%eax, %ds
-
-	/* We don't restore %rax, it must be 0 anyway */
+	/* restore GPRs (we don't restore %rax, it must be 0 anyway) */
 	movq	$saved_context, %rax
 	movq	pt_regs_rsp(%rax), %rsp
 	movq	pt_regs_rbp(%rax), %rbp
@@ -109,4 +149,7 @@ done:
 
 	xorq	%rax, %rax
 
+	/* tell the hibernation core that we've just restored the memory */
+	movq	%rax, in_suspend(%rip)
+
 	ret
Index: linux-2.6.23-rc3/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.23-rc3.orig/arch/x86_64/kernel/suspend.c	2007-08-19 14:43:19.000000000 +0200
+++ linux-2.6.23-rc3/arch/x86_64/kernel/suspend.c	2007-08-19 19:12:38.000000000 +0200
@@ -144,6 +144,12 @@ void fix_processor_context(void)
 /* Defined in arch/x86_64/kernel/suspend_asm.S */
 extern int restore_image(void);
 
+/*
+ * Address to jump to in the last phase of restore in order to get to the image
+ * kernel's text (this value is passed in the image header).
+ */
+unsigned long restore_jump_address;
+
 pgd_t *temp_level4_pgt;
 
 static int res_phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
@@ -230,4 +236,41 @@ int pfn_is_nosave(unsigned long pfn)
 	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
+
+struct restore_data_record {
+	unsigned long jump_address;
+	unsigned long control;
+};
+
+#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+
+/**
+ *	arch_hibernation_header_save - populate the architecture specific part
+ *		of a hibernation image header
+ *	@addr: address to save the data at
+ */
+int arch_hibernation_header_save(void *addr, unsigned int max_size)
+{
+	struct restore_data_record *rdr = addr;
+
+	if (max_size < sizeof(struct restore_data_record))
+		return -EOVERFLOW;
+	rdr->jump_address = restore_jump_address;
+	rdr->control = (restore_jump_address ^ RESTORE_MAGIC);
+	return 0;
+}
+
+/**
+ *	arch_hibernation_header_restore - read the architecture specific data
+ *		from the hibernation image header
+ *	@addr: address to read the data from
+ */
+int arch_hibernation_header_restore(void *addr)
+{
+	struct restore_data_record *rdr = addr;
+
+	restore_jump_address = rdr->jump_address;
+	return (rdr->control == (restore_jump_address ^ RESTORE_MAGIC)) ?
+			0 : -EINVAL;
+}
 #endif /* CONFIG_HIBERNATION */
Index: linux-2.6.23-rc3/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.23-rc3.orig/include/asm-x86_64/suspend.h	2007-08-19 14:43:19.000000000 +0200
+++ linux-2.6.23-rc3/include/asm-x86_64/suspend.h	2007-08-19 15:09:50.000000000 +0200
@@ -43,4 +43,10 @@ extern void fix_processor_context(void);
 /* routines for saving/restoring kernel state */
 extern int acpi_save_state_mem(void);
 
+#define ARCH_HAS_HIBERNATION_HEADER
+
+/* arch/x86_64/kernel/suspend.c */
+extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
+extern int arch_hibernation_header_restore(void *addr);
+
 #endif /* __ASM_X86_64_SUSPEND_H */
Index: linux-2.6.23-rc3/kernel/power/power.h
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/power.h	2007-08-19 14:42:41.000000000 +0200
+++ linux-2.6.23-rc3/kernel/power/power.h	2007-08-19 14:44:12.000000000 +0200
@@ -11,14 +11,16 @@ struct swsusp_info {
 	unsigned long		size;
 } __attribute__((aligned(PAGE_SIZE)));
 
-
-
 #ifdef CONFIG_HIBERNATION
+/* Maximum size of architecture specific data in a hibernation header */
+#define MAX_ARCH_HEADER_SIZE	(sizeof(struct new_utsname) + 4)
+
 /*
  * Keep some memory free so that I/O operations can succeed without paging
  * [Might this be more than 4 MB?]
  */
 #define PAGES_FOR_IO	((4096 * 1024) >> PAGE_SHIFT)
+
 /*
  * Keep 1 MB of memory free so that device drivers can allocate some pages in
  * their .suspend() routines without breaking the suspend to disk.
Index: linux-2.6.23-rc3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/snapshot.c	2007-08-19 14:42:41.000000000 +0200
+++ linux-2.6.23-rc3/kernel/power/snapshot.c	2007-08-19 14:44:12.000000000 +0200
@@ -1239,17 +1239,29 @@ asmlinkage int swsusp_save(void)
 	return 0;
 }
 
-static void init_header(struct swsusp_info *info)
+#ifdef ARCH_HAS_HIBERNATION_HEADER
+static int init_header_complete(struct swsusp_info *info)
 {
-	memset(info, 0, sizeof(struct swsusp_info));
+	return arch_hibernation_header_save(info, MAX_ARCH_HEADER_SIZE);
+}
+#else /* !ARCH_HAS_HIBERNATION_HEADER */
+static int init_header_complete(struct swsusp_info *info)
+{
+	memcpy(&info->uts, init_utsname(), sizeof(struct new_utsname));
 	info->version_code = LINUX_VERSION_CODE;
+	return 0;
+}
+#endif /* !ARCH_HAS_HIBERNATION_HEADER */
+
+static int init_header(struct swsusp_info *info)
+{
+	memset(info, 0, sizeof(struct swsusp_info));
 	info->num_physpages = num_physpages;
-	memcpy(&info->uts, init_utsname(), sizeof(struct new_utsname));
-	info->cpus = num_online_cpus();
 	info->image_pages = nr_copy_pages;
 	info->pages = nr_copy_pages + nr_meta_pages + 1;
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
+	return init_header_complete(info);
 }
 
 /**
@@ -1303,7 +1315,11 @@ int snapshot_read_next(struct snapshot_h
 			return -ENOMEM;
 	}
 	if (!handle->offset) {
-		init_header((struct swsusp_info *)buffer);
+		int error;
+
+		error = init_header((struct swsusp_info *)buffer);
+		if (error)
+			return error;
 		handle->buffer = buffer;
 		memory_bm_position_reset(&orig_bm);
 		memory_bm_position_reset(&copy_bm);
@@ -1394,22 +1410,36 @@ duplicate_memory_bitmap(struct memory_bi
 	}
 }
 
-static inline int check_header(struct swsusp_info *info)
+#ifdef ARCH_HAS_HIBERNATION_HEADER
+static char *check_image_kernel(struct swsusp_info *info)
+{
+	return arch_hibernation_header_restore(info) ?
+			"architecture specific data" : NULL;
+}
+#else /* !ARCH_HAS_HIBERNATION_HEADER */
+static char *check_image_kernel(struct swsusp_info *info)
 {
-	char *reason = NULL;
-
 	if (info->version_code != LINUX_VERSION_CODE)
-		reason = "kernel version";
-	if (info->num_physpages != num_physpages)
-		reason = "memory size";
+		return "kernel version";
 	if (strcmp(info->uts.sysname,init_utsname()->sysname))
-		reason = "system type";
+		return "system type";
 	if (strcmp(info->uts.release,init_utsname()->release))
-		reason = "kernel release";
+		return "kernel release";
 	if (strcmp(info->uts.version,init_utsname()->version))
-		reason = "version";
+		return "version";
 	if (strcmp(info->uts.machine,init_utsname()->machine))
-		reason = "machine";
+		return "machine";
+	return NULL;
+}
+#endif /* !ARCH_HAS_HIBERNATION_HEADER */
+
+static int check_header(struct swsusp_info *info)
+{
+	char *reason;
+
+	reason = check_image_kernel(info);
+	if (!reason && info->num_physpages != num_physpages)
+		reason = "memory size";
 	if (reason) {
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
 		return -EPERM;
