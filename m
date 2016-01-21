From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] cpuidle: fix fallback mechanism for suspend to idle in absence of enter_freeze
Date: Thu, 21 Jan 2016 11:19:29 +0000
Message-ID: <1453375169-14768-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50364 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759379AbcAULTh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Jan 2016 06:19:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Commit 51164251f5c3 ("sched / idle: Drop default_idle_call() fallback
from call_cpuidle()") made find_deepest_state() return non-negative
value and check all the states with index > 0. Also a result,
find_deepest_state() returns 0 even when enter_freeze callbacks are not
implemented and enter_freeze_proper is called which ends up crashing
the kernel.

This patch updates the check for index > 0 in cpuidle_enter_freeze and
cpuidle_idle_call(when idle_should_freeze is true) to restore the
suspend-to-idle functionality in absence of enter_freeze callback.

Fixes: 51164251f5c3 ("sched / idle: Drop default_idle_call() fallback from call_cpuidle()")
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/cpuidle.c | 2 +-
 kernel/sched/idle.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Hi Rafael,

I assume you prefer to retain find_deepest_state return non-negative
values, so I took this approach for fixing the bug. Do you think we
need to support enter_freeze_proper for index 0 ?

Regards,
Sudeep

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 046423b0c5ca..f996efc56605 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -153,7 +153,7 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
-	if (index >= 0)
+	if (index > 0)
 		enter_freeze_proper(drv, dev, index);

 	return index;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index de0e786b2667..544a7133cbd1 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -162,7 +162,7 @@ static void cpuidle_idle_call(void)
 	 */
 	if (idle_should_freeze()) {
 		entered_state = cpuidle_enter_freeze(drv, dev);
-		if (entered_state >= 0) {
+		if (entered_state > 0) {
 			local_irq_enable();
 			goto exit_idle;
 		}
--
1.9.1

