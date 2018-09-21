From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 06/12][v4] x86, hibernate: Rename temp_level4_pgt to temp_pgt
Date: Fri, 21 Sep 2018 14:27:40 +0800
Message-ID: <490c2c562f8e6ed1864d9daf3fcf21ab8ca92538.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

As 32bit system is not using 4-level page, rename it
to temp_pgt so that it can be reused for both 32bit
and 64bit hibernation.

No functional change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/suspend.h    | 2 +-
 arch/x86/power/hibernate.c        | 2 +-
 arch/x86/power/hibernate_64.c     | 2 +-
 arch/x86/power/hibernate_asm_64.S | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
index 40b02558749f..a892494ca5e4 100644
--- a/arch/x86/include/asm/suspend.h
+++ b/arch/x86/include/asm/suspend.h
@@ -7,7 +7,7 @@
 extern unsigned long restore_jump_address __visible;
 extern unsigned long jump_address_phys;
 extern unsigned long restore_cr3 __visible;
-extern unsigned long temp_level4_pgt __visible;
+extern unsigned long temp_pgt __visible;
 extern unsigned long relocated_restore_code __visible;
 extern int relocate_restore_code(void);
 /* Defined in hibernate_asm_32/64.S */
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a04ca13bf592..e3409e4a9b6a 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -36,7 +36,7 @@ unsigned long jump_address_phys;
  * in the image header).
  */
 unsigned long restore_cr3 __visible;
-unsigned long temp_level4_pgt __visible;
+unsigned long temp_pgt __visible;
 unsigned long relocated_restore_code __visible;
 
 /**
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 8bc2eb0dc464..239f424ccb29 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -121,7 +121,7 @@ static int set_up_temporary_mappings(void)
 			return result;
 	}
 
-	temp_level4_pgt = __pa(pgd);
+	temp_pgt = __pa(pgd);
 	return 0;
 }
 
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index fd369a6e9ff8..3008baa2fa95 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -59,7 +59,7 @@ ENTRY(restore_image)
 	movq	restore_cr3(%rip), %r9
 
 	/* prepare to switch to temporary page tables */
-	movq	temp_level4_pgt(%rip), %rax
+	movq	temp_pgt(%rip), %rax
 	movq	mmu_cr4_features(%rip), %rbx
 
 	/* prepare to copy image data to their original locations */
-- 
2.17.1
