From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH 1/2] tools/power turbostat: Use Intel family processor macros
Date: Wed, 12 Oct 2016 20:29:48 +0200
Message-ID: <20161012182949.4015-2-piotr.luc@intel.com>
References: <20161012182949.4015-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:59838 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933928AbcJLScl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:32:41 -0400
In-Reply-To: <20161012182949.4015-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use macros of Intel processor families instead of raw numbers.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/turbostat/Makefile    |   3 +-
 tools/power/x86/turbostat/turbostat.c | 242 +++++++++++++++++-----------------
 2 files changed, 123 insertions(+), 122 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 8561e7d..20631f6 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -9,7 +9,8 @@ endif
 
 turbostat : turbostat.c
 CFLAGS +=	-Wall
-CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
+CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"' \
+		-DFAMILYHEADER='"../../../../arch/x86/include/asm/intel-family.h"'
 
 %: %.c
 	@mkdir -p $(BUILD_OUTPUT)
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 3e199b5..cea7a76 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2174,47 +2174,47 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	bclk = discover_bclk(family, model);
 
 	switch (model) {
-	case 0x1A:	/* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
-	case 0x1E:	/* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
-	case 0x1F:	/* Core i7 and i5 Processor - Nehalem */
-	case 0x25:	/* Westmere Client - Clarkdale, Arrandale */
-	case 0x2C:	/* Westmere EP - Gulftown */
-	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
-	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
+	case INTEL_FAM6_NEHALEM_EP:		/* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
+	case INTEL_FAM6_NEHALEM:		/* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
+	case INTEL_FAM6_NEHALEM_G:		/* Core i7 and i5 Processor - Nehalem */
+	case INTEL_FAM6_WESTMERE:		/* Westmere Client - Clarkdale, Arrandale */
+	case INTEL_FAM6_WESTMERE_EP:		/* Westmere EP - Gulftown */
+	case INTEL_FAM6_NEHALEM_EX:		/* Nehalem-EX Xeon - Beckton */
+	case INTEL_FAM6_WESTMERE_EX:		/* Westmere-EX Xeon - Eagleton */
 		pkg_cstate_limits = nhm_pkg_cstate_limits;
 		break;
-	case 0x2A:	/* SNB */
-	case 0x2D:	/* SNB Xeon */
-	case 0x3A:	/* IVB */
-	case 0x3E:	/* IVB Xeon */
+	case INTEL_FAM6_SANDYBRIDGE:		/* SNB */
+	case INTEL_FAM6_SANDYBRIDGE_X:		/* SNB Xeon */
+	case INTEL_FAM6_IVYBRIDGE:		/* IVB */
+	case INTEL_FAM6_IVYBRIDGE_X:		/* IVB Xeon */
 		pkg_cstate_limits = snb_pkg_cstate_limits;
 		break;
-	case 0x3C:	/* HSW */
-	case 0x3F:	/* HSX */
-	case 0x45:	/* HSW */
-	case 0x46:	/* HSW */
-	case 0x3D:	/* BDW */
-	case 0x47:	/* BDW */
-	case 0x4F:	/* BDX */
-	case 0x56:	/* BDX-DE */
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
-	case 0x55:	/* SKX */
+	case INTEL_FAM6_HASWELL_CORE:		/* HSW */
+	case INTEL_FAM6_HASWELL_X:		/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_HASWELL_GT3E:		/* HSW */
+	case INTEL_FAM6_BROADWELL_CORE:		/* BDW */
+	case INTEL_FAM6_BROADWELL_GT3E:		/* BDW */
+	case INTEL_FAM6_BROADWELL_X:		/* BDX */
+	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
+	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		break;
-	case 0x37:	/* BYT */
-	case 0x4D:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
 		pkg_cstate_limits = slv_pkg_cstate_limits;
 		break;
-	case 0x4C:	/* AMT */
+	case INTEL_FAM6_ATOM_AIRMONT:		/* AMT */
 		pkg_cstate_limits = amt_pkg_cstate_limits;
 		break;
-	case 0x57:	/* PHI */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI */
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
-	case 0x5C:	/* BXT */
+	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
 	default:
@@ -2234,9 +2234,9 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
 	switch (model) {
 	/* Nehalem compatible, but do not include turbo-ratio limit support */
-	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
-	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
-	case 0x57:	/* PHI - Knights Landing (different MSR definition) */
+	case INTEL_FAM6_NEHALEM_EX:		/* Nehalem-EX Xeon - Beckton */
+	case INTEL_FAM6_WESTMERE_EX:		/* Westmere-EX Xeon - Eagleton */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* PHI - Knights Landing (different MSR definition) */
 		return 0;
 	default:
 		return 1;
@@ -2251,8 +2251,8 @@ int has_ivt_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x3E:	/* IVB Xeon */
-	case 0x3F:	/* HSW Xeon */
+	case INTEL_FAM6_IVYBRIDGE_X:		/* IVB Xeon */
+	case INTEL_FAM6_HASWELL_X:		/* HSW Xeon */
 		return 1;
 	default:
 		return 0;
@@ -2267,7 +2267,7 @@ int has_hsw_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x3F:	/* HSW Xeon */
+	case INTEL_FAM6_HASWELL_X:		/* HSW Xeon */
 		return 1;
 	default:
 		return 0;
@@ -2283,7 +2283,7 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x57:	/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
 		return 1;
 	default:
 		return 0;
@@ -2298,22 +2298,22 @@ int has_config_tdp(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x3A:	/* IVB */
-	case 0x3C:	/* HSW */
-	case 0x3F:	/* HSX */
-	case 0x45:	/* HSW */
-	case 0x46:	/* HSW */
-	case 0x3D:	/* BDW */
-	case 0x47:	/* BDW */
-	case 0x4F:	/* BDX */
-	case 0x56:	/* BDX-DE */
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
-	case 0x55:	/* SKX */
-
-	case 0x57:	/* Knights Landing */
+	case INTEL_FAM6_IVYBRIDGE:		/* IVB */
+	case INTEL_FAM6_HASWELL_CORE:		/* HSW */
+	case INTEL_FAM6_HASWELL_X:		/* HSX */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_HASWELL_GT3E:		/* HSW */
+	case INTEL_FAM6_BROADWELL_CORE:		/* BDW */
+	case INTEL_FAM6_BROADWELL_GT3E:		/* BDW */
+	case INTEL_FAM6_BROADWELL_X:		/* BDX */
+	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
+	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
+
+	case INTEL_FAM6_XEON_PHI_KNL:		/* Knights Landing */
 		return 1;
 	default:
 		return 0;
@@ -2593,8 +2593,8 @@ double get_tdp(unsigned int model)
 			return ((msr >> 0) & RAPL_POWER_GRANULARITY) * rapl_power_units;
 
 	switch (model) {
-	case 0x37:
-	case 0x4D:
+	case INTEL_FAM6_ATOM_SILVERMONT1:
+	case INTEL_FAM6_ATOM_SILVERMONT2:
 		return 30.0;
 	default:
 		return 135.0;
@@ -2611,10 +2611,10 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	/* only called for genuine_intel, family 6 */
 
 	switch (model) {
-	case 0x3F:	/* HSX */
-	case 0x4F:	/* BDX */
-	case 0x56:	/* BDX-DE */
-	case 0x57:	/* KNL */
+	case INTEL_FAM6_HASWELL_X:		/* HSX */
+	case INTEL_FAM6_BROADWELL_X:		/* BDX */
+	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -2640,37 +2640,37 @@ void rapl_probe(unsigned int family, unsigned int model)
 		return;
 
 	switch (model) {
-	case 0x2A:
-	case 0x3A:
-	case 0x3C:	/* HSW */
-	case 0x45:	/* HSW */
-	case 0x46:	/* HSW */
-	case 0x3D:	/* BDW */
-	case 0x47:	/* BDW */
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_HASWELL_CORE:		/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_HASWELL_GT3E:		/* HSW */
+	case INTEL_FAM6_BROADWELL_CORE:		/* BDW */
+	case INTEL_FAM6_BROADWELL_GT3E:		/* BDW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		break;
-	case 0x5C:	/* BXT */
+	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
 		break;
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
-	case 0x3F:	/* HSX */
-	case 0x4F:	/* BDX */
-	case 0x56:	/* BDX-DE */
-	case 0x55:	/* SKX */
-	case 0x57:	/* KNL */
+	case INTEL_FAM6_HASWELL_X:		/* HSX */
+	case INTEL_FAM6_BROADWELL_X:		/* BDX */
+	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
-	case 0x2D:
-	case 0x3E:
+	case INTEL_FAM6_SANDYBRIDGE_X:
+	case INTEL_FAM6_IVYBRIDGE_X:
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_PKG_PERF_STATUS | RAPL_DRAM_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
-	case 0x37:	/* BYT */
-	case 0x4D:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
 		do_rapl = RAPL_PKG | RAPL_CORES ;
 		break;
 	default:
@@ -2713,11 +2713,11 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 		return;
 
 	switch (model) {
-	case 0x3C:	/* HSW */
-	case 0x45:	/* HSW */
-	case 0x46:	/* HSW */
+	case INTEL_FAM6_HASWELL_CORE:		/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_HASWELL_GT3E:		/* HSW */
 		do_gfx_perf_limit_reasons = 1;
-	case 0x3F:	/* HSX */
+	case INTEL_FAM6_HASWELL_X:		/* HSX */
 		do_core_perf_limit_reasons = 1;
 		do_ring_perf_limit_reasons = 1;
 	default:
@@ -2927,24 +2927,24 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x2A:
-	case 0x2D:
-	case 0x3A:	/* IVB */
-	case 0x3E:	/* IVB Xeon */
-	case 0x3C:	/* HSW */
-	case 0x3F:	/* HSW */
-	case 0x45:	/* HSW */
-	case 0x46:	/* HSW */
-	case 0x3D:	/* BDW */
-	case 0x47:	/* BDW */
-	case 0x4F:	/* BDX */
-	case 0x56:	/* BDX-DE */
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
-	case 0x55:	/* SKX */
-	case 0x5C:	/* BXT */
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_SANDYBRIDGE_X:
+	case INTEL_FAM6_IVYBRIDGE:		/* IVB */
+	case INTEL_FAM6_IVYBRIDGE_X:		/* IVB Xeon */
+	case INTEL_FAM6_HASWELL_CORE:		/* HSW */
+	case INTEL_FAM6_HASWELL_X:		/* HSW */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_HASWELL_GT3E:		/* HSW */
+	case INTEL_FAM6_BROADWELL_CORE:		/* BDW */
+	case INTEL_FAM6_BROADWELL_GT3E:		/* BDW */
+	case INTEL_FAM6_BROADWELL_X:		/* BDX */
+	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
+	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
+	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 		return 1;
 	}
 	return 0;
@@ -2968,13 +2968,13 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x45:	/* HSW */
-	case 0x3D:	/* BDW */
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
-	case 0x5C:	/* BXT */
+	case INTEL_FAM6_HASWELL_ULT:		/* HSW */
+	case INTEL_FAM6_BROADWELL_CORE:		/* BDW */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
+	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 		return 1;
 	}
 	return 0;
@@ -2994,10 +2994,10 @@ int has_skl_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case 0x4E:	/* SKL */
-	case 0x5E:	/* SKL */
-	case 0x8E:	/* KBL */
-	case 0x9E:	/* KBL */
+	case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 		return 1;
 	}
 	return 0;
@@ -3010,8 +3010,8 @@ int is_slm(unsigned int family, unsigned int model)
 	if (!genuine_intel)
 		return 0;
 	switch (model) {
-	case 0x37:	/* BYT */
-	case 0x4D:	/* AVN */
+	case INTEL_FAM6_ATOM_SILVERMONT1:	/* BYT */
+	case INTEL_FAM6_ATOM_SILVERMONT2:	/* AVN */
 		return 1;
 	}
 	return 0;
@@ -3022,7 +3022,7 @@ int is_knl(unsigned int family, unsigned int model)
 	if (!genuine_intel)
 		return 0;
 	switch (model) {
-	case 0x57:	/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNL:		/* KNL */
 		return 1;
 	}
 	return 0;
@@ -3303,16 +3303,16 @@ void process_cpuid()
 
 			if (crystal_hz == 0)
 				switch(model) {
-				case 0x4E:	/* SKL */
-				case 0x5E:	/* SKL */
-				case 0x8E:	/* KBL */
-				case 0x9E:	/* KBL */
+				case INTEL_FAM6_SKYLAKE_MOBILE:		/* SKL */
+				case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
+				case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
+				case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
-				case 0x55:	/* SKX */
+				case INTEL_FAM6_SKYLAKE_X:		/* SKX */
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
-				case 0x5C:	/* BXT */
+				case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
2.10.1

