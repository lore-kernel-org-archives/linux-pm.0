From: Pavel Machek <pavel@ucw.cz>
Subject: x86: allow using different kernel version for 32-bit, too
Date: Wed, 17 Jun 2015 10:59:37 +0200
Message-ID: <20150617085937.GA15109@amd>
References: <20150612075013.GA8759@gmail.com>
 <20150614074922.GA30290@gmail.com>
 <20150616091333.GA6448@amd>
 <49474860.PXIRr69qmi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57280 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbbFQI7k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jun 2015 04:59:40 -0400
Content-Disposition: inline
In-Reply-To: <49474860.PXIRr69qmi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>, jbohac@suse.cz, vojtech@suse.cz

Rafael, would something like this be acceptable?

I think I'd like to unify hibernate_32/64.c into hibernate.c with
ifdefs as a next step.

Best regards,
								Pavel

commit e4d6e488069b1452fdaab06ecc812969d76ef777
Author: Pavel <pavel@ucw.cz>
Date:   Wed Jun 17 10:35:01 2015 +0200

    Port d158cbdf39ffaec9dd5299fdfdfdd2c7897a71dc to i386.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

(Thanks go to czech SUSE, Vojtech Pavlik and Jiri Bohac for this one,
altough they probably have no chance to understand why.)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8c47337..808c262 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2074,7 +2074,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 552d6c9..d5711c3 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -24,4 +24,7 @@ struct saved_context {
 	unsigned long return_address;
 } __attribute__((packed));
 
+extern char core_restore_code;
+extern char restore_registers;
+
 #endif /* _ASM_X86_SUSPEND_32_H */
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
new file mode 100644
index 0000000..c5f2fce
--- /dev/null
+++ b/arch/x86/power/hibernate.c
@@ -0,0 +1,46 @@
+int reallocate_restore_code(void)
+{
+	relocated_restore_code = (void *)get_safe_page(GFP_ATOMIC);
+	if (!relocated_restore_code)
+		return -ENOMEM;
+	memcpy(relocated_restore_code, &core_restore_code,
+	       &restore_registers - &core_restore_code);
+	return 0;
+}
+
+struct restore_data_record {
+	unsigned long jump_address;
+	unsigned long cr3;
+	unsigned long magic;
+};
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
+	rdr->cr3 = restore_cr3;
+	rdr->magic = RESTORE_MAGIC;
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
+	restore_cr3 = rdr->cr3;
+	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
+}
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index 291226b..29c8cdf 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -4,6 +4,7 @@
  * Distribute under GPLv2
  *
  * Copyright (c) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ * Copyright (c) 2015 Pavel Machek <pavel@ucw.cz>
  */
 
 #include <linux/gfp.h>
@@ -14,13 +15,28 @@
 #include <asm/pgtable.h>
 #include <asm/mmzone.h>
 #include <asm/sections.h>
+#include <asm/suspend.h>
 
 /* Defined in hibernate_asm_32.S */
 extern int restore_image(void);
 
+/*
+ * Address to jump to in the last phase of restore in order to get to the image
+ * kernel's text (this value is passed in the image header).
+ */
+unsigned long restore_jump_address __visible;
+
+/*
+ * Value of the cr3 register from before the hibernation (this value is passed
+ * in the image header).
+ */
+unsigned long restore_cr3 __visible;
+
 /* Pointer to the temporary resume page tables */
 pgd_t *resume_pg_dir;
 
+void *relocated_restore_code __visible;
+
 /* The following three functions are based on the analogous code in
  * arch/x86/mm/init_32.c
  */
@@ -142,6 +158,9 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
+#define RESTORE_MAGIC	0x2468aceUL
+#include "hibernate.c"
+
 int swsusp_arch_resume(void)
 {
 	int error;
@@ -155,6 +174,10 @@ int swsusp_arch_resume(void)
 	if (error)
 		return error;
 
+	error = reallocate_restore_code();
+	if (error)
+		return error;
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 009947d..527a902 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -78,6 +78,9 @@ static int set_up_temporary_mappings(void)
 	return 0;
 }
 
