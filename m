From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: powernv: add of_node_put()
Date: Tue, 20 Nov 2018 07:57:31 -0500
Message-ID: <20181120125731.19368-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index bf6519cf64bc..7e7ad3879c4e 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -253,18 +253,18 @@ static int init_powernv_pstates(void)
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
 		pr_warn("ibm,pstate-min node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
 		pr_warn("ibm,pstate-max node not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-nominal",
 				 &pstate_nominal)) {
 		pr_warn("ibm,pstate-nominal not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (of_property_read_u32(power_mgt, "ibm,pstate-ultra-turbo",
@@ -293,14 +293,14 @@ static int init_powernv_pstates(void)
 	pstate_ids = of_get_property(power_mgt, "ibm,pstate-ids", &len_ids);
 	if (!pstate_ids) {
 		pr_warn("ibm,pstate-ids not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	pstate_freqs = of_get_property(power_mgt, "ibm,pstate-frequencies-mhz",
 				      &len_freqs);
 	if (!pstate_freqs) {
 		pr_warn("ibm,pstate-frequencies-mhz not found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	if (len_ids != len_freqs) {
@@ -311,7 +311,7 @@ static int init_powernv_pstates(void)
 	nr_pstates = min(len_ids, len_freqs) / sizeof(u32);
 	if (!nr_pstates) {
 		pr_warn("No PStates found\n");
-		return -ENODEV;
+		goto out;
 	}
 
 	powernv_pstate_info.nr_pstates = nr_pstates;
@@ -352,7 +352,12 @@ static int init_powernv_pstates(void)
 
 	/* End of list marker entry */
 	powernv_freqs[i].frequency = CPUFREQ_TABLE_END;
+
+	of_node_put(power_mgt);
 	return 0;
+out:
+	of_node_put(power_mgt);
+	return -ENODEV;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0
