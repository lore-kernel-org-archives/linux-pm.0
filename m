From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv7 PATCH 08/10] sched: remove call of sched_avg_update from sched_rt_avg_update
Date: Mon, 22 Feb 2016 17:22:48 -0800
Message-ID: <1456190570-4475-9-git-send-email-smuckle@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

rt_avg is only used to scale the available CPU's capacity for CFS
tasks.  As the update of this scaling is done during periodic load
balance, we only have to ensure that sched_avg_update has been called
before any periodic load balancing. This requirement is already
fulfilled by __update_cpu_load so the call in sched_rt_avg_update,
which is part of the hotpath, is useless.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 kernel/sched/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 59747d8..3df21f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1498,7 +1498,6 @@ static inline void set_dl_cpu_capacity(int cpu, bool request,
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
-	sched_avg_update(rq);
 }
 #else
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-- 
2.4.10
