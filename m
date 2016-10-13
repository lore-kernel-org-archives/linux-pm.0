From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 11/11] tools/power turbostat: enable turbostat to support Knights Mill (KNM)
Date: Thu, 13 Oct 2016 17:31:05 +0200
Message-ID: <20161013153105.2517-12-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by turbostat.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org
---
This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
to Intel family

 tools/power/x86/turbostat/turbostat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 09a542cc..5773509 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2213,6 +2213,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = amt_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* PHI */
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
@@ -2238,6 +2239,7 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case INTEL_FAM6_NEHALEM_EX:		/* Nehalem-EX Xeon - Beckton */
 	case INTEL_FAM6_WESTMERE_EX:		/* Westmere-EX Xeon - Eagleton */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI - Knights Landing (different MSR definition) */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* PHI - Knights Mill (similar to KNL) */
 		return 0;
 	default:
 		return 1;
@@ -2285,6 +2287,7 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* Knights Mill */
 		return 1;
 	default:
 		return 0;
@@ -2315,6 +2318,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* Knights Mill */
 		return 1;
 	default:
 		return 0;
@@ -2616,6 +2620,7 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	case INTEL_FAM6_BROADWELL_X:		/* BDX */
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -2664,6 +2669,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case INTEL_FAM6_SANDYBRIDGE_X:
@@ -3024,6 +3030,7 @@ int is_knl(unsigned int family, unsigned int model)
 		return 0;
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		return 1;
 	}
 	return 0;
-- 
2.10.1
