From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv4 PATCH 34/34] sched: Disable energy-unfriendly nohz kicks
Date: Tue, 12 May 2015 20:39:09 +0100
Message-ID: <1431459549-18343-35-git-send-email-morten.rasmussen@arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

With energy-aware scheduling enabled nohz_kick_needed() generates many
nohz idle-balance kicks which lead to nothing when multiple tasks get
packed on a single cpu to save energy. This causes unnecessary wake-ups
and hence wastes energy. Make these conditions depend on !energy_aware()
for now until the energy-aware nohz story gets sorted out.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8efeb1d..e6d32e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8382,12 +8382,13 @@ static inline bool nohz_kick_needed(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		return false;
 
-	if (rq->nr_running >= 2)
+	if (rq->nr_running >= 2 &&
+	    (!energy_aware() || cpu_overutilized(cpu)))
 		return true;
 
 	rcu_read_lock();
 	sd = rcu_dereference(per_cpu(sd_busy, cpu));
-	if (sd) {
+	if (sd && !energy_aware()) {
 		sgc = sd->groups->sgc;
 		nr_busy = atomic_read(&sgc->nr_busy_cpus);
 
-- 
1.9.1
