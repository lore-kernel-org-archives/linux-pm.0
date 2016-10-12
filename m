From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH 2/2] tools/power turbostat: enable turbostat to support Knights Mill (KNM)
Date: Wed, 12 Oct 2016 20:29:49 +0200
Message-ID: <20161012182949.4015-3-piotr.luc@intel.com>
References: <20161012182949.4015-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:51950 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933937AbcJLScl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:32:41 -0400
In-Reply-To: <20161012182949.4015-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add Knights Mill (KNM) to the list of CPUIDs supported by turbostat.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org
---
Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

 tools/power/x86/turbostat/turbostat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index cea7a76..19c31a7 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2212,6 +2212,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = amt_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* PHI */
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
@@ -2237,6 +2238,7 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case INTEL_FAM6_NEHALEM_EX:		/* Nehalem-EX Xeon - Beckton */
 	case INTEL_FAM6_WESTMERE_EX:		/* Westmere-EX Xeon - Eagleton */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI - Knights Landing (different MSR definition) */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* PHI - Knights Mill (similar to KNL) */
 		return 0;
 	default:
 		return 1;
@@ -2284,6 +2286,7 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* Knights Mill */
 		return 1;
 	default:
 		return 0;
@@ -2314,6 +2317,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* Knights Mill */
 		return 1;
 	default:
 		return 0;
@@ -2615,6 +2619,7 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	case INTEL_FAM6_BROADWELL_X:		/* BDX */
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -2663,6 +2668,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case INTEL_FAM6_SANDYBRIDGE_X:
@@ -3023,6 +3029,7 @@ int is_knl(unsigned int family, unsigned int model)
 		return 0;
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:		/* KNM */
 		return 1;
 	}
 	return 0;
-- 
2.10.1

