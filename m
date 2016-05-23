From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 2/2] powercap/rapl: reduce warning level
Date: Mon, 23 May 2016 09:45:43 -0700
Message-ID: <1464021943-14915-3-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464021943-14915-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Prarit Bhargava <prarit@redhat.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Since RAPL interface is not architectual, its enumeration depends on poking
MSRs instead of using CPUID method.

In KVM guest, RAPL driver probe will fail and emit the following message
for every CPU: no valid rapl domains found in package

This patch limit the warning to debug only. Still return ENODEV so that RAPL
does not run on KVM guest.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/powercap/intel_rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index a417e68..b0a2dc4 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1324,7 +1324,7 @@ static int rapl_detect_domains(struct rapl_package *rp, int cpu)
 	}
 	rp->nr_domains = bitmap_weight(&rp->domain_map,	RAPL_DOMAIN_MAX);
 	if (!rp->nr_domains) {
-		pr_err("no valid rapl domains found in package %d\n", rp->id);
+		pr_debug("no valid rapl domains found in package %d\n", rp->id);
 		ret = -ENODEV;
 		goto done;
 	}
-- 
1.9.1
