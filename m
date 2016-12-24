From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/17] tools/power turbostat: Support Knights Mill (KNM)
Date: Sat, 24 Dec 2016 15:53:40 -0500
Message-ID: <005c82d64d1aa49290a39573019f73b5088beeff.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33546 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbcLXU4M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:12 -0500
Received: by mail-qt0-f193.google.com with SMTP id 41so9409472qtn.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:11 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Original-author: Piotr Luc <piotr.luc@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 83d1fb9750aa..a54ca3775521 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2202,6 +2202,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = amt_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_XEON_PHI_KNL:	/* PHI */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
@@ -2228,6 +2229,7 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case INTEL_FAM6_NEHALEM_EX:	/* Nehalem-EX Xeon - Beckton */
 	case INTEL_FAM6_WESTMERE_EX:	/* Westmere-EX Xeon - Eagleton */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* PHI - Knights Landing (different MSR definition) */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		return 0;
 	default:
 		return 1;
@@ -2275,6 +2277,7 @@ int has_knl_turbo_ratio_limit(unsigned int family, unsigned int model)
 
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		return 1;
 	default:
 		return 0;
@@ -2305,6 +2308,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		return 1;
 	default:
 		return 0;
@@ -2606,6 +2610,7 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		return (rapl_dram_energy_units = 15.3 / 1000000);
 	default:
 		return (rapl_energy_units);
@@ -2654,6 +2659,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
 		break;
 	case INTEL_FAM6_SANDYBRIDGE_X:
@@ -3017,6 +3023,7 @@ int is_knl(unsigned int family, unsigned int model)
 		return 0;
 	switch (model) {
 	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
+	case INTEL_FAM6_XEON_PHI_KNM:
 		return 1;
 	}
 	return 0;
-- 
2.11.0.161.g6610af872

