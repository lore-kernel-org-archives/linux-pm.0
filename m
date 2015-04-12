From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/power/hibernate: Use local labels in asm
Date: Sun, 12 Apr 2015 21:45:06 +0200
Message-ID: <1428867906-12016-1-git-send-email-bp@alien8.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39652 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862AbbDLTrY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 12 Apr 2015 15:47:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... so that they don't appear in the object file and thus in objdump
output. They're local anyway and have a meaning only within that file.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-pm@vger.kernel.org
---
 arch/x86/power/hibernate_asm_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 3c4469a7a929..e2386cb4e0c3 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -78,9 +78,9 @@ ENTRY(restore_image)
 
 	/* code below has been relocated to a safe page */
 ENTRY(core_restore_code)
-loop:
+.Lloop:
 	testq	%rdx, %rdx
-	jz	done
+	jz	.Ldone
 
 	/* get addresses from the pbe and copy the page */
 	movq	pbe_address(%rdx), %rsi
@@ -91,8 +91,8 @@ loop:
 
 	/* progress to the next pbe */
 	movq	pbe_next(%rdx), %rdx
-	jmp	loop
-done:
+	jmp	.Lloop
+.Ldone:
 	/* jump to the restore_registers address from the image header */
 	jmpq	*%rax
 	/*
-- 
2.3.5

