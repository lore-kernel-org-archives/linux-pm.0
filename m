From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] x86/msr: add on cpu read/modify/write function
Date: Fri, 11 Dec 2015 14:40:36 -0800
Message-ID: <1449873637-24300-2-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Remote CPU read/modify/write is often needed but currently without
a lib call. This patch adds an API to perform on CPU safe read/modify/write
so that callers don't have to invent such function.

Based on initial code from:
Peter Zijlstra <peterz@infradead.org>

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/msr.h | 24 +++++++++++++++++++++++
 arch/x86/lib/msr-smp.c     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 77d8b28..6143a47 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -27,6 +27,13 @@ struct msr_info {
 	int err;
 };
 
+struct msr_action {
+	u32 msr_no;
+	u64 mask;
+	u64 bits;
+	int err;
+};
+
 struct msr_regs_info {
 	u32 *regs;
 	int err;
@@ -258,6 +265,7 @@ int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
+int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 mask, u64 bits);
 #else  /*  CONFIG_SMP  */
 static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
@@ -314,6 +322,22 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	return wrmsr_safe_regs(regs);
 }
+static inline int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 mask, u64 bits)
+{
+	int err;
+	u64 val;
+
+	err = rdmsrl_safe(msr_no, &val);
+	if (err)
+		goto out;
+
+	val &= ~mask;
+	val |= bits;
+
+	err = wrmsrl_safe(msr_no, val);
+out:
+	return err;
+}
 #endif  /* CONFIG_SMP */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_MSR_H */
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 518532e..60ed278 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -221,6 +221,53 @@ int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 EXPORT_SYMBOL(rdmsrl_safe_on_cpu);
 
+
+static void __rmwmsrl_safe(void *info)
+{
+	int err;
+	struct msr_action *ma = info;
+	u64 val;
+
+	err = rdmsrl_safe(ma->msr_no, &val);
+	if (err)
+		goto out;
+
+	val &= ~ma->mask;
+	val |= ma->bits;
+
+	err = wrmsrl_safe(ma->msr_no, val);
+
+out:
+	ma->err = err;
+}
+
+/**
+ * rmwmsrl_safe_on_cpu: Perform a read/modify/write msr transaction on cpu
+ *
+ * @cpu:  target cpu
+ * @msr:  msr number
+ * @mask: bitmask to change
+ * @bits: bits value for the mask
+ *
+ * Returns zero for success, a negative number on error.
+ */
+int rmwmsrl_safe_on_cpu(unsigned int cpu, u32 msr, u64 mask, u64 bits)
+{
+	int err;
+	struct msr_action ma;
+
+	memset(&ma, 0, sizeof(ma));
+
+	ma.msr_no = msr;
+	ma.mask = mask;
+	ma.bits = bits;
+
+	err = smp_call_function_single(cpu, __rmwmsrl_safe, &ma, 1);
+
+	return err ? err : ma.err;
+}
+EXPORT_SYMBOL(rmwmsrl_safe_on_cpu);
+
 /*
  * These variants are significantly slower, but allows control over
  * the entire 32-bit GPR set.
-- 
1.9.1
