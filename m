From: Joe Konno <joe.konno@linux.intel.com>
Subject: [PATCH] powercap / RAPL: add support for Cannon Lake
Date: Fri,  2 Mar 2018 10:32:51 -0800
Message-ID: <20180302183251.139493-1-joe.konno@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Joe Konno <joe.konno@intel.com>

RAPL MSRs and handling for Cannon Lake are similar to Sky Lake and Kaby
Lake.

Signed-off-by: Joe Konno <joe.konno@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 35636e1d8a3d..295d8dcba48c 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
 	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
-- 
2.14.1
