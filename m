From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: reduce ipi calls
Date: Mon,  7 Dec 2015 15:01:15 -0800
Message-ID: <1449529275-14722-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Reduce remote CPU calls for MSR access by combining read
modify write into one function.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 91 +++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 33 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index cc97f08..620c916 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -800,33 +800,43 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	return 0;
 }
 
+struct rapl_msr_action {
+	u32 msr;
+	unsigned long long value;
+	int shift;
+	u64 mask;
+};
+
+static void rapl_write_data_cpu(void *info)
+{
+	u64 msr_val;
+	struct rapl_msr_action *ra = (struct rapl_msr_action *)info;
+
+	rdmsrl_safe(ra->msr, &msr_val);
+	msr_val &= ~ra->mask;
+	msr_val |= ra->value << ra->shift;
+	wrmsrl_safe(ra->msr, msr_val);
+}
+
 /* Similar use of primitive info in the read counterpart */
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value)
 {
-	u64 msr_val;
-	u32 msr;
+
+	struct rapl_msr_action ra;
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
 
 	cpu = find_active_cpu_on_package(rd->package_id);
 	if (cpu < 0)
 		return cpu;
-	msr = rd->msrs[rp->id];
-	if (rdmsrl_safe_on_cpu(cpu, msr, &msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to read msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
-	value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
-	msr_val &= ~rp->mask;
-	msr_val |= value << rp->shift;
-	if (wrmsrl_safe_on_cpu(cpu, msr, msr_val)) {
-		dev_dbg(&rd->power_zone.dev,
-			"failed to write msr 0x%x on cpu %d\n", msr, cpu);
-		return -EIO;
-	}
+
+	ra.msr = rd->msrs[rp->id];
+	ra.shift = rp->shift;
+	ra.mask = rp->mask;
+	ra.value = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
+	smp_call_function_single(cpu, rapl_write_data_cpu, &ra, 1);
 
 	return 0;
 }
@@ -893,6 +903,21 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 	return 0;
 }
 
+static void power_limit_irq_save_cpu(void *info)
+{
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
+
+	/* save the state of PLN irq mask bit before disabling it */
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
+		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
+		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
+	}
+	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+}
+
 
 /* REVISIT:
  * When package power limit is set artificially low by RAPL, LVT
@@ -906,7 +931,6 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 
 static void package_power_limit_irq_save(int package_id)
 {
-	u32 l, h = 0;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -920,20 +944,27 @@ static void package_power_limit_irq_save(int package_id)
 	cpu = find_active_cpu_on_package(package_id);
 	if (cpu < 0)
 		return;
-	/* save the state of PLN irq mask bit before disabling it */
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
-		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
-		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
-	}
-	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(cpu, power_limit_irq_save_cpu, rp, 1);
+}
+
+static void power_limit_irq_restore_cpu(void *info)
+{
+	u32 l, h = 0;
+	struct rapl_package *rp = (struct rapl_package *)info;
+
+	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+
+	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
+		l |= PACKAGE_THERM_INT_PLN_ENABLE;
+	else
+		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+
+	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
 }
 
 /* restore per package power limit interrupt enable state */
 static void package_power_limit_irq_restore(int package_id)
 {
-	u32 l, h;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -951,14 +982,8 @@ static void package_power_limit_irq_restore(int package_id)
 	/* irq enable state not saved, nothing to restore */
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
 		return;
-	rdmsr_safe_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
-
-	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
-		l |= PACKAGE_THERM_INT_PLN_ENABLE;
-	else
-		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	smp_call_function_single(cpu, power_limit_irq_restore_cpu, rp, 1);
 }
 
 static void set_floor_freq_default(struct rapl_domain *rd, bool mode)
-- 
1.9.1
