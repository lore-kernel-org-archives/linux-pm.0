From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 09/12][RFC v3] x86-32, hibernate: Switch to original page table after resumed
Date: Wed, 19 Sep 2018 15:43:05 +0800
Message-ID: <f5dda0f48029c576d754559cfc60c2fef443c5e4.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

After all the pages are restored to previous address, the page
table switches back to current swapper_pg_dir. However the
swapper_pg_dir currently in used might not be consistent with
previous page table, which might cause issue after resumed.

Fix this issue by switching to original page table after resumed.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_asm_32.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

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
