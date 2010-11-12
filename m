From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] X86: Cleanup idle= internal variables by
	getting rid of idle_halt idle_nomwait
Date: Fri, 12 Nov 2010 18:02:14 +0100
Message-ID: <1289581334-26836-4-git-send-email-trenn__13232.4749640704$1289581424$gmane$org@suse.de>
References: <1289581334-26836-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1289581334-26836-1-git-send-email-trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, arjan@linux.intel.com, trenn@suse.de
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Having four variables for the same thing:
  idle_halt, idle_nomwait, force_mwait and boot_option_idle_overrides
is rather confusing and unnecessary complex.

if idle= boot param is passed, only set up one variable:
boot_option_idle_overrides

Introduces following functional changes/fixes:
  - intel_idle driver does not register if any idle=xy
    boot param is passed.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: lenb@kernel.org
CC: linux-acpi@vger.kernel.org
CC: linux-pm@lists.linux-foundation.org
---
 arch/ia64/include/asm/processor.h |    5 +++--
 arch/ia64/kernel/process.c        |    6 +-----
 arch/x86/include/asm/processor.h  |    5 +++--
 arch/x86/kernel/process.c         |   24 ++++++++----------------
 drivers/acpi/processor_core.c     |    4 ++--
 drivers/acpi/processor_idle.c     |   17 ++++++++++++-----
 drivers/idle/intel_idle.c         |    4 ++++
 7 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 348e44d..03afe79 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -717,8 +717,9 @@ prefetchw (const void *x)
 #define spin_lock_prefetch(x)	prefetchw(x)
 
 extern unsigned long boot_option_idle_override;
-extern unsigned long idle_halt;
-extern unsigned long idle_nomwait;
+
+enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_FORCE_MWAIT,
+			 IDLE_NOMWAIT, IDLE_POLL};
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 16f1c7b..6d33c5c 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -53,12 +53,8 @@
 
 void (*ia64_mark_idle)(int);
 
-unsigned long boot_option_idle_override = 0;
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
-unsigned long idle_halt;
-EXPORT_SYMBOL(idle_halt);
-unsigned long idle_nomwait;
-EXPORT_SYMBOL(idle_nomwait);
 void (*pm_idle) (void);
 EXPORT_SYMBOL(pm_idle);
 void (*pm_power_off) (void);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cae9c3c..b79bd98 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -762,10 +762,11 @@ extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void init_c1e_mask(void);
 
 extern unsigned long		boot_option_idle_override;
-extern unsigned long		idle_halt;
-extern unsigned long		idle_nomwait;
 extern bool			c1e_detected;
 
+enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
+			 IDLE_POLL, IDLE_FORCE_MWAIT};
+
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 155d975..8030493 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -22,11 +22,6 @@
 #include <asm/i387.h>
 #include <asm/debugreg.h>
 
-unsigned long idle_halt;
-EXPORT_SYMBOL(idle_halt);
-unsigned long idle_nomwait;
-EXPORT_SYMBOL(idle_nomwait);
-
 struct kmem_cache *task_xstate_cachep;
 EXPORT_SYMBOL_GPL(task_xstate_cachep);
 
