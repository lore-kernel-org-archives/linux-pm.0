From: Sandeep Tripathy <sandeep.tripathy@linaro.org>
Subject: [PATCH] cpuidle/idle: move idle traces to cpuidle_enter_state
Date: Wed,  2 Jul 2014 15:00:58 +0530
Message-ID: <1404293458-9799-1-git-send-email-sandeep.tripathy@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47291 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655AbaGBJbh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jul 2014 05:31:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so12181747pac.19
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2014 02:31:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: rostedt@goodmis.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Sandeep Tripathy <sandeep.tripathy@linaro.org>

 idle_exit event is the first event after a core exits
idle state. So this should be traced before local irq
is ebabled. Likewise idle_entry is the last event before
a core enters idle state. This will ease visualising the
cpu idle state from kernel traces.

Signed-off-by: Sandeep Tripathy <sandeep.tripathy@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 3 +++
 kernel/sched/idle.c       | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 8236746..97680d0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -99,12 +99,15 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	ktime_t time_start, time_end;
 	s64 diff;
 
+	trace_cpu_idle_rcuidle(index, dev->cpu);
 	time_start = ktime_get();
 
 	entered_state = target_state->enter(dev, drv, index);
 
 	time_end = ktime_get();
 
+	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
+
 	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
 		local_irq_enable();
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8f4390a..07c446a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -141,7 +141,6 @@ static int cpuidle_idle_call(void)
 					&dev->cpu);
 
 			if (!ret) {
-				trace_cpu_idle_rcuidle(next_state, dev->cpu);
 
 				/*
 				 * Enter the idle state previously
@@ -154,9 +153,6 @@ static int cpuidle_idle_call(void)
 				entered_state = cpuidle_enter(drv, dev,
 							      next_state);
 
-				trace_cpu_idle_rcuidle(PWR_EVENT_EXIT,
-						       dev->cpu);
-
 				if (broadcast)
 					clockevents_notify(
 						CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
-- 
1.9.1

