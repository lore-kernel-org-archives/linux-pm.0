From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v5] x86, suspend: Save/restore extra MSR registers for suspend
Date: Sun, 11 Oct 2015 11:20:01 +0800
Message-ID: <1444533601-12330-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, rjw@rjwysocki.net, pavel@ucw.cz, bp@suse.de
Cc: tglx@linutronix.de, hpa@zytor.com, rui.zhang@intel.com, luto@kernel.org, linux@horizon.com, dsmythies@telus.net, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, marcin.kaszewski@intel.com, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

A bug is reported(https://bugzilla.redhat.com/show_bug.cgi?id=1227208)
that, after resumed from S3, CPU is running at a low speed.
After investigation, it is found that, BIOS has modified the value
of THERM_CONTROL register during S3, and changes it from 0 to 0x10
(thus changes the clock modulation from reserved to enabled),
since value of 0x10 means CPU can only get 25% of the Duty Cycle,
this triggers the problem.

Here is a simple scenario to reproduce the issue(only for above case):
1.Boot up the system
2.Get MSR with address 0x19a, it should be 0
3.Put the system into sleep, then wake it up
4.Get MSR with address 0x19a, it should be 0(actually it shows 0x10)

Although this is a BIOS issue, it would be more robust for linux to deal
with this situation. This patch fixes this issue by introducing a framework
to save/restore specified MSR registers(THERM_CONTROL in this case)
for suspend/resume.

When user encounters a problematic platform and needs to protect the
MSRs during suspending, he can simply add a quirk entry in
msr_save_dmi_table, and customizes MSR registers inside the quirk
callback, for example:

u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};

and the quirk mechanism ensures that, once resumed from suspended,
the MSRs indicated by these IDs will be restored to their original values
before suspended.

Since both 64/32-bit kernels are affected, this patch covers 64/32-bit
common code path. And because the MSRs specified by the user might not
be available or readable in any situation, we use rdmsrl_safe to safely
save these MSRs.

Tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v5:
 - Rename some structures and variables for better understanding.
   Put the defination of struct saved_msr and struct msr_save_data to
   header: arch/x86/include/asm/msr.h.
   Re-implement the msr_save_context and msr_restore_context for better
   maintaining.
   Convert the msr_context_array to be dynamically allocated.
   Fix some typos in code comments.
v4:
 - Revert v3 to v2, and fix some typos in changelog/comments. 
   Use msr_info structure instead of msr_id + msr_value.
   Adjust some codes for better readability.
v3:
 - Simplify the patch to only focus on THERM_CONTROL register.
   This will make things 'just work'.
v2:
 - Cover both 64/32-bit common code path.
   Use rdmsrl_safe to safely read MSR.
   Introduce a quirk framework for save/restore specified MSR on different
   platforms.
---
 arch/x86/include/asm/msr.h        | 10 ++++
 arch/x86/include/asm/suspend_32.h |  1 +
 arch/x86/include/asm/suspend_64.h |  1 +
 arch/x86/power/cpu.c              | 98 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 77d8b28..5ae24ed 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -32,6 +32,16 @@ struct msr_regs_info {
 	int err;
 };
 
