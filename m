From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/17] tools/power/turbostat: Add Denverton RAPL support
Date: Sat, 24 Dec 2016 15:53:36 -0500
Message-ID: <0f64490978ef9ed4debe33bf0dbf25e80659f7f7.1482612381.git.len.brown@intel.com>
References: <20161224205345.29129-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32836 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752424AbcLXU4J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Dec 2016 15:56:09 -0500
Received: by mail-qk0-f194.google.com with SMTP id n21so21671454qka.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Dec 2016 12:56:09 -0800 (PST)
In-Reply-To: <20161224205345.29129-1-lenb@kernel.org>
In-Reply-To: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
References: <e975db5d528abf5c42adfc50a6b0384993b6280b.1482612381.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

The Denverton CPU RAPL supports package, core, and DRAM domains.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 16ccada7e439..70a6699c528c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2663,6 +2663,9 @@ void rapl_probe(unsigned int family, unsigned int model)
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
2.11.0.161.g6610af872

