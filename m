From: Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very low thread priority
Date: Tue,  4 Apr 2017 07:54:12 +1000
Message-ID: <20170403215414.16951-1-anton@ozlabs.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34019 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdDCVy3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 17:54:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

The core of snooze_loop() continually bounces between low and very
low thread priority. Changing thread priorities is an expensive
operation that can negatively impact other threads on a core.

All CPUs that can run PowerNV support very low priority, so we can
avoid the change completely.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index cda8f62d555b..9d9f164894eb 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -57,7 +57,6 @@ static int snooze_loop(struct cpuidle_device *dev,
 	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
 	while (!need_resched()) {
-		HMT_low();
 		HMT_very_low();
 		if (snooze_timeout_en && get_tb() > snooze_exit_time)
 			break;
-- 
2.11.0
