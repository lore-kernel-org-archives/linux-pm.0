From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: [PATCH 2/4] powercap / RAPL: Add support for Broadwell-H
Date: Fri, 31 Jul 2015 08:07:36 -0700
Message-ID: <1438355256-124464-1-git-send-email-radivoje.jovanovic@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Radivoje Jovanovic <radivoje.jovanovic@intel.com>

This patch enabled RAPL to support Broadwell-H

Signed-off-by: Radivoje Jovanovic <radivoje.jovanovic@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index bca9620..a5eddfb 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1096,6 +1096,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x3f, rapl_defaults_hsw_server),/* Haswell servers */
 	RAPL_CPU(0x4f, rapl_defaults_hsw_server),/* Broadwell servers */
 	RAPL_CPU(0x45, rapl_defaults_core),/* Haswell ULT */
+	RAPL_CPU(0x47, rapl_defaults_core),/* Broadwell-H */
 	RAPL_CPU(0x4E, rapl_defaults_core),/* Skylake */
 	RAPL_CPU(0x4C, rapl_defaults_cht),/* Braswell/Cherryview */
 	RAPL_CPU(0x4A, rapl_defaults_tng),/* Tangier */
-- 
1.9.1
