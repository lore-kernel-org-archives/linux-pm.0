From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] cpuidle: delay enabling interrupts until all coupled CPUs leave idle
Date: Thu, 6 Mar 2014 11:02:01 +0000
Message-ID: <1394103721-32616-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.115]:52371 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaCFLCn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Mar 2014 06:02:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

As described by a comment at the end of cpuidle_enter_state_coupled it
can be inefficient for coupled idle states to return with IRQs enabled
since they may proceed to service an interrupt instead of clearing the
coupled idle state. Until they have finished & cleared the idle state
all CPUs coupled with them will spin rather than being able to enter a
safe idle state.

Commits e1689795a784 "cpuidle: Add common time keeping and irq
enabling" and 554c06ba3ee2 "cpuidle: remove en_core_tk_irqen flag" led
to the cpuidle_enter_state enabling interrupts for all idle states,
including coupled ones, making this inefficiency unavoidable by drivers
& the local_irq_enable near the end of cpuidle_enter_state_coupled
redundant. This patch avoids enabling interrupts in cpuidle_enter_state
after a coupled state has been entered, allowing them to remain disabled
until all coupled CPUs have exited the idle state and
cpuidle_enter_state_coupled re-enables them.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a55e68f..366e684 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -85,7 +85,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	time_end = ktime_get();
 
-	local_irq_enable();
+	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
+		local_irq_enable();
 
 	diff = ktime_to_us(ktime_sub(time_end, time_start));
 	if (diff > INT_MAX)
-- 
1.8.5.3

