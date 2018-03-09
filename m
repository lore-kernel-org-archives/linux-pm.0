From: Harry Pan <harry.pan@intel.com>
Subject: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
Date: Fri,  9 Mar 2018 20:15:46 +0800
Message-ID: <20180309121549.630-1-harry.pan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Cannon Lake microarchitecture is similar to Kaby Lake in terms of
RAPL, this patch enables CNL RAPL support.

Signed-off-by: Harry Pan <harry.pan@intel.com>
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
2.13.5
