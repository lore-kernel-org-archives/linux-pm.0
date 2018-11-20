From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: pmac64: add of_node_put()
Date: Tue, 20 Nov 2018 07:54:09 -0500
Message-ID: <20181120125409.19314-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

use of_node_put to release the refcount of node.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index be623dd7b9f2..1d32a863332d 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -411,6 +411,7 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 		pfunc_set_vdnap0 = pmf_find_function(root, "set-vdnap0");
 		pfunc_vdnap0_complete =
 			pmf_find_function(root, "slewing-done");
+		of_node_put(root);
 		if (pfunc_set_vdnap0 == NULL ||
 		    pfunc_vdnap0_complete == NULL) {
 			pr_err("Can't find required platform function\n");
-- 
2.17.0
