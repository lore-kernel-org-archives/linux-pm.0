From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: cpu_cooling: Check memory allocation of power_table
Date: Fri, 20 Mar 2015 18:20:13 +0000
Message-ID: <1426875613-31612-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40988 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbCTSUd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 14:20:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>

We allocate the power_table in memory but we don't test whether the
allocation succeeded.  Return -ENOMEM if kcalloc() fails.

Fixes: e0128d8ab423 ("thermal: cpu_cooling: implement the power cooling device API")
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
This applies on top of the linus branch in Eduardo's repository

 drivers/thermal/cpu_cooling.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c4974144c787..3a01dfd5b29c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -329,6 +329,10 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	}
 
 	power_table = kcalloc(num_opps, sizeof(*power_table), GFP_KERNEL);
+	if (!power_table) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	for (freq = 0, i = 0;
 	     opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
-- 
1.9.1

