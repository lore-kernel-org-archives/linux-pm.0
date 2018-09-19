From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 11/12][RFC v3] x86-32, hibernate: Set up temporary text mapping for 32bit system
Date: Wed, 19 Sep 2018 15:43:22 +0800
Message-ID: <5d152d6237274f166c60fc7dee7c6fea883ef922.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Set up the temporary text mapping for the final jump address
so that the system could jump to the right address after all
the pages have been copied back to their original address.

Back-port from 64bit system.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 31 +++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_asm_32.S |  3 +++
 2 files changed, 34 insertions(+)

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
