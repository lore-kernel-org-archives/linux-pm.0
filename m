From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 1/2] x86/msr: add on cpu read/modify/write function
Date: Tue, 12 Jan 2016 17:11:22 -0800
Message-ID: <1452647483-14244-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53369 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbcAMBNQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Jan 2016 20:13:16 -0500
In-Reply-To: <1452647483-14244-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, X86 Kernel <x86@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Remote CPU read/modify/write is often needed but currently without
a lib call. This patch adds an API to perform on CPU safe read/modify/write
so that callers don't have to invent such function.

Based on initial code from:
Peter Zijlstra <peterz@infradead.org>

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/msr.h | 13 +++++++++++++
 arch/x86/lib/msr-smp.c     | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/lib/msr.c         | 18 ++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 77d8b28..c771abd 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -27,6 +27,13 @@ struct msr_info {
 	int err;
 };
 
+struct msr_action {
+	u32 msr_no;
+	u64 clear_mask;
+	u64 set_mask;
+	int err;
+};
+
 struct msr_regs_info {
 	u32 *regs;
 	int err;
@@ -244,6 +251,7 @@ struct msr *msrs_alloc(void);
 void msrs_free(struct msr *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
+int msr_rmwl_safe(u32 msr_no, u64 clear_mask, u64 set_mask);
 
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
@@ -258,6 +266,7 @@ int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
+int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 clear_mask, u64 set_mask);
 #else  /*  CONFIG_SMP  */
 static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
@@ -314,6 +323,10 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	return wrmsr_safe_regs(regs);
 }
+static inline int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 clear_mask, u64 set_mask)
+{
+	return msr_rmwl_safe(msr_no, clear_mask, set_mask);
+}
 #endif  /* CONFIG_SMP */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_MSR_H */
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 518532e..468d891 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -221,6 +221,40 @@ int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 EXPORT_SYMBOL(rdmsrl_safe_on_cpu);
 
+static void remote_rmwmsrl_safe(void *info)
+{
+	struct msr_action *ma = info;
+
+	ma->err = msr_rmwl_safe(ma->msr_no, ma->clear_mask, ma->set_mask);
+}
+
+/**
+ * rmwmsrl_safe_on_cpu: Perform a read/modify/write msr transaction on cpu
+ *
+ * @cpu:  target cpu
+ * @msr:  msr number
+ * @clear_mask: bitmask to change
+ * @set_mask: bits value for the mask
+ *
+ * Returns zero for success, a negative number on error.
+ */
+int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr, u64 clear_mask, u64 set_mask)
+{
+	int err;
+	struct msr_action ma;
+
+	memset(&ma, 0, sizeof(ma));
+
+	ma.msr_no = msr;
+	ma.clear_mask = clear_mask;
+	ma.set_mask = set_mask;
+
+	err = smp_call_function_single(cpu, remote_rmwmsrl_safe, &ma, 1);
+
+	return err ? err : ma.err;
+}
+EXPORT_SYMBOL(rmwmsrl_safe_on_cpu);
+
 /*
  * These variants are significantly slower, but allows control over
  * the entire 32-bit GPR set.
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 4362373..6e12e8d 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -108,3 +108,21 @@ int msr_clear_bit(u32 msr, u8 bit)
 {
 	return __flip_bit(msr, bit, false);
 }
+
+int msr_rmwl_safe(u32 msr_no, u64 clear_mask, u64 set_mask)
+{
+	int err;
+	u64 val;
+
+	err = rdmsrl_safe(msr_no, &val);
+	if (err)
+		goto out;
+
+	val &= ~clear_mask;
+	val |= set_mask;
+
+	err = wrmsrl_safe(msr_no, val);
+
+out:
+	return err;
+}
-- 
1.9.1

