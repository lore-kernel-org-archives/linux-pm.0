From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/9] x86 idle: remove NOP hlt_use_halt()
Date: Thu, 31 Mar 2011 02:03:20 -0400
Message-ID: <0617b2b99f3c7330bbe163585b73e5d21f5d25b2.1301550524.git.len.brown__38241.7836030529$1301552095$gmane$org@intel.com>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301551404-8263-1-git-send-email-lenb@kernel.org>
In-reply-to: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

hlt_use_halt() no longer has any effect,
except to complicate the indentation in default_idle().

no functional change.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/process.c |   39 ++++++++++++++-------------------------
 1 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 8688ade..094d4ac 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -342,39 +342,28 @@ EXPORT_SYMBOL(boot_option_idle_override);
 void (*pm_idle)(void);
 EXPORT_SYMBOL(pm_idle);
 
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
 #ifdef CONFIG_APM_MODULE
 EXPORT_SYMBOL(default_idle);
-- 
1.7.4.2.406.gbe91
