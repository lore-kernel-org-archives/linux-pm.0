From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] x86 idle: clarify AMD erratum 400 workaround
Date: Sun, 29 May 2011 05:41:45 -0400
Message-ID: <02c68a02018669d1817c43c42de800975cbec467.1306662035.git.len.brown@intel.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306662110-29954-1-git-send-email-lenb@kernel.org>
In-reply-to: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The workaround for AMD erratum 400 uses the term "c1e" falsely suggesting:
1. Intel C1E is somehow involved
2. All AMD processors with C1E are involved

Use the string "amd_c1e" instead of simply "c1e" to clarify that
this workaround is specific to AMD's version of C1E.
Use the string "e400" to clarify that the workaround is specific
to AMD processors with Erratum 400.

This patch is text-substitution only, with no functional change.

cc: x86@kernel.org
Acked-by: Borislav Petkov <borislav.petkov@amd.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/acpi.h      |    2 +-
 arch/x86/include/asm/idle.h      |    2 +-
 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/kernel/cpu/common.c     |    2 +-
 arch/x86/kernel/process.c        |   38 +++++++++++++++++++-------------------
 arch/x86/kernel/smpboot.c        |    2 +-
 drivers/acpi/processor_idle.c    |    2 +-
 7 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 4ea15ca..52fd57f 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -138,7 +138,7 @@ static inline unsigned int acpi_processor_cstate_check(unsigned int max_cstate)
 	    boot_cpu_data.x86_model <= 0x05 &&
 	    boot_cpu_data.x86_mask < 0x0A)
 		return 1;
-	else if (c1e_detected)
+	else if (amd_e400_c1e_detected)
 		return 1;
 	else
 		return max_cstate;
diff --git a/arch/x86/include/asm/idle.h b/arch/x86/include/asm/idle.h
index 38d8737..f49253d7 100644
--- a/arch/x86/include/asm/idle.h
+++ b/arch/x86/include/asm/idle.h
@@ -16,6 +16,6 @@ static inline void enter_idle(void) { }
 static inline void exit_idle(void) { }
 #endif /* CONFIG_X86_64 */
 
-void c1e_remove_cpu(int cpu);
+void amd_e400_remove_cpu(int cpu);
 
 #endif /* _ASM_X86_IDLE_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 45636ce..b9c03fb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -758,10 +758,10 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 extern void mwait_idle_with_hints(unsigned long eax, unsigned long ecx);
 
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
-extern void init_c1e_mask(void);
+extern void init_amd_e400_c1e_mask(void);
 
 extern unsigned long		boot_option_idle_override;
-extern bool			c1e_detected;
+extern bool			amd_e400_c1e_detected;
 
 enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 			 IDLE_POLL, IDLE_FORCE_MWAIT};
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1d59834..745a602 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -887,7 +887,7 @@ static void vgetcpu_set_mode(void)
 void __init identify_boot_cpu(void)
 {
 	identify_cpu(&boot_cpu_data);
-	init_c1e_mask();
+	init_amd_e400_c1e_mask();
 #ifdef CONFIG_X86_32
 	sysenter_setup();
 	enable_sep_cpu();
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ff45541..2efbfb7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -538,45 +538,45 @@ int mwait_usable(const struct cpuinfo_x86 *c)
 	return (edx & MWAIT_EDX_C1);
 }
 
-bool c1e_detected;
-EXPORT_SYMBOL(c1e_detected);
+bool amd_e400_c1e_detected;
+EXPORT_SYMBOL(amd_e400_c1e_detected);
 
-static cpumask_var_t c1e_mask;
+static cpumask_var_t amd_e400_c1e_mask;
 
-void c1e_remove_cpu(int cpu)
+void amd_e400_remove_cpu(int cpu)
 {
-	if (c1e_mask != NULL)
-		cpumask_clear_cpu(cpu, c1e_mask);
+	if (amd_e400_c1e_mask != NULL)
+		cpumask_clear_cpu(cpu, amd_e400_c1e_mask);
 }
 
 /*
- * C1E aware idle routine. We check for C1E active in the interrupt
+ * AMD Erratum 400 aware idle routine. We check for C1E active in the interrupt
  * pending message MSR. If we detect C1E, then we handle it the same
  * way as C3 power states (local apic timer and TSC stop)
  */
-static void c1e_idle(void)
+static void amd_e400_idle(void)
 {
 	if (need_resched())
 		return;
 
-	if (!c1e_detected) {
+	if (!amd_e400_c1e_detected) {
 		u32 lo, hi;
 
 		rdmsr(MSR_K8_INT_PENDING_MSG, lo, hi);
 
 		if (lo & K8_INTP_C1E_ACTIVE_MASK) {
-			c1e_detected = true;
+			amd_e400_c1e_detected = true;
 			if (!boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 				mark_tsc_unstable("TSC halt in AMD C1E");
 			printk(KERN_INFO "System has AMD C1E enabled\n");
 		}
 	}
 
-	if (c1e_detected) {
+	if (amd_e400_c1e_detected) {
 		int cpu = smp_processor_id();
 
-		if (!cpumask_test_cpu(cpu, c1e_mask)) {
-			cpumask_set_cpu(cpu, c1e_mask);
+		if (!cpumask_test_cpu(cpu, amd_e400_c1e_mask)) {
+			cpumask_set_cpu(cpu, amd_e400_c1e_mask);
 			/*
 			 * Force broadcast so ACPI can not interfere.
 			 */
@@ -619,17 +619,17 @@ void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
 		pm_idle = mwait_idle;
 	} else if (cpu_has_amd_erratum(amd_erratum_400)) {
 		/* E400: APIC timer interrupt does not wake up CPU from C1e */
-		printk(KERN_INFO "using C1E aware idle routine\n");
-		pm_idle = c1e_idle;
+		printk(KERN_INFO "using AMD E400 aware idle routine\n");
+		pm_idle = amd_e400_idle;
 	} else
 		pm_idle = default_idle;
 }
 
-void __init init_c1e_mask(void)
+void __init init_amd_e400_c1e_mask(void)
 {
-	/* If we're using c1e_idle, we need to allocate c1e_mask. */
-	if (pm_idle == c1e_idle)
-		zalloc_cpumask_var(&c1e_mask, GFP_KERNEL);
+	/* If we're using amd_e400_idle, we need to allocate amd_e400_c1e_mask. */
+	if (pm_idle == amd_e400_idle)
+		zalloc_cpumask_var(&amd_e400_c1e_mask, GFP_KERNEL);
 }
 
 static int __init idle_setup(char *str)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 08776a9..2c33633 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1379,7 +1379,7 @@ void play_dead_common(void)
 {
 	idle_task_exit();
 	reset_lazy_tlbstate();
-	c1e_remove_cpu(raw_smp_processor_id());
+	amd_e400_remove_cpu(raw_smp_processor_id());
 
 	mb();
 	/* Ack it */
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d615b7d..431ab11 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -161,7 +161,7 @@ static void lapic_timer_check_state(int state, struct acpi_processor *pr,
 	if (cpu_has(&cpu_data(pr->id), X86_FEATURE_ARAT))
 		return;
 
-	if (c1e_detected)
+	if (amd_e400_c1e_detected)
 		type = ACPI_STATE_C1;
 
 	/*
-- 
1.7.5.3.367.ga9930.dirty