@@ -328,7 +323,7 @@ long sys_execve(const char __user *name,
 /*
  * Idle related variables and functions
  */
-unsigned long boot_option_idle_override = 0;
+unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
 /*
@@ -504,7 +499,6 @@ static void poll_idle(void)
  *
  * idle=mwait overrides this decision and forces the usage of mwait.
  */
-static int __cpuinitdata force_mwait;
 
 #define MWAIT_INFO			0x05
 #define MWAIT_ECX_EXTENDED_INFO		0x01
@@ -514,7 +508,7 @@ static int __cpuinit mwait_usable(const struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (force_mwait)
+	if (boot_option_idle_override == IDLE_FORCE_MWAIT)
 		return 1;
 
 	if (c->cpuid_level < MWAIT_INFO)
@@ -634,9 +628,10 @@ static int __init idle_setup(char *str)
 	if (!strcmp(str, "poll")) {
 		printk("using polling idle threads.\n");
 		pm_idle = poll_idle;
-	} else if (!strcmp(str, "mwait"))
-		force_mwait = 1;
-	else if (!strcmp(str, "halt")) {
+		boot_option_idle_override = IDLE_POLL;
+	} else if (!strcmp(str, "mwait")) {
+		boot_option_idle_override = IDLE_FORCE_MWAIT;
+	} else if (!strcmp(str, "halt")) {
 		/*
 		 * When the boot option of idle=halt is added, halt is
 		 * forced to be used for CPU idle. In such case CPU C2/C3
@@ -645,8 +640,7 @@ static int __init idle_setup(char *str)
 		 * the boot_option_idle_override.
 		 */
 		pm_idle = default_idle;
-		idle_halt = 1;
-		return 0;
+		boot_option_idle_override = IDLE_HALT;
 	} else if (!strcmp(str, "nomwait")) {
 		/*
 		 * If the boot option of "idle=nomwait" is added,
@@ -654,12 +648,10 @@ static int __init idle_setup(char *str)
 		 * states. In such case it won't touch the variable
 		 * of boot_option_idle_override.
 		 */
-		idle_nomwait = 1;
-		return 0;
+		boot_option_idle_override = IDLE_NOMWAIT;
 	} else
 		return -1;
 
-	boot_option_idle_override = 1;
 	return 0;
 }
 early_param("idle", idle_setup);
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index bec561c..3c1a2fe 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -23,7 +23,7 @@ static int set_no_mwait(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE PREFIX "%s detected - "
 		"disabling mwait for CPU C-states\n", id->ident);
-	idle_nomwait = 1;
+	boot_option_idle_override = IDLE_NOMWAIT;
 	return 0;
 }
 
@@ -283,7 +283,7 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
 	acpi_status status = AE_OK;
 
-	if (idle_nomwait) {
+	if (boot_option_idle_override == IDLE_NOMWAIT) {
 		/*
 		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
 		 * mode will be disabled in the parameter of _PDC object.
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 104ae77..dda3412 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -79,6 +79,12 @@ module_param(bm_check_disable, uint, 0000);
 static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
 
+static int disabled_by_idle_boot_param(void)
+{
+	return boot_option_idle_override == IDLE_POLL ||
+		boot_option_idle_override == IDLE_FORCE_MWAIT;
+}
+
 /*
  * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
  * For now disable this. Probably a bug somewhere else.
@@ -455,7 +461,8 @@ static int acpi_processor_get_power_info_cst(struct acpi_processor *pr)
 				continue;
 			}
 			if (cx.type == ACPI_STATE_C1 &&
-					(idle_halt || idle_nomwait)) {
+			    (boot_option_idle_override == IDLE_HALT ||
+			     boot_option_idle_override == IDLE_NOMWAIT)) {
 				/*
 				 * In most cases the C1 space_id obtained from
 				 * _CST object is FIXED_HARDWARE access mode.
@@ -1060,7 +1067,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
 {
 	int ret = 0;
 
-	if (boot_option_idle_override)
+	if (disabled_by_idle_boot_param())
 		return 0;
 
 	if (!pr)
@@ -1091,11 +1098,11 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 	acpi_status status = 0;
 	static int first_run;
 
-	if (boot_option_idle_override)
+	if (disabled_by_idle_boot_param())
 		return 0;
 
 	if (!first_run) {
-		if (idle_halt) {
+		if (boot_option_idle_override == IDLE_HALT) {
 			/*
 			 * When the boot option of "idle=halt" is added, halt
 			 * is used for CPU IDLE.
@@ -1144,7 +1151,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
 int acpi_processor_power_exit(struct acpi_processor *pr,
 			      struct acpi_device *device)
 {
-	if (boot_option_idle_override)
+	if (disabled_by_idle_boot_param())
 		return 0;
 
 	cpuidle_unregister_device(&pr->power.dev);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ba5134f..696a8be 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -409,6 +409,10 @@ static int __init intel_idle_init(void)
 {
 	int retval;
 
+	/* Do not load intel_idle at all for now if idle= is passed */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
+		return -ENODEV;
+
 	retval = intel_idle_probe();
 	if (retval)
 		return retval;
-- 
1.6.3
