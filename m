From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] [v2] x86, suspend: Save/restore extra MSR registers for suspend
Date: Fri, 21 Aug 2015 19:53:34 +0800
Message-ID: <1440158014-29610-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: rui.zhang@intel.com, lenb@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

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
with this situation. This patch fixes this issue by introducing a framework
for saving/restoring specify MSR registers(THERM_CONTROL in this case)
on suspend/resume.

When user finds a problematic platform that requires save/restore MSRs,
he can simply add quirk in msr_save_dmi_table, and customizes MSR
registers in quirk callback, for example:

unsigned int msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};

and system ensures that, once resumed from suspend, these MSR indicated
by IDs will be restored to their original values before suspend.

Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
common code path. And because the MSR ids specified by user might not be
available or readable in any situation, we use rdmsrl_safe to safely
save these MSR registers.

Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2:
 - Cover both 64/32-bit common code path.
   Use rdmsrl_safe to safely read MSR.
   Introduce a quirk framework for save/restore specified MSR on different
   platforms.
---
 arch/x86/include/asm/suspend_32.h | 12 +++++
 arch/x86/include/asm/suspend_64.h | 12 +++++
 arch/x86/power/cpu.c              | 93 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index d1793f0..07b0443 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -9,12 +9,24 @@
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
 
+struct msr_type {
+	unsigned int msr_id;
+	bool msr_saved;
+	u64 msr_value;
+};
+
+struct saved_msr {
+	unsigned short num;
+	struct msr_type *msr_array;
+} __attribute__((packed));
+
 /* image of the saved processor state */
 struct saved_context {
 	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	struct saved_msr msr_for_save;
 	struct desc_ptr gdt_desc;
 	struct desc_ptr idt;
 	u16 ldt;
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 7ebf0eb..321e288 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -9,6 +9,17 @@
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
 
+struct msr_type {
+	unsigned int msr_id;
+	bool msr_saved;
+	u64 msr_value;
+};
+
+struct saved_msr {
+	unsigned short num;
+	struct msr_type *msr_array;
+} __attribute__((packed));
+
 /*
  * Image of the saved processor state, used by the low level ACPI suspend to
  * RAM code and by the low level hibernation code.
@@ -24,6 +35,7 @@ struct saved_context {
 	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	struct saved_msr msr_for_save;
 	unsigned long efer;
 	u16 gdt_pad; /* Unused */
 	struct desc_ptr gdt_desc;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 9ab5279..ed6c562 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -23,6 +23,7 @@
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -32,6 +33,30 @@ __visible unsigned long saved_context_eflags;
 #endif
 struct saved_context saved_context;
 
+static void msr_save_context(struct saved_context *ctxt)
+{
+	int i = 0;
+
+	for (i = 0; i < ctxt->msr_for_save.num; i++) {
+		struct msr_type *msr =
+			&ctxt->msr_for_save.msr_array[i];
+		msr->msr_saved = !rdmsrl_safe(msr->msr_id,
+			&msr->msr_value);
+	}
+}
+
+static void msr_restore_context(struct saved_context *ctxt)
+{
+	int i = 0;
+
+	for (i = 0; i < ctxt->msr_for_save.num; i++) {
+		struct msr_type *msr =
+			&ctxt->msr_for_save.msr_array[i];
+		if (msr->msr_saved)
+			wrmsrl(msr->msr_id, msr->msr_value);
+	}
+}
+
 /**
  *	__save_processor_state - save CPU registers before creating a
  *		hibernation image and before restoring the memory state from it
@@ -111,6 +136,7 @@ static void __save_processor_state(struct saved_context *ctxt)
 #endif
 	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
+	msr_save_context(ctxt);
 }
 
 /* Needed by apm.c */
@@ -229,6 +255,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	mtrr_bp_restore();
 	perf_restore_debug_store();
+	msr_restore_context(ctxt);
 }
 
 /* Needed by apm.c */
@@ -320,3 +347,69 @@ static int __init bsp_pm_check_init(void)
 }
 
 core_initcall(bsp_pm_check_init);
+
+/* should be enough */
+#define MAX_MSR_SAVED	64
+static struct msr_type msr_context_array[MAX_MSR_SAVED];
+
+/*
+ * Following section is a quirk for some problematic BIOS:
+ * MSRs are modified by BIOS after suspending to ram, and
+ * causing unexpected bevavior after resume.
+ * Thus we save/restore these specific MSRs during suspend
+ * in order to workaround.
+ * A typical bug was reported at:
+ * https://bugzilla.redhat.com/show_bug.cgi?id=1227208
+ */
+static int msr_set_info(const unsigned int *msr_id, const int total_num)
+{
+	int i = 0;
+
+	if (total_num > MAX_MSR_SAVED) {
+		pr_err("PM: too many MSRs need to save\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < total_num; i++) {
+		msr_context_array[i].msr_id = msr_id[i];
+		msr_context_array[i].msr_saved = false;
+		msr_context_array[i].msr_value = 0;
+	}
+	saved_context.msr_for_save.num = total_num;
+	saved_context.msr_for_save.msr_array = msr_context_array;
+	return 0;
+}
+/*
+ * For any further problematic BIOS/platforms,
+ * please add your own function similar to msr_initialize_bdw.
+ */
+static int msr_initialize_bdw(const struct dmi_system_id *d)
+{
+	/* Adding any extra MSR id into the array */
+	unsigned int bdw_msr_id[] = {MSR_IA32_THERM_CONTROL};
+
+	pr_info("PM: %s detected: MSR saving is needed during suspend\n",
+		d->ident);
+	return msr_set_info(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
+}
+
+static struct dmi_system_id msr_save_dmi_table[] = {
+	{
+	 .callback = msr_initialize_bdw,
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
+	saved_context.msr_for_save.num = 0;
+	saved_context.msr_for_save.msr_array = NULL;
+	dmi_check_system(msr_save_dmi_table);
+	return 0;
+}
+
+late_initcall(pm_check_save_msr);
-- 
1.8.4.2
