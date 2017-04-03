From: Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 2/3] cpuidle: powernv: Don't continually set thread priority in snooze_loop()
Date: Tue,  4 Apr 2017 07:54:13 +1000
Message-ID: <20170403215414.16951-2-anton@ozlabs.org>
References: <20170403215414.16951-1-anton@ozlabs.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:33905 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdDCVyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 17:54:31 -0400
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

The powerpc64 kernel exception handlers have preserved thread priorities
for a long time now, so there is no need to continually set it.

Just set it once on entry and once exit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9d9f164894eb..8c991c254b95 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -56,8 +56,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
+	HMT_very_low();
 	while (!need_resched()) {
-		HMT_very_low();
 		if (snooze_timeout_en && get_tb() > snooze_exit_time)
 			break;
 	}
-- 
2.11.0
