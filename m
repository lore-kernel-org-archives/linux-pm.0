From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/3] ACPI / CPPC: Add support for guaranteed performance
Date: Fri, 12 Oct 2018 09:43:58 -0700
Message-ID: <20181012164400.3479-2-srinivas.pandruvada@linux.intel.com>
References: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, robert.moore@intel.com, erik.schmauss@intel.com
Cc: juri.lelli@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, pprakash@codeaurora.org, george.cherian@cavium.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The Continuous Performance Control Package can have guaranteed performance
field. Add support to read guaranteed performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/cppc_acpi.c | 8 ++++++--
 include/acpi/cppc_acpi.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d9ce4b162e2c..217a782c3e55 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1061,9 +1061,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
-		*lowest_non_linear_reg, *nominal_reg,
+		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
 		*low_freq_reg = NULL, *nom_freq_reg = NULL;
-	u64 high, low, nom, min_nonlinear, low_f = 0, nom_f = 0;
+	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1079,6 +1079,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
+	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
 
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
@@ -1107,6 +1108,9 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
+	cpc_read(cpunum, guaranteed_reg, &guaranteed);
+	perf_caps->guaranteed_perf = guaranteed;
+
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8e0b8250a139..cf59e6210d27 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -104,6 +104,7 @@ enum cppc_regs {
  * today.
  */
 struct cppc_perf_caps {
+	u32 guaranteed_perf;
 	u32 highest_perf;
 	u32 nominal_perf;
 	u32 lowest_perf;
-- 
2.17.1