+#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+#include "hibernate.c"
+
 int swsusp_arch_resume(void)
 {
 	int error;
@@ -86,11 +89,9 @@ int swsusp_arch_resume(void)
 	if ((error = set_up_temporary_mappings()))
 		return error;
 
-	relocated_restore_code = (void *)get_safe_page(GFP_ATOMIC);
-	if (!relocated_restore_code)
-		return -ENOMEM;
-	memcpy(relocated_restore_code, &core_restore_code,
-	       &restore_registers - &core_restore_code);
+	error = reallocate_restore_code();
+	if (error)
+		return error;
 
 	restore_image();
 	return 0;
@@ -107,41 +108,4 @@ int pfn_is_nosave(unsigned long pfn)
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
 
-struct restore_data_record {
-	unsigned long jump_address;
-	unsigned long cr3;
-	unsigned long magic;
-};
-
-#define RESTORE_MAGIC	0x0123456789ABCDEFUL
-
-/**
- *	arch_hibernation_header_save - populate the architecture specific part
- *		of a hibernation image header
- *	@addr: address to save the data at
- */
-int arch_hibernation_header_save(void *addr, unsigned int max_size)
-{
-	struct restore_data_record *rdr = addr;
-
-	if (max_size < sizeof(struct restore_data_record))
-		return -EOVERFLOW;
-	rdr->jump_address = restore_jump_address;
-	rdr->cr3 = restore_cr3;
-	rdr->magic = RESTORE_MAGIC;
-	return 0;
-}
-
-/**
- *	arch_hibernation_header_restore - read the architecture specific data
- *		from the hibernation image header
- *	@addr: address to read the data from
- */
-int arch_hibernation_header_restore(void *addr)
-{
-	struct restore_data_record *rdr = addr;
 
-	restore_jump_address = rdr->jump_address;
-	restore_cr3 = rdr->cr3;
-	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
-}
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 1d0fa0e..db5f22a 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -1,5 +1,14 @@
 /*
- * This may not use any stack, nor any variable that is not "NoSave":
+ * Hibernation support for i386
+ *
+ * Distribute under GPLv2.
+ *
+ * Copyright 2007 Rafael J. Wysocki <rjw@sisk.pl>
+ * Copyright 2005 Andi Kleen <ak@suse.de>
+ * Copyright 2004, 2015 Pavel Machek <pavel@ucw.cz>
+ *
+ * swsusp_arch_resume must not use any stack or any nonlocal variables while
+ * copying pages:
  *
  * Its rewriting one kernel image with another. What is stack in "old"
  * image could very well be data page in "new" image, and overwriting
@@ -23,6 +32,13 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	/* save the address of restore_registers */
+	movl	$restore_registers, %eax
+	movl	%eax, restore_jump_address
+	/* save cr3 */
+	movl	%cr3, %eax
+	movl	%eax, restore_cr3
+
 	call swsusp_save
 	ret
 
@@ -38,9 +54,18 @@ ENTRY(restore_image)
 	movl	%cr3, %eax;  # flush TLB
 	movl	%eax, %cr3
 1:
+
+	/* prepare to jump to the image kernel */
+	movl	restore_jump_address, %eax
+	movl	restore_cr3, %ebx
+
+	/* prepare to copy image data to their original locations */
 	movl	restore_pblist, %edx
+	movl	relocated_restore_code, %ecx
+	jmpl	*%ecx
 	.p2align 4,,7
 
+ENTRY(core_restore_code)
 copy_loop:
 	testl	%edx, %edx
 	jz	done
@@ -48,7 +73,7 @@ copy_loop:
 	movl	pbe_address(%edx), %esi
 	movl	pbe_orig_address(%edx), %edi
 
-	movl	$1024, %ecx
+	movl	$(PAGE_SIZE >> 2), %ecx
 	rep
 	movsl
 
@@ -57,6 +82,20 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+	/* jump to the restore_registers address from the image header */
+	jmpl	*%eax
+	/*
+	 * NOTE: This assumes that the boot kernel's text mapping covers the
+	 * image kernel's page containing restore_registers and the address of
+	 * this page is the same as in the image kernel's text mapping (it
+	 * should always be true, because the text mapping is linear, starting
+	 * from 0, and is supposed to cover the entire kernel text for every
+	 * kernel).
+	 *
+	 * code below belongs to the image kernel
+	 */
+
+ENTRY(restore_registers)
 	/* go back to the original page tables */
 	movl	$swapper_pg_dir, %eax
 	subl	$__PAGE_OFFSET, %eax
@@ -81,4 +120,7 @@ done:
 
 	xorl	%eax, %eax
 
+	/* tell the hibernation core that we've just restored the memory */
+	movl	%eax, in_suspend
+
 	ret


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
