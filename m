From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 3/3] tools/power/turbostat: add denverton rapl support
Date: Thu, 16 Jun 2016 09:48:22 -0700
Message-ID: <1466095702-5537-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466095702-5537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Denverton CPU RAPL supports package, core, and dram domains.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d219c4f..3c10d6d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2677,6 +2677,9 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x4D:	/* AVN */
 		do_rapl = RAPL_PKG | RAPL_CORES;
 		break;
+	case 0x5f:	/* DNV */
+		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO | RAPL_CORES_ENERGY_STATUS;
+		break;
 	default:
 		return;
 	}
-- 
1.9.1
