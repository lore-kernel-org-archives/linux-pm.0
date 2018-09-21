From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 09/12][v4] x86-32, hibernate: Switch to original page table after resumed
Date: Fri, 21 Sep 2018 14:28:11 +0800
Message-ID: <55f1f33f0fe7963bd63eda4e05b19b68ec4a8d3f.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

After all the pages are restored to previous address, the page
table switches back to current swapper_pg_dir. However the
swapper_pg_dir currently in used might not be consistent with
previous page table, which might cause issue after resume.

Fix this issue by switching to original page table after resume,
and the address of the original page table is saved in the hibernation
image header.

Move the manipulation of restore_cr3 into common code blocks.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate.c        |  4 ++--
 arch/x86/power/hibernate_asm_32.S | 10 +++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index e3409e4a9b6a..4935b8139229 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -160,6 +160,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 #ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
+#endif
 
 	/*
 	 * The restore code fixes up CR3 and CR4 in the following sequence:
@@ -179,7 +180,6 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	 * have any of the PCID bits set.
 	 */
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
-#endif
 
 	return hibernation_e820_save(rdr->e820_digest);
 }
@@ -201,8 +201,8 @@ int arch_hibernation_header_restore(void *addr)
 #ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
-	restore_cr3 = rdr->cr3;
 #endif
+	restore_cr3 = rdr->cr3;
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
 		pr_crit("Hibernate inconsistent memory map detected!\n");
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index f5103ae96582..6b2b94937113 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -25,6 +25,10 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	/* save cr3 */
+	movl	%cr3, %eax
+	movl	%eax, restore_cr3
+
 	FRAME_BEGIN
 	call swsusp_save
 	FRAME_END
@@ -32,6 +36,8 @@ ENTRY(swsusp_arch_suspend)
 ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
+	movl	restore_cr3, %ebp
+
 	movl	mmu_cr4_features, %ecx
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
@@ -66,9 +72,7 @@ done:
 	.align PAGE_SIZE
 ENTRY(restore_registers)
 	/* go back to the original page tables */
-	movl	$swapper_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
-	movl	%eax, %cr3
+	movl	%ebp, %cr3
 	movl	mmu_cr4_features, %ecx
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
 	movl	%ecx, %cr4;  # turn PGE back on
-- 
2.17.1
