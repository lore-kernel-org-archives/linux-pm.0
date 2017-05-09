From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/power/64: Use char arrays for asm function names
Date: Tue, 9 May 2017 14:00:51 -0700
Message-ID: <20170509210051.GA36504@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36023 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdEIVAy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2017 17:00:54 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so5633628pfg.3
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2017 14:00:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>

This switches the hibernate_64.S function names into character arrays
to match other areas of the kernel where this is done (e.g., linker
scripts). Specifically this fixes a compile-time error noticed by the
future CONFIG_FORTIFY_SOURCE routines that complained about PAGE_SIZE
being copied out of the "single byte" core_restore_code variable.

Additionally drops the "acpi_save_state_mem" exern which does not
appear to be used anywhere else in the kernel.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/suspend_64.h | 5 ++---
 arch/x86/power/hibernate_64.c     | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 6136a18152af..2bd96b4df140 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -42,8 +42,7 @@ struct saved_context {
 	set_debugreg((thread)->debugreg##register, register)
 
 /* routines for saving/restoring kernel state */
-extern int acpi_save_state_mem(void);
-extern char core_restore_code;
-extern char restore_registers;
+extern char core_restore_code[];
+extern char restore_registers[];
 
 #endif /* _ASM_X86_SUSPEND_64_H */
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 6a61194ffd58..2cc419990ab7 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -147,7 +147,7 @@ static int relocate_restore_code(void)
 	if (!relocated_restore_code)
 		return -ENOMEM;
 
-	memcpy((void *)relocated_restore_code, &core_restore_code, PAGE_SIZE);
+	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
 
 	/* Make the page containing the relocated code executable */
 	pgd = (pgd_t *)__va(read_cr3()) + pgd_index(relocated_restore_code);
@@ -292,8 +292,8 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
-	rdr->jump_address = (unsigned long)&restore_registers;
-	rdr->jump_address_phys = __pa_symbol(&restore_registers);
+	rdr->jump_address = (unsigned long)restore_registers;
+	rdr->jump_address_phys = __pa_symbol(restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
