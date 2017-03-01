From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/44] tools/power turbostat: initial Gemini Lake SOC support
Date: Wed,  1 Mar 2017 00:27:29 -0500
Message-ID: <ac01ac1371d01beb02827f89fff9aac9d7941e91.1488345270.git.len.brown@intel.com>
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

Gemini Lake is similar to Apollo Lake (Broxton/Goldmont)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4b04ba86e44f..819d67fbb6ca 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2535,6 +2535,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 		pkg_cstate_limits = phi_pkg_cstate_limits;
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
 	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
 		pkg_cstate_limits = bxt_pkg_cstate_limits;
 		break;
@@ -3018,6 +3019,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 		}
 		break;
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
 		do_rapl = RAPL_PKG | RAPL_PKG_POWER_INFO;
 		if (rapl_joules)
 			BIC_PRESENT(BIC_Pkg_J);
@@ -3361,6 +3363,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
 	case INTEL_FAM6_ATOM_DENVERTON:	/* DNV */
 		return 1;
 	}
@@ -3392,6 +3395,7 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+	case INTEL_FAM6_ATOM_GEMINI_LAKE:
 		return 1;
 	}
 	return 0;
@@ -3783,6 +3787,7 @@ void process_cpuid()
 					crystal_hz = 25000000;	/* 25.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
+				case INTEL_FAM6_ATOM_GEMINI_LAKE:
 					crystal_hz = 19200000;	/* 19.2 MHz */
 					break;
 				default:
-- 
2.11.0.161.g6610af872
