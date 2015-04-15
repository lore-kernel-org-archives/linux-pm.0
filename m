From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Subject: [tip:x86/asm] x86/asm, x86/acpi/wakeup_64.S:
  Make global label a local one
Date: Wed, 15 Apr 2015 08:46:22 -0700
Message-ID: <tip-c0f6feba784e1087b905ad097d2d9ac0aaf744a5@git.kernel.org>
References: <1429080614-22610-1-git-send-email-bp@alien8.de>
Reply-To: bp@suse.de, luto@amacapital.net, linux-pm@vger.kernel.org,
	  pavel@ucw.cz, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
	  bp@alien8.de, tglx@linutronix.de, torvalds@linux-foundation.org,
	  brgerst@gmail.com, hpa@zytor.com, len.brown@intel.com,
	  mingo@kernel.org, rjw@rjwysocki.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429080614-22610-1-git-send-email-bp@alien8.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, mingo@kernel.org, len.brown@intel.com, rjw@rjwysocki.net, tglx@linutronix.de, torvalds@linux-foundation.org, bp@alien8.de, brgerst@gmail.com, dvlasenk@redhat.com, linux-kernel@vger.kernel.org, bp@suse.de, pavel@ucw.cz, luto@amacapital.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit-ID:  c0f6feba784e1087b905ad097d2d9ac0aaf744a5
Gitweb:     http://git.kernel.org/tip/c0f6feba784e1087b905ad097d2d9ac0aaf744a5
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 15 Apr 2015 08:50:14 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 15 Apr 2015 11:38:01 +0200

x86/asm, x86/acpi/wakeup_64.S: Make global label a local one

Make it a local symbol so that it doesn't appear in objdump
output.

No functionality change - code remains the same, just the global
label disappears:

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
Cc: <linux-pm@vger.kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1429080614-22610-1-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index ae693b5..8c35df4 100644
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
