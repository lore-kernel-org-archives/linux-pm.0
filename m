From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/18] 2.6.40: x86 idle: remove deprecated
	hlt_use_halt()
Date: Sat, 02 Apr 2011 02:22:57 -0400
Message-ID: <44df5341b941e76965c20bd60e0057c385b28204.1301724243.git.len.brown@intel.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301725380-10579-1-git-send-email-lenb@kernel.org>
In-reply-to: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Removing the floppy workaround made hlt_use_halt() constant.
So we can now remove it, and we no longer need to test it
in default_idle().

no functional change.

cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/process.c |   39 ++++++++++++++-------------------------
 1 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 09bd118..53fb569 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -344,39 +344,28 @@ void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
 #endif
 
-static inline int hlt_use_halt(void)
-{
-	return 1;
-}
-
 /*
  * We use this if we don't have any better
  * idle routine..
  */
 void default_idle(void)
 {
-	if (hlt_use_halt()) {
-		trace_power_start(POWER_CSTATE, 1, smp_processor_id());
-		trace_cpu_idle(1, smp_processor_id());
-		current_thread_info()->status &= ~TS_POLLING;
-		/*
-		 * TS_POLLING-cleared state must be visible before we
-		 * test NEED_RESCHED:
-		 */
-		smp_mb();
+	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
+	trace_cpu_idle(1, smp_processor_id());
+	current_thread_info()->status &= ~TS_POLLING;
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 
-		if (!need_resched())
-			safe_halt();	/* enables interrupts racelessly */
-		else
-			local_irq_enable();
-		current_thread_info()->status |= TS_POLLING;
-		trace_power_end(smp_processor_id());
-		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
-	} else {
+	if (!need_resched())
+		safe_halt();	/* enables interrupts racelessly */
+	else
 		local_irq_enable();
-		/* loop is done by the caller */
-		cpu_relax();
-	}
+	current_thread_info()->status |= TS_POLLING;
+	trace_power_end(smp_processor_id());
+	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 }
 #if defined(CONFIG_APM_MODULE) && defined(CONFIG_APM_CPU_IDLE)
 EXPORT_SYMBOL(default_idle);
-- 
1.7.5.rc0
