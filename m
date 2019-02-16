From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: powernv: fix missing check of return value in init_powernv_pstates()
Date: Sat, 16 Feb 2019 12:06:23 -0500
Message-ID: <20190216170623.12634-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

kmalloc() could fail, so insert a check of its return value. And
if it fails, returns -ENOMEM.

And remove (struct pstate_idx_revmap_data *) to fix coccinelle WARNING
by the way.

WARNING: casting value returned by memory allocation function to (struct
pstate_idx_revmap_data *) is useless.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 7e7ad3879c4e..d2230812fa4b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -244,6 +244,7 @@ static int init_powernv_pstates(void)
 	u32 len_ids, len_freqs;
 	u32 pstate_min, pstate_max, pstate_nominal;
 	u32 pstate_turbo, pstate_ultra_turbo;
+	int rc = -ENODEV;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
@@ -327,8 +328,11 @@ static int init_powernv_pstates(void)
 		powernv_freqs[i].frequency = freq * 1000; /* kHz */
 		powernv_freqs[i].driver_data = id & 0xFF;
 
-		revmap_data = (struct pstate_idx_revmap_data *)
-			      kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		revmap_data = kmalloc(sizeof(*revmap_data), GFP_KERNEL);
+		if (!revmap_data) {
+			rc = -ENOMEM;
+			goto out;
+		}
 
 		revmap_data->pstate_id = id & 0xFF;
 		revmap_data->cpufreq_table_idx = i;
@@ -357,7 +361,7 @@ static int init_powernv_pstates(void)
 	return 0;
 out:
 	of_node_put(power_mgt);
-	return -ENODEV;
+	return rc;
 }
 
 /* Returns the CPU frequency corresponding to the pstate_id. */
-- 
2.17.0
