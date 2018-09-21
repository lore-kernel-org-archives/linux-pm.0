From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 11/12][v4] x86-32, hibernate: Set up temporary text mapping for 32bit system
Date: Fri, 21 Sep 2018 14:28:32 +0800
Message-ID: <05908fe04f02898ba36def9b3cf1cd72fb4750a6.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Set up the temporary text mapping for the final jump address
so that the system could jump to the right address after all
the pages have been copied back to their original address -
otherwise the final mapping for the jump address is invalid.

Analogous changes were made for 64-bit in:
Commit 65c0554b73c9 ('x86/power/64: Fix kernel text mapping
corruption during image restoration')

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate.c        |  4 ----
 arch/x86/power/hibernate_32.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_asm_32.S |  3 +++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 7383cb67ffd7..bcddf09b5aa3 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -157,10 +157,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
 	rdr->magic = RESTORE_MAGIC;
-#ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
-#endif
 
 	/*
 	 * The restore code fixes up CR3 and CR4 in the following sequence:
@@ -198,10 +196,8 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
-#endif
 	restore_cr3 = rdr->cr3;
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index a9861095fbb8..15695e30f982 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -143,6 +143,32 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
+static int set_up_temporary_text_mapping(pgd_t *pgd_base)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_base + pgd_index(restore_jump_address);
+
+	pmd = resume_one_md_table_init(pgd);
+	if (!pmd)
+		return -ENOMEM;
+
+	if (boot_cpu_has(X86_FEATURE_PSE)) {
+		set_pmd(pmd + pmd_index(restore_jump_address),
+		__pmd((jump_address_phys & PMD_MASK) | pgprot_val(PAGE_KERNEL_LARGE_EXEC)));
+	} else {
+		pte = resume_one_page_table_init(pmd);
+		if (!pte)
+			return -ENOMEM;
+		set_pte(pte + pte_index(restore_jump_address),
+		__pte((jump_address_phys & PAGE_MASK) | pgprot_val(PAGE_KERNEL_EXEC)));
+	}
+
+	return 0;
+}
+
 asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
@@ -152,6 +178,11 @@ asmlinkage int swsusp_arch_resume(void)
 		return -ENOMEM;
 
 	resume_init_first_level_page_table(resume_pg_dir);
+
+	error = set_up_temporary_text_mapping(resume_pg_dir);
+	if (error)
+		return error;
+
 	error = resume_physical_mapping_init(resume_pg_dir);
 	if (error)
 		return error;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index e9adda6b6b02..01f653fae7bd 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -36,6 +36,8 @@ ENTRY(swsusp_arch_suspend)
 ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
+	/* prepare to jump to the image kernel */
+	movl	restore_jump_address, %ebx
 	movl	restore_cr3, %ebp
 
 	movl	mmu_cr4_features, %ecx
@@ -74,6 +76,7 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+	jmpl	*%ebx
 
 	/* code below belongs to the image kernel */
 	.align PAGE_SIZE
-- 
2.17.1
