From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 2/4] powercap/rapl: reduce ipi calls
Date: Wed, 24 Feb 2016 13:31:36 -0800
Message-ID: <1456349498-1527-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:2922 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075AbcBXVdI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 16:33:08 -0500
In-Reply-To: <1456349498-1527-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Reduce remote CPU calls for MSR access by combining read
modify write into one function.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 119 ++++++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 34 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 6c592dc..a50e644 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -133,6 +133,12 @@ struct rapl_domain_data {
 	unsigned long timestamp;
 };
 
+struct msrl_action {
+	u32 msr_no;
+	u64 clear_mask;
+	u64 set_mask;
+	int err;
+};
 
 #define	DOMAIN_STATE_INACTIVE           BIT(0)
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
@@ -800,35 +806,62 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	return 0;
 }
 
+
+static int msrl_update_safe(u32 msr_no, u64 clear_mask, u64 set_mask)
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
+
+static void msrl_update_func(void *info)
+{
+	struct msrl_action *ma = info;
+
+	ma->err = msrl_update_safe(ma->msr_no, ma->clear_mask, ma->set_mask);
+}
+
 /* Similar use of primitive info in the read counterpart */
 static int rapl_write_data_raw(struct rapl_domain *rd,
 			enum rapl_primitives prim,
 			unsigned long long value)
 {
-	u64 msr_val;
-	u32 msr;
 	struct rapl_primitive_info *rp = &rpi[prim];
 	int cpu;
+	u64 bits;
+	struct msrl_action ma;
+	int ret;
 
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
 
-	return 0;
+	bits = rapl_unit_xlate(rd, rd->package_id, rp->unit, value, 1);
+	bits |= bits << rp->shift;
+	memset(&ma, 0, sizeof(ma));
+
+	ma.msr_no = rd->msrs[rp->id];
+	ma.clear_mask = rp->mask;
+	ma.set_mask = bits;
+
+	ret = smp_call_function_single(cpu, msrl_update_func, &ma, 1);
+	if (ret)
+		WARN_ON_ONCE(ret);
+	else
+		ret = ma.err;
+
+	return ret;
 }
 
 /*
@@ -893,6 +926,21 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
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
@@ -906,7 +954,6 @@ static int rapl_check_unit_atom(struct rapl_package *rp, int cpu)
 
 static void package_power_limit_irq_save(int package_id)
 {
-	u32 l, h = 0;
 	int cpu;
 	struct rapl_package *rp;
 
@@ -920,20 +967,30 @@ static void package_power_limit_irq_save(int package_id)
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
+	if (!boot_cpu_has(X86_FEATURE_PTS) || !boot_cpu_has(X86_FEATURE_PLN))
+		return;
+
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
 
@@ -951,14 +1008,8 @@ static void package_power_limit_irq_restore(int package_id)
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

