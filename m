From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 07/11] acpi: cppc: Add support for function fixed hardware address
Date: Thu, 18 Aug 2016 15:36:48 -0700
Message-ID: <1471559812-19967-8-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

The CPPC registers can also be accessed via function fixed hardware
addresses in X86. Add support by modifying cpc_read and cpc_write
to be able to read/write MSRs on x86 platform. Also with this change,
acpi_cppc_processor_probe doesn't bail out if space id is not equal to
PCC or memory address space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c | 77 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 34209f5..939fb5c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -42,6 +42,10 @@
 #include <linux/ktime.h>
 
 #include <acpi/cppc_acpi.h>
+#ifdef CONFIG_X86
+#include <asm/msr.h>
+#endif
+
 /*
  * Lock to provide mutually exclusive access to the PCC
  * channel. e.g. When the remote updates the shared region
@@ -585,8 +589,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					pr_debug("Mismatched PCC ids.\n");
 					goto out_free;
 				}
-			} else if (gas_t->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-				/* Support only PCC and SYS MEM type regs */
+			} else if (gas_t->space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+				   gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE) {
+				/* Support only PCC, FFH and SYS MEM type regs */
 				pr_debug("Unsupported register type: %d\n", gas_t->space_id);
 				goto out_free;
 			}
@@ -645,13 +650,59 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
+#ifdef CONFIG_X86
+static int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
+{
+	int err;
+
+	err = rdmsrl_on_cpu(cpunum, reg->address, val);
+	if (!err) {
+		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+				       reg->bit_offset);
+
+		*val &= mask;
+		*val >>= reg->bit_offset;
+	}
+	return err;
+}
+
+static int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
+{
+	u64 rd_val;
+	int err;
+
+	err = rdmsrl_on_cpu(cpunum, reg->address, &rd_val);
+	if (!err) {
+		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
+				       reg->bit_offset);
+
+		val <<= reg->bit_offset;
+		val &= mask;
+		rd_val &= ~mask;
+		rd_val |= val;
+		err = wrmsrl_on_cpu(cpunum, reg->address, rd_val);
+	}
+	return err;
+}
+#else
+static int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
+{
+	return -EINVAL;
+}
+static int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
+{
+	return -EINVAL;
+
+}
+#endif
+
 /*
  * Since cpc_read and cpc_write are called while holding pcc_lock, it should be
  * as fast as possible. We have already mapped the PCC subspace during init, so
  * we can directly write to it.
  */
 
-static int cpc_read(struct cpc_register_resource *res, u64 *val)
+static int cpc_read(int cpunum, struct cpc_register_resource *res, u64 *val)
 {
 	struct cpc_reg *reg = &res->cpc_entry.reg;
 	int ret_val = 0;
@@ -684,13 +735,15 @@ static int cpc_read(struct cpc_register_resource *res, u64 *val)
 				reg->bit_width);
 			ret_val = -EFAULT;
 		}
+	} else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		ret_val = cpc_read_ffh(cpunum, reg, val);
 	} else
 		ret_val = acpi_os_read_memory((acpi_physical_address)reg->address,
 					val, reg->bit_width);
 	return ret_val;
 }
 
-static int cpc_write(struct cpc_reg *reg, u64 val)
+static int cpc_write(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	int ret_val = 0;
 
@@ -716,6 +769,8 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
 			ret_val = -EFAULT;
 			break;
 		}
+	} else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		ret_val = cpc_write_ffh(cpunum, reg, val);
 	} else
 		ret_val = acpi_os_write_memory((acpi_physical_address)reg->address,
 				val, reg->bit_width);
@@ -761,16 +816,16 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		}
 	}
 
-	cpc_read(highest_reg, &high);
+	cpc_read(cpunum, highest_reg, &high);
 	perf_caps->highest_perf = high;
 
-	cpc_read(lowest_reg, &low);
+	cpc_read(cpunum, lowest_reg, &low);
 	perf_caps->lowest_perf = low;
 
-	cpc_read(ref_perf, &ref);
+	cpc_read(cpunum, ref_perf, &ref);
 	perf_caps->reference_perf = ref;
 
-	cpc_read(nom_perf, &nom);
+	cpc_read(cpunum, nom_perf, &nom);
 	perf_caps->nominal_perf = nom;
 
 	if (!ref)
@@ -819,8 +874,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(delivered_reg, &delivered);
-	cpc_read(reference_reg, &reference);
+	cpc_read(cpunum, delivered_reg, &delivered);
+	cpc_read(cpunum, reference_reg, &reference);
 
 	if (!delivered || !reference) {
 		ret = -EFAULT;
@@ -875,7 +930,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * Skip writing MIN/MAX until Linux knows how to come up with
 	 * useful values.
 	 */
-	cpc_write(&desired_reg->cpc_entry.reg, perf_ctrls->desired_perf);
+	cpc_write(cpu, &desired_reg->cpc_entry.reg, perf_ctrls->desired_perf);
 
 	/* Is this a PCC reg ?*/
 	if (desired_reg->cpc_entry.reg.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-- 
2.7.4
