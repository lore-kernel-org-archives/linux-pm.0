From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Hibernation: Document __save_processor_state()
	on x86-64 (rev. 2)
Date: Sun, 30 Dec 2007 23:13:51 +0100
Message-ID: <200712302313.52483.rjw__34433.8317904205$1199051793$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Document the fact that __save_processor_state() has to save all CPU
registers referred to by the kernel in case a different kernel is
used to load and restore a hibernation image containing it. 

Sigend-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/suspend_64.c |   20 ++++++++++++++++++++
 include/asm-x86/suspend_64.h |    9 ++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/x86/kernel/suspend_64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/suspend_64.c
+++ linux-2.6/arch/x86/kernel/suspend_64.c
@@ -19,6 +19,21 @@ extern const void __nosave_begin, __nosa
 
 struct saved_context saved_context;
 
+/**
+ *	__save_processor_state - save CPU registers before creating a
+ *		hibernation image and before restoring the memory state from it
+ *	@ctxt - structure to store the registers contents in
+ *
+ *	NOTE: If there is a CPU register the modification of which by the
+ *	boot kernel (ie. the kernel used for loading the hibernation image)
+ *	might affect the operations of the restored target kernel (ie. the one
+ *	saved in the hibernation image), then its contents must be saved by this
+ *	function.  In other words, if kernel A is hibernated and different
+ *	kernel B is used for loading the hibernation image into memory, the
+ *	kernel A's __save_processor_state() function must save all registers
+ *	needed by kernel A, so that it can operate correctly after the resume
+ *	regardless of what kernel B does in the meantime.
+ */
 void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
@@ -69,6 +84,11 @@ static void do_fpu_end(void)
 	kernel_fpu_end();
 }
 
+/**
+ *	__restore_processor_state - restore the contents of CPU registers saved
+ *		by __save_processor_state()
+ *	@ctxt - structure to load the registers contents from
+ */
 void __restore_processor_state(struct saved_context *ctxt)
 {
 	/*
Index: linux-2.6/include/asm-x86/suspend_64.h
===================================================================
--- linux-2.6.orig/include/asm-x86/suspend_64.h
+++ linux-2.6/include/asm-x86/suspend_64.h
@@ -15,7 +15,14 @@ arch_prepare_suspend(void)
 	return 0;
 }
 
-/* Image of the saved processor state. If you touch this, fix acpi/wakeup.S. */
+/*
+ * Image of the saved processor state, used by the low level ACPI suspend to
+ * RAM code and by the low level hibernation code.
+ *
+ * If you modify it, fix arch/x86/kernel/acpi/wakeup_64.S and make sure that
+ * __save/__restore_processor_state(), defined in arch/x86/kernel/suspend_64.c,
+ * still work as required.
+ */
 struct saved_context {
 	struct pt_regs regs;
   	u16 ds, es, fs, gs, ss;