+struct msr_save_data {
+	bool msr_saved;
+	struct msr_info rv;
+};
+
+struct msr_context {
+	unsigned short num;
+	struct msr_save_data *msr_array;
+};
+
 static inline unsigned long long native_read_tscp(unsigned int *aux)
 {
 	unsigned long low, high;
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
index d1793f0..5057f65 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -15,6 +15,7 @@ struct saved_context {
 	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	struct msr_context msr_to_save;
 	struct desc_ptr gdt_desc;
 	struct desc_ptr idt;
 	u16 ldt;
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index 7ebf0eb..60941de 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -24,6 +24,7 @@ struct saved_context {
 	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u64 misc_enable;
 	bool misc_enable_saved;
+	struct msr_context msr_to_save;
 	unsigned long efer;
 	u16 gdt_pad; /* Unused */
 	struct desc_ptr gdt_desc;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 9ab5279..fd3243a 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -23,6 +23,7 @@
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
 #include <asm/mmu_context.h>
+#include <linux/dmi.h>
 
 #ifdef CONFIG_X86_32
 __visible unsigned long saved_context_ebx;
@@ -32,6 +33,29 @@ __visible unsigned long saved_context_eflags;
 #endif
 struct saved_context saved_context;
 
+static void msr_save_context(struct saved_context *ctxt)
+{
+	struct msr_save_data *msr = ctxt->msr_to_save.msr_array;
+	struct msr_save_data *end = msr + ctxt->msr_to_save.num;
+
+	while (msr < end) {
+		msr->msr_saved = !rdmsrl_safe(msr->rv.msr_no, &msr->rv.reg.q);
+		msr++;
+	}
+}
+
+static void msr_restore_context(struct saved_context *ctxt)
+{
+	struct msr_save_data *msr = ctxt->msr_to_save.msr_array;
+	struct msr_save_data *end = msr + ctxt->msr_to_save.num;
+
+	while (msr < end) {
+		if (msr->msr_saved)
+			wrmsrl(msr->rv.msr_no, msr->rv.reg.q);
+		msr++;
+	}
+}
+
 /**
  *	__save_processor_state - save CPU registers before creating a
  *		hibernation image and before restoring the memory state from it
@@ -111,6 +135,7 @@ static void __save_processor_state(struct saved_context *ctxt)
 #endif
 	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
+	msr_save_context(ctxt);
 }
 
 /* Needed by apm.c */
@@ -229,6 +254,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	x86_platform.restore_sched_clock_state();
 	mtrr_bp_restore();
 	perf_restore_debug_store();
+	msr_restore_context(ctxt);
 }
 
 /* Needed by apm.c */
@@ -320,3 +346,75 @@ static int __init bsp_pm_check_init(void)
 }
 
 core_initcall(bsp_pm_check_init);
+
+/*
+ * The following section is a quirk framework for problematic BIOS:
+ * Sometimes MSRs are modified by BIOS after suspended to
+ * RAM, this might cause unexpected behavior after wakeup.
+ * Thus we save/restore these specified MSRs during suspending
+ * in order to work around it.
+ * A typical bug is reported at:
+ * https://bugzilla.redhat.com/show_bug.cgi?id=1227208
+ */
+static int msr_init_context(const u32 *msr_id, const int total_num)
+{
+	int i = 0;
+	struct msr_save_data *msr_data = NULL;
+
+	if (saved_context.msr_to_save.msr_array ||
+			saved_context.msr_to_save.num > 0) {
+		pr_err("PM: quirk already applied, please check your dmi match table.\n");
+		return -EINVAL;
+	}
+
+	msr_data = kmalloc_array(total_num,
+			sizeof(struct msr_save_data), GFP_KERNEL);
+	if (!msr_data) {
+		pr_err("PM: can not allocate memory to save/restore MSRs during suspend.\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < total_num; i++) {
+		msr_data[i].rv.msr_no = msr_id[i];
+		msr_data[i].msr_saved = false;
+		msr_data[i].rv.reg.q = 0;
+	}
+	saved_context.msr_to_save.num = total_num;
+	saved_context.msr_to_save.msr_array = msr_data;
+	return 0;
+}
+
+/*
+ * For any further problematic BIOS/platforms,
+ * please add your own function similar to msr_initialize_bdw.
+ */
+static int msr_initialize_bdw(const struct dmi_system_id *d)
+{
+	/* Add any extra MSR ids into this array. */
+	u32 bdw_msr_id[] = {MSR_IA32_THERM_CONTROL};
+
+	pr_info("PM: %s detected, MSR saving is needed during suspending.\n",
+		d->ident);
+	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
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
+
+static int pm_check_save_msr(void)
+{
+	dmi_check_system(msr_save_dmi_table);
+	return 0;
+}
+
+late_initcall(pm_check_save_msr);
-- 
1.8.4.2
