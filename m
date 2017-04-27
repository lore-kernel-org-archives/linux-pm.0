From: "Li, Fei" <fei.li@intel.com>
Subject: [PATCH V2] cpuidle: check dev before usage in
 cpuidle_use_deepest_state
Date: Thu, 27 Apr 2017 01:47:25 +0000
Message-ID: <BEC9F67575FA1E429CA7CF5AE9BE363432A457C3@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:9971 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbdD0Brf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Apr 2017 21:47:35 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shi, FengX" <fengx.shi@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

In case of there is no cpuidle devices registered, dev will be null, and
panic will be triggered like below;
In this patch, add checking of dev before usage, like that done in
cpuidle_idle_call.

Panic without fix:
[  184.961328] BUG: unable to handle kernel NULL pointer dereference at
  (null)
[  184.961328] IP: cpuidle_use_deepest_state+0x30/0x60
...
[  184.961328]  play_idle+0x8d/0x210
[  184.961328]  ? __schedule+0x359/0x8e0
[  184.961328]  ? _raw_spin_unlock_irqrestore+0x28/0x50
[  184.961328]  ? kthread_queue_delayed_work+0x41/0x80
[  184.961328]  clamp_idle_injection_func+0x64/0x1e0

Fixes: bb8313b603eb8 ("cpuidle: Allow enforcing deepest idle state selection")
Signed-off-by: Li, Fei <fei.li@intel.com>
Tested-by: Shi, Feng <fengx.shi@intel.com>
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 548b90b..2706be7 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -111,7 +111,8 @@ void cpuidle_use_deepest_state(bool enable)
 
 	preempt_disable();
 	dev = cpuidle_get_device();
-	dev->use_deepest_state = enable;
+	if (dev)
+		dev->use_deepest_state = enable;
 	preempt_enable();
 }
 
-- 
1.9.1

Best Regards,
Fei
