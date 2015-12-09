From: Steve Muckle <steve.muckle@linaro.org>
Subject: [RFCv6 PATCH 08/10] sched: remove call of sched_avg_update from sched_rt_avg_update
Date: Tue,  8 Dec 2015 22:19:29 -0800
Message-ID: <1449641971-20827-9-git-send-email-smuckle@linaro.org>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36086 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbLIGTs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 01:19:48 -0500
Received: by pacdm15 with SMTP id dm15so24607879pac.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2015 22:19:48 -0800 (PST)
In-Reply-To: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

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
index 90d5df6..08858d1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1497,7 +1497,6 @@ static inline void set_dl_cpu_capacity(int cpu, bool request,
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta)
 {
 	rq->rt_avg += rt_delta * arch_scale_freq_capacity(NULL, cpu_of(rq));
-	sched_avg_update(rq);
 }
 #else
 static inline void sched_rt_avg_update(struct rq *rq, u64 rt_delta) { }
-- 
2.4.10

