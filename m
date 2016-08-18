From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 06/11] acpi: cpcc: Add integer read support
Date: Thu, 18 Aug 2016 15:36:47 -0700
Message-ID: <1471559812-19967-7-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

The _CPC performance limits can also be simple integer not just buffer
with register information. Add support for integer read via cpc_read.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2e98173..34209f5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -651,11 +651,18 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
  * we can directly write to it.
  */
 
-static int cpc_read(struct cpc_reg *reg, u64 *val)
+static int cpc_read(struct cpc_register_resource *res, u64 *val)
 {
+	struct cpc_reg *reg = &res->cpc_entry.reg;
 	int ret_val = 0;
 
 	*val = 0;
+
+	if (res->type == ACPI_TYPE_INTEGER) {
+		*val = res->cpc_entry.int_value;
+		return 0;
+	}
+
 	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
 		void __iomem *vaddr = GET_PCC_VADDR(reg->address);
 
@@ -754,16 +761,16 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		}
 	}
 
-	cpc_read(&highest_reg->cpc_entry.reg, &high);
+	cpc_read(highest_reg, &high);
 	perf_caps->highest_perf = high;
 
-	cpc_read(&lowest_reg->cpc_entry.reg, &low);
+	cpc_read(lowest_reg, &low);
 	perf_caps->lowest_perf = low;
 
-	cpc_read(&ref_perf->cpc_entry.reg, &ref);
+	cpc_read(ref_perf, &ref);
 	perf_caps->reference_perf = ref;
 
-	cpc_read(&nom_perf->cpc_entry.reg, &nom);
+	cpc_read(nom_perf, &nom);
 	perf_caps->nominal_perf = nom;
 
 	if (!ref)
@@ -812,8 +819,8 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 		}
 	}
 
-	cpc_read(&delivered_reg->cpc_entry.reg, &delivered);
-	cpc_read(&reference_reg->cpc_entry.reg, &reference);
+	cpc_read(delivered_reg, &delivered);
+	cpc_read(reference_reg, &reference);
 
 	if (!delivered || !reference) {
 		ret = -EFAULT;
-- 
2.7.4
