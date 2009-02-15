From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] x86_64: Fix S3 fail path
Date: Sun, 15 Feb 2009 22:46:45 +0100
Message-ID: <200902152246.46583.rjw__7667.28258827261$1234734770$gmane$org@sisk.pl>
References: <200902152244.47326.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902152244.47326.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Cyrill Gorcunov <gorcunov@openvz.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Jiri Slaby <jirislaby@gmail.com>

As acpi_enter_sleep_state can fail, take this into account in
do_suspend_lowlevel and don't return to the do_suspend_lowlevel's
caller. This would break (currently) fpu status and preempt count.

Technically, this means use `call' instead of `jmp' and `jmp' to
the `resume_point' after the `call' (i.e. if
acpi_enter_sleep_state returns=fails). `resume_point' will handle
the restore of fpu and preempt count gracefully.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/acpi/wakeup_64.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/acpi/wakeup_64.S
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/wakeup_64.S
+++ linux-2.6/arch/x86/kernel/acpi/wakeup_64.S
@@ -73,7 +73,9 @@ ENTRY(do_suspend_lowlevel)
 	addq	$8, %rsp
 	movl	$3, %edi
 	xorl	%eax, %eax
-	jmp	acpi_enter_sleep_state
+	call	acpi_enter_sleep_state
+	/* in case something went wrong, restore the machine status and go on */
+	jmp	resume_point
 
 	.align 4
 resume_point:
