From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] [v3] x86, suspend: Save/restore THERM_CONTROL register for suspend
Date: Sat, 22 Aug 2015 19:02:56 +0800
Message-ID: <1440241376-31889-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29171 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbbHVK7f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 22 Aug 2015 06:59:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: lenb@kernel.org, rui.zhang@intel.com, marcin.kaszewski@intel.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
that, after resuming from S3, CPU is working at a low speed.
After investigation, it is found that, BIOS has modified the value
of THERM_CONTROL register during S3, changes it from 0 to 0x10,
while the latter means CPU can only get 25% of the Duty Cycle,
and this caused the problem.

Simple scenario to reproduce:
1.Boot up system
2.Get MSR with address 0x19a, it should output 0
3.Put system into sleep, then wake up
4.Get MSR with address 0x19a, it should output 0(actual it outputs 0x10)

Although this is a BIOS issue, it would be more robust for linux to deal
with this situation. This patch fixes this issue by introducing a quirk
for problematic platform, thus save/restore THERM_CONTROL(now called
CLOCK_MODULATION) register on suspend/resume.

Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
common code path. And because THERM_CONTROL might not be available or
readable in any situation, we use rdmsrl_safe to safely save these
MSR registers.

Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3:
 - Simplify the patch to only focus on THERM_CONTROL register.
   This will make things 'just work'.
v2:
 - Cover both 64/32-bit common code path.
   Use rdmsrl_safe to safely read MSR.
   Introduce a quirk framework for save/restore specified MSR on different
   platforms.
---
 arch/x86/include/asm/suspend_32.h |  2 ++
 arch/x86/include/asm/suspend_64.h |  2 ++
 arch/x86/power/cpu.c              | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index d1793f0..ae2785f 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -15,6 +15,8 @@ struct saved_context {
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	u64 therm_control;
+	bool therm_control_saved;
 	struct desc_ptr gdt_desc;
 	struct desc_ptr idt;
 	u16 ldt;
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 7ebf0eb..b1e6fe6 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -24,6 +24,8 @@ struct saved_context {
 	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	u64 therm_control;
+	bool therm_control_saved;
 	unsigned long efer;
 	u16 gdt_pad; /* Unused */
 	struct desc_ptr gdt_desc;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 9ab5279..7c14ced 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -23,6 +23,7 @@
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -111,6 +112,12 @@ static void __save_processor_state(struct saved_context *ctxt)
 #endif
 	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
+
+	if (ctxt->therm_control_saved) {
+		ctxt->therm_control_saved =
+			!rdmsrl_safe(MSR_IA32_THERM_CONTROL,
+			&ctxt->therm_control);
+	}
 }
 
 /* Needed by apm.c */
@@ -229,6 +236,9 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	mtrr_bp_restore();
 	perf_restore_debug_store();
+
+	if (ctxt->therm_control_saved)
+		wrmsrl(MSR_IA32_THERM_CONTROL, ctxt->therm_control);
 }
 
 /* Needed by apm.c */
@@ -320,3 +330,30 @@ static int __init bsp_pm_check_init(void)
 }
 
 core_initcall(bsp_pm_check_init);
+
+static int therm_control_need_save(const struct dmi_system_id *d)
+{
+	saved_context.therm_control_saved = true;
+	return 0;
+}
+
+static struct dmi_system_id msr_save_dmi_table[] = {
+	{
+	 .callback = therm_control_need_save,
+	 .ident = "BROADWELL BDX_EP",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "GRANTLEY"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "E63448-400"),
+		},
+	},
+	{}
+};
+static int pm_check_save_msr(void)
+{
+	saved_context.therm_control_saved = false;
+	dmi_check_system(msr_save_dmi_table);
+	return 0;
+}
+
+late_initcall(pm_check_save_msr);
-- 
1.8.4.2

