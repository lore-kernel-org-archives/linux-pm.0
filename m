Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0784CDDD7;
	Thu, 17 Sep 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659695; cv=none; b=NclJFUTtyzJUVoY88UpYCd2yNVSghDk+blGDGvCG1it7AJLePp2M/rpLvG7J1dlu183/CC9AKfbhcxLrQodaj6MpmMU3E+Nyn2DRW6PXMt1cXjsQrPiiAYkLslDuAPSOi81kRdE9RCRzt/C/Mpgr4wuj6Ew9fQh0wVtiZPWk3Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659695; c=relaxed/simple;
	bh=n5xnCq7ZNMxidPIgupP4wmabPhpKy7d+Hd+5dKBA3NA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aK/hN+PWtErs3uPbq6ZMKxhP2imxAiPw+K3uK2P09CkuJ9kVFB7SusP4WzLweXExTiyt5u08H/eX93AnYSTvuJPQnPSzOd4+eV5K/K4GR2bZ/ZYBWCNiKOUcXgI/gVzn9I6BWflCX272pjsNNXA8dWki5weLjgFrJtQYlEW3R6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MIHKFz6Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MIHKFz6Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B844A1AED;
	Thu, 17 Sep 2026 08:41:22 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61AB73F7B4;
	Thu, 17 Sep 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789659686; bh=n5xnCq7ZNMxidPIgupP4wmabPhpKy7d+Hd+5dKBA3NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIHKFz6Y5OhrW4pAPau+BL4ZHg1YCaSE0lqSC1NaZz/lcQjaRLIBq4PgD9fk5W5IJ
	 rxJHkNUNca4mpBlvDWaH7NYCtCRboWZKHtH+W92sViHFDZ6qcYrVFgY2iakdwViIVo
	 nMF8W/B3yuN6GfX9UI2W6Ha1orERvVhzOBW3LaJs=
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Elif Topuz <elif.topuz@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	Christoph Lameter <cl@gentwo.org>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2 2/2] sched/fair: Randomize equally shallow slow-path candidates
Date: Thu, 17 Sep 2026 16:39:15 +0100
Message-Id: <20260917153915.1563875-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917153915.1563875-1-christian.loehle@arm.com>
References: <20260917153915.1563875-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
slow-path selectors can choose the same CPU before either task is enqueued.

Use reservoir sampling for equal exit latencies, resetting the candidate
count when a shallower candidate appears. Use the per-CPU scheduler PRNG
and reciprocal_scale() to avoid variable division or a second scan.

Use a u64 latency key with U64_MAX for unpublished states. Published
states take precedence; when none are found, sample among the idle CPUs
without a published state.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/fair.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff5793bddc35..810343f40316 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -24,6 +24,7 @@
 #include <linux/mmap_lock.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/jiffies.h>
+#include <linux/math.h>
 #include <linux/mm_api.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer.h>
@@ -8458,7 +8459,8 @@ static int
 sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
 {
 	unsigned long load, min_load = ULONG_MAX;
-	unsigned int min_exit_latency = UINT_MAX;
+	u64 min_exit_latency = U64_MAX;
+	unsigned int nr_candidates = 0;
 	int least_loaded_cpu = this_cpu;
 	int shallowest_idle_cpu = -1;
 	int i;
@@ -8479,12 +8481,16 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 
 		if (available_idle_cpu(i)) {
 			struct cpuidle_state *idle = idle_get_state(rq);
-			if (idle && idle->exit_latency < min_exit_latency) {
-				min_exit_latency = idle->exit_latency;
-				shallowest_idle_cpu = i;
-			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
-				   shallowest_idle_cpu == -1) {
+			u64 exit_latency = idle ? idle->exit_latency : U64_MAX;
+
+			if (shallowest_idle_cpu == -1 || exit_latency < min_exit_latency) {
+				min_exit_latency = exit_latency;
 				shallowest_idle_cpu = i;
+				nr_candidates = 1;
+			} else if (exit_latency == min_exit_latency) {
+				nr_candidates++;
+				if (!reciprocal_scale(sched_rng(), nr_candidates))
+					shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
 			load = cpu_load(cpu_rq(i));
-- 
2.34.1

