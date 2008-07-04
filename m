From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86 ACPI: Fix resume from suspend to RAM on
	uniprocessor x86-64
Date: Sat, 5 Jul 2008 00:05:30 +0200
Message-ID: <200807050005.31272.rjw__15824.7959254824$1215209334$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Ingo,

This is a regression fix, please push to Linus ASAP.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Since the trampoline code is now used for ACPI resume from suspend to RAM,
the trampoline page tables have to be fixed up during boot not only on SMP
systems, but also on UP systems that use the trampoline.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=10923

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/head_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/head_64.S
===================================================================
--- linux-2.6.orig/arch/x86/kernel/head_64.S
+++ linux-2.6/arch/x86/kernel/head_64.S
@@ -128,7 +128,7 @@ ident_complete:
 	/* Fixup phys_base */
 	addq	%rbp, phys_base(%rip)
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_X86_TRAMPOLINE
 	addq	%rbp, trampoline_level4_pgt + 0(%rip)
 	addq	%rbp, trampoline_level4_pgt + (511*8)(%rip)
 #endif
