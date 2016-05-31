From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] powercap/rapl: add support for denverton
Date: Tue, 31 May 2016 13:41:30 -0700
Message-ID: <1464727290-5400-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464727290-5400-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Denverton micro server is Atom based but RAPL interface
is compatible with Core based CPUs.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index d51a8d4..f0fc1a3 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1137,6 +1137,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(0x57, rapl_defaults_hsw_server),/* Knights Landing */
 	RAPL_CPU(0x8E, rapl_defaults_core),/* Kabylake */
 	RAPL_CPU(0x9E, rapl_defaults_core),/* Kabylake */
+	RAPL_CPU(0x5F, rapl_defaults_core),/* Denverton micro server */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
1.9.1
