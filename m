From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] x86: General protection fault after STR (32 bit systems only)
Date: Thu, 11 Jun 2015 16:45:38 -0700
Message-ID: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49828 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbbFKXsE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jun 2015 19:48:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@rjwysocki.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Suspend to RAM process is returning to userspsace with DS set to KERNEL_DS
after resume, this cause general protection fault. This is very difficult
to reproduce, but this does happen on 32 bit systems. This crash is not
reproduced after save/restore DS during calls to _save_processor_state/
__restore_processor_state respectively.
Similar issue was reported in the past
https://bugzilla.kernel.org/show_bug.cgi?id=61781, for which the root cause
was not identified.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/suspend_32.h | 2 +-
 arch/x86/power/cpu.c              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index 552d6c9..3503d0b 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -11,7 +11,7 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	u16 es, fs, gs, ss;
+	u16 ds, es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 757678f..e0dfb01 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -79,6 +79,7 @@ static void __save_processor_state(struct saved_context *ctxt)
 	 * segment registers
 	 */
 #ifdef CONFIG_X86_32
+	savesegment(ds, ctxt->ds);
 	savesegment(es, ctxt->es);
 	savesegment(fs, ctxt->fs);
 	savesegment(gs, ctxt->gs);
@@ -198,6 +199,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	 * segment registers
 	 */
 #ifdef CONFIG_X86_32
+	loadsegment(ds, ctxt->ds);
 	loadsegment(es, ctxt->es);
 	loadsegment(fs, ctxt->fs);
 	loadsegment(gs, ctxt->gs);
-- 
1.9.3

