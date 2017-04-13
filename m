From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/7] tools/power turbostat: show missing Core and GFX power on SKL and KBL
Date: Wed, 12 Apr 2017 20:08:48 -0400
Message-ID: <818249216d7dc9340a7d2332f6d07b462e818ee5.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

While the current SDM is silent on the matter, the Core and GFX
RAPL power meters on SKL and KBL appear to work -- so show them.

Reported-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d7fb6bcb2744..94d7e54b1ec0 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3355,17 +3355,19 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case INTEL_FAM6_SKYLAKE_DESKTOP:	/* SKL */
 	case INTEL_FAM6_KABYLAKE_MOBILE:	/* KBL */
 	case INTEL_FAM6_KABYLAKE_DESKTOP:	/* KBL */
-		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
+		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
 		if (rapl_joules) {
 			BIC_PRESENT(BIC_Pkg_J);
 			BIC_PRESENT(BIC_Cor_J);
 			BIC_PRESENT(BIC_RAM_J);
+			BIC_PRESENT(BIC_GFX_J);
 		} else {
 			BIC_PRESENT(BIC_PkgWatt);
 			BIC_PRESENT(BIC_CorWatt);
 			BIC_PRESENT(BIC_RAMWatt);
+			BIC_PRESENT(BIC_GFXWatt);
 		}
 		break;
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-- 
2.11.0.161.g6610af872
