From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] x86 idle: move mwait_idle_with_hints() to
	where it is used
Date: Wed, 03 Aug 2011 15:44:07 -0400
Message-ID: <779d881fbcdf840e23a9bd3e237aebca4e0376e8.1312400543.git.len.brown__6611.43071852184$1312400936$gmane$org@intel.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1312400648-17636-1-git-send-email-lenb@kernel.org>
In-reply-to: <8e24ed2af46a5d008d85bfeb128d25efc394a3fd.1312400543.git.len.brown@intel.com>
References: <8e24ed2af46a5d008d85bfeb128d25efc394a3fd.1312400543.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

...and make it static

no functional change

cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/processor.h |    2 --
 arch/x86/kernel/acpi/cstate.c    |   23 +++++++++++++++++++++++
 arch/x86/kernel/process.c        |   23 -----------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2193715..0d1171c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -751,8 +751,6 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 		     :: "a" (eax), "c" (ecx));
 }
 
-extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
-
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void init_amd_e400_c1e_mask(void);
 
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 5812404..f50e7fb 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -149,6 +149,29 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
+/*
+ * This uses new MONITOR/MWAIT instructions on P4 processors with PNI,
+ * which can obviate IPI to trigger checking of need_resched.
+ * We execute MONITOR against need_resched and enter optimized wait state
+ * through MWAIT. Whenever someone changes need_resched, we would be woken
+ * up from MWAIT (without an IPI).
+ *
+ * New with Core Duo processors, MWAIT can take some hints based on CPU
+ * capability.
+ */
+void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
+{
+	if (!need_resched()) {
+		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
+			clflush((void *)&current_thread_info()->flags);
+
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (!need_resched())
+			__mwait(ax, cx);
+	}
+}
+
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e1ba8cb..e7e3b01 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -438,29 +438,6 @@ void cpu_idle_wait(void)
 }
 EXPORT_SYMBOL_GPL(cpu_idle_wait);
 
-/*
- * This uses new MONITOR/MWAIT instructions on P4 processors with PNI,
- * which can obviate IPI to trigger checking of need_resched.
- * We execute MONITOR against need_resched and enter optimized wait state
- * through MWAIT. Whenever someone changes need_resched, we would be woken
- * up from MWAIT (without an IPI).
- *
- * New with Core Duo processors, MWAIT can take some hints based on CPU
- * capability.
- */
-void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
-{
-	if (!need_resched()) {
-		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
-			clflush((void *)&current_thread_info()->flags);
-
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		smp_mb();
-		if (!need_resched())
-			__mwait(ax, cx);
-	}
-}
-
 /* Default MONITOR/MWAIT with no hints, used for default C1 state */
 static void mwait_idle(void)
 {
-- 
1.7.6.396.ge0613
