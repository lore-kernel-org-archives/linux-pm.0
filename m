From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] powercap/rapl: lower warning level for domain detection
Date: Thu, 28 Aug 2014 21:56:08 -0700
Message-ID: <1409288168-6537-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Many CPUs do not support complete set of RAPL domains, as a
result this detection failed message is very misleading and
annoying. So lower the warning message to info and reword.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index b1cda6f..0b282e7 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1169,7 +1169,7 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 		if (!rapl_check_domain(cpu, i))
 			rp->domain_map |= 1 << i;
 		else
-			pr_warn("RAPL domain %s detection failed\n",
+			pr_info("RAPL domain %s not supported\n",
 				rapl_domain_names[i]);
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
-- 
2.0.0.5.gbce14aa
