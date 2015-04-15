From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] acpi/wakeup_64.S: Make global label a local one
Date: Wed, 15 Apr 2015 08:50:14 +0200
Message-ID: <1429080614-22610-1-git-send-email-bp@alien8.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:34203 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbbDOGwf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Apr 2015 02:52:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Make it a local symbol so that it doesn't appear in objdump output.

No functionality change - code remains the same, just the global label
disappears:

--- before	2015-04-15 08:44:43.088036283 +0200
+++ after	2015-04-15 08:40:38.292028826 +0200
@@ -36,9 +36,7 @@ ffffffff81039dba:       48 83 c4 08
 ffffffff81039dbe:       bf 03 00 00 00          mov    $0x3,%edi
 ffffffff81039dc3:       31 c0                   xor    %eax,%eax
 ffffffff81039dc5:       e8 b6 fd ff ff          callq  ffffffff81039b80 <x86_acpi_enter_sleep_state>
-ffffffff81039dca:       eb 00                   jmp    ffffffff81039dcc <resume_point>
-
-ffffffff81039dcc <resume_point>:
+ffffffff81039dca:       eb 00                   jmp    ffffffff81039dcc <do_suspend_lowlevel+0x9c>
 ffffffff81039dcc:       48 c7 c0 80 1a ca 82    mov    $0xffffffff82ca1a80,%rax
 ffffffff81039dd3:       48 8b 98 e2 00 00 00    mov    0xe2(%rax),%rbx
 ffffffff81039dda:       0f 22 e3                mov    %rbx,%cr4

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: <x86@kernel.org>
Cc: <linux-pm@vger.kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index ae693b51ed8e..8c35df468104 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -62,7 +62,7 @@ ENTRY(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$resume_point, saved_rip(%rip)
+	movq	$.Lresume_point, saved_rip(%rip)
 
 	movq	%rsp, saved_rsp
 	movq	%rbp, saved_rbp
@@ -75,10 +75,10 @@ ENTRY(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	x86_acpi_enter_sleep_state
 	/* in case something went wrong, restore the machine status and go on */
-	jmp	resume_point
+	jmp	.Lresume_point
 
 	.align 4
-resume_point:
+.Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
 	movq	$saved_context, %rax
 	movq	saved_context_cr4(%rax), %rbx
-- 
2.3.5

