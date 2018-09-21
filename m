From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 07/12][v4] x86-32, hibernate: Use temp_pgt as the temporary page table
Date: Fri, 21 Sep 2018 14:27:51 +0800
Message-ID: <ca2e027db5bd990ffebed9086db3dac335afdf64.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

This is to reuse the temp_pgt for both 32bit and 64bit
system.

No functional change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_32.c     | 2 ++
 arch/x86/power/hibernate_asm_32.S | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index f82fbd279d08..a44bdada4e4e 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -156,6 +156,8 @@ asmlinkage int swsusp_arch_resume(void)
 	if (error)
 		return error;
 
+	temp_pgt = __pa(resume_pg_dir);
+
 	/* We have got enough memory and from now on we cannot recover */
 	restore_image();
 	return 0;
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 671d38d0d931..f0627cf30a36 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -33,8 +33,7 @@ ENDPROC(swsusp_arch_suspend)
 
 ENTRY(restore_image)
 	movl	mmu_cr4_features, %ecx
-	movl	resume_pg_dir, %eax
-	subl	$__PAGE_OFFSET, %eax
+	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
 	jecxz	1f	# cr4 Pentium and higher, skip if zero
-- 
2.17.1
