From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 03/12][RFC v3] x86-32/asm/power: Create stack frames in hibernate_asm_32.S
Date: Wed, 19 Sep 2018 15:38:25 +0800
Message-ID: <19aed6bb376b47f672800b4c59da07efca0f9e5a.1537275915.git.yu.c.chen@intel.com>
References: <cover.1537275915.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537275915.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Yu Chen <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Backport
Commit ef0f3ed5a4ac (x86/asm/power: Create stack frames
in hibernate_asm_64.S)
and
Commit 4ce827b4cc58 (x86/power/64: Fix hibernation return
address corruption)

And also prepare for relocated code and jump address
mapping.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/suspend_32.h | 4 ++++
 arch/x86/power/hibernate_asm_32.S | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 8be6afb58471..fdbd9d7b7bca 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -32,4 +32,8 @@ struct saved_context {
 	unsigned long return_address;
 } __attribute__((packed));
 
+/* routines for saving/restoring kernel state */
+extern char core_restore_code[];
+extern char restore_registers[];
+
 #endif /* _ASM_X86_SUSPEND_32_H */
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6e56815e13a0..671d38d0d931 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -12,6 +12,7 @@
 #include <asm/page_types.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/frame.h>
 
 .text
 
@@ -24,8 +25,11 @@ ENTRY(swsusp_arch_suspend)
 	pushfl
 	popl saved_context_eflags
 
+	FRAME_BEGIN
 	call swsusp_save
+	FRAME_END
 	ret
+ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
 	movl	mmu_cr4_features, %ecx
@@ -58,6 +62,10 @@ copy_loop:
 	.p2align 4,,7
 
 done:
+
+	/* code below belongs to the image kernel */
+	.align PAGE_SIZE
+ENTRY(restore_registers)
 	/* go back to the original page tables */
 	movl	$swapper_pg_dir, %eax
 	subl	$__PAGE_OFFSET, %eax
@@ -83,3 +91,4 @@ done:
 	xorl	%eax, %eax
 
 	ret
+ENDPROC(restore_registers)
-- 
2.17.1
