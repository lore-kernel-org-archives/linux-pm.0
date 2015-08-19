From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [RFC PATCH 06/14] sched/cpufreq_sched: modify pcpu_capacity handling
Date: Wed, 19 Aug 2015 19:47:16 +0100
Message-ID: <1440010044-3402-7-git-send-email-patrick.bellasi@arm.com>
References: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53360 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbbHSSru (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Aug 2015 14:47:50 -0400
In-Reply-To: <1440010044-3402-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>

From: Juri Lelli <juri.lelli@arm.com>

Use the cpu argument of cpufreq_sched_set_cap() to handle per_cpu writes,
as the thing can be called remotely (e.g., from load balacing code).

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Michael Turquette <mturquette@baylibre.com>
---
 kernel/sched/cpufreq_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
index e6b4a22..27f2cec 100644
--- a/kernel/sched/cpufreq_sched.c
+++ b/kernel/sched/cpufreq_sched.c
@@ -151,7 +151,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
 	unsigned long capacity_max = 0;
 
 	/* update per-cpu capacity request */
-	__this_cpu_write(pcpu_capacity, capacity);
+	per_cpu(pcpu_capacity, cpu) = capacity;
 
 	policy = cpufreq_cpu_get(cpu);
 	if (IS_ERR_OR_NULL(policy)) {
-- 
2.5.0

