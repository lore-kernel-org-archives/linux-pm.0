From: Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 3/3] cpuidle: powernv: Avoid a branch in the core snooze_loop() loop
Date: Tue,  4 Apr 2017 07:54:14 +1000
Message-ID: <20170403215414.16951-3-anton@ozlabs.org>
References: <20170403215414.16951-1-anton@ozlabs.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:47869 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdDCVye (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 3 Apr 2017 17:54:34 -0400
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

When in the snooze_loop() we want to take up the least amount of
resources. On my version of gcc (6.3), we end up with an extra
branch because it predicts snooze_timeout_en to be false, whereas it
is almost always true.

Use likely() to avoid the branch and be a little nicer to the
other non idle threads on the core.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 8c991c254b95..251a60bfa8ee 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -58,7 +58,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	ppc64_runlatch_off();
 	HMT_very_low();
 	while (!need_resched()) {
-		if (snooze_timeout_en && get_tb() > snooze_exit_time)
+		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
 			break;
 	}
 
-- 
2.11.0
