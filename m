From: Len Brown <lenb@kernel.org>
Subject: [PATCH 28/44] tools/power turbostat: fix decoding for GLM, DNV, SKX turbo-ratio limits
Date: Wed,  1 Mar 2017 00:27:32 -0500
Message-ID: <31e07522be566cd039ff7a770550076cc1707a0c.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Newer processors do not hard-code the the number of cpus in each bin
to {1, 2, 3, 4, 5, 6, 7, 8}  Rather, they can specify any number
of CPUS in each of the 8 bins:

eg.

...
37 * 100.0 = 3600.0 MHz max turbo 4 active cores
38 * 100.0 = 3700.0 MHz max turbo 3 active cores
39 * 100.0 = 3800.0 MHz max turbo 2 active cores
39 * 100.0 = 3900.0 MHz max turbo 1 active cores

could now look something like this:

...
37 * 100.0 = 3600.0 MHz max turbo 16 active cores
38 * 100.0 = 3700.0 MHz max turbo 8 active cores
39 * 100.0 = 3800.0 MHz max turbo 4 active cores
39 * 100.0 = 3900.0 MHz max turbo 2 active cores

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 90 ++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8c437115d41b..67a275882a8d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1671,56 +1671,84 @@ dump_ivt_turbo_ratio_limits(void)
 			ratio, bclk, ratio * bclk);
 	return;
 }
+int has_turbo_ratio_group_limits(int family, int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_SKYLAKE_X:
+	case INTEL_FAM6_ATOM_DENVERTON:
+		return 1;
+	}
+	return 0;
+}
 
 static void
-dump_nhm_turbo_ratio_limits(void)
+dump_turbo_ratio_limits(int family, int model)
 {
-	unsigned long long msr;
-	unsigned int ratio;
+	unsigned long long msr, core_counts;
+	unsigned int ratio, group_size;
 
 	get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT, &msr);
-
 	fprintf(outf, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n", base_cpu, msr);
 
+	if (has_turbo_ratio_group_limits(family, model)) {
+		get_msr(base_cpu, MSR_TURBO_RATIO_LIMIT1, &core_counts);
+		fprintf(outf, "cpu%d: MSR_TURBO_RATIO_LIMIT1: 0x%08llx\n", base_cpu, core_counts);
+	} else {
+		core_counts = 0x0807060504030201;
+	}
+
 	ratio = (msr >> 56) & 0xFF;
+	group_size = (core_counts >> 56) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 8 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 48) & 0xFF;
+	group_size = (core_counts >> 48) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 7 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 40) & 0xFF;
+	group_size = (core_counts >> 40) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 6 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 32) & 0xFF;
+	group_size = (core_counts >> 32) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 5 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 24) & 0xFF;
+	group_size = (core_counts >> 24) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 4 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 16) & 0xFF;
+	group_size = (core_counts >> 16) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 3 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 8) & 0xFF;
+	group_size = (core_counts >> 8) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 2 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 
 	ratio = (msr >> 0) & 0xFF;
+	group_size = (core_counts >> 0) & 0xFF;
 	if (ratio)
-		fprintf(outf, "%d * %.1f = %.1f MHz max turbo 1 active cores\n",
-			ratio, bclk, ratio * bclk);
+		fprintf(outf, "%d * %.1f = %.1f MHz max turbo %d active cores\n",
+			ratio, bclk, ratio * bclk, group_size);
 	return;
 }
 
@@ -2597,7 +2625,7 @@ int is_skx(unsigned int family, unsigned int model)
 	return 0;
 }
 
-int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
+int has_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
 	if (has_slv_msrs(family, model))
 		return 0;
@@ -2668,6 +2696,22 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 0;
 	}
 }
+int has_glm_turbo_ratio_limit(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	if (family != 6)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_GOLDMONT:
+	case INTEL_FAM6_SKYLAKE_X:
+		return 1;
+	default:
+		return 0;
+	}
+}
 int has_config_tdp(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
@@ -2714,8 +2758,8 @@ dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
 	if (has_ivt_turbo_ratio_limit(family, model))
 		dump_ivt_turbo_ratio_limits();
 
-	if (has_nhm_turbo_ratio_limit(family, model))
-		dump_nhm_turbo_ratio_limits();
+	if (has_turbo_ratio_limit(family, model))
+		dump_turbo_ratio_limits(family, model);
 
 	if (has_atom_turbo_ratio_limit(family, model))
 		dump_atom_turbo_ratio_limits();
-- 
2.11.0.161.g6610af872
