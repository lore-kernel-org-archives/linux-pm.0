From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2] powercap/rapl: add support for denverton
Date: Mon, 13 Jun 2016 17:02:28 -0700
Message-ID: <1465862548-10999-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rafael.j.wysocki@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Denverton micro server is Atom based but RAPL interface
is compatible with Core based CPUs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4aa8168..7977fbf 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1156,6 +1156,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD1,	rapl_defaults_tng),
 	RAPL_CPU(INTEL_FAM6_ATOM_MERRIFIELD2,	rapl_defaults_ann),
 	RAPL_CPU(INTEL_FAM6_ATOM_GOLDMONT,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
 	{}
-- 
1.9.1
