From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 11/21] cpuidle: replace multiline statements with single line in cpuidle_idle_call()
Date: Sun, 22 Sep 2013 06:51:03 +0530
Message-ID: <c79ae2ab0a5a3946fcd0e68c855742f06f695f0f.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379779777.git.viresh.kumar@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Few statements in cpuidle_idle_call() are broken into multiple lines, whereas
they can actually come in a single line. Convert those to single line.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ed67e3c..43d5836 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -145,8 +145,7 @@ int cpuidle_idle_call(void)
 	broadcast = drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP;
 
 	if (broadcast)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
-				   &dev->cpu);
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
 
 	if (cpuidle_state_is_coupled(dev, drv, next_state))
 		entered_state = cpuidle_enter_state_coupled(dev, drv,
@@ -155,8 +154,7 @@ int cpuidle_idle_call(void)
 		entered_state = cpuidle_enter_state(dev, drv, next_state);
 
 	if (broadcast)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
-				   &dev->cpu);
+		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
 
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
-- 
1.7.12.rc2.18.g61b472e
