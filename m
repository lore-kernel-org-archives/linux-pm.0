From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/3] sched: fair: Fix wrong idle timestamp usage
Date: Wed, 15 Apr 2015 12:00:24 +0200
Message-ID: <1429092024-20498-3-git-send-email-daniel.lezcano@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36456 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbbDOKAj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 06:00:39 -0400
Received: by wgsk9 with SMTP id k9so40807282wgs.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2015 03:00:37 -0700 (PDT)
In-Reply-To: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, Ingo Molnar <mingo@redhat.com>

The find_idlest_cpu is assuming the rq->idle_stamp information reflects when
the cpu entered the idle state. This is wrong as the cpu may exit and enter
the idle state several times without the rq->idle_stamp being updated.

We have two informations here:

 * rq->idle_stamp gives when the idle task has been scheduled
 * idle->idle_stamp gives when the cpu entered the idle state

The patch fixes that by using the latter information and fallbacks to
the rq's timestamp when the idle state is not accessible

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46855d0..b44f1ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4704,21 +4704,35 @@ find_idlest_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 		if (idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
-			if (idle && idle->exit_latency < min_exit_latency) {
-				/*
-				 * We give priority to a CPU whose idle state
-				 * has the smallest exit latency irrespective
-				 * of any idle timestamp.
-				 */
-				min_exit_latency = idle->exit_latency;
-				latest_idle_timestamp = rq->idle_stamp;
-				shallowest_idle_cpu = i;
-			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
-				   rq->idle_stamp > latest_idle_timestamp) {
+
+			if (idle) {
+				if (idle->exit_latency < min_exit_latency) {
+					/*
+					 * We give priority to a CPU
+					 * whose idle state has the
+					 * smallest exit latency
+					 * irrespective of any idle
+					 * timestamp.
+					 */
+					min_exit_latency = idle->exit_latency;
+					latest_idle_timestamp = idle->idle_stamp;
+					shallowest_idle_cpu = i;
+				} else if (idle->exit_latency == min_exit_latency &&
+					   idle->idle_stamp > latest_idle_timestamp) {
+					/*
+					 * If the CPU is in the same
+					 * idle state, choose the more
+					 * recent one as it might have
+					 * a warmer cache
+					 */
+					latest_idle_timestamp = idle->idle_stamp;
+					shallowest_idle_cpu = i;
+				}
+			} else if (rq->idle_stamp > latest_idle_timestamp) {
 				/*
-				 * If equal or no active idle state, then
-				 * the most recently idled CPU might have
-				 * a warmer cache.
+				 * If no active idle state, then the
+				 * most recent idled CPU might have a
+				 * warmer cache
 				 */
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
-- 
1.9.1

