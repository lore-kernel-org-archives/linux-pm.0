Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED37476CDA;
	Wed, 16 Sep 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552912; cv=none; b=XtY8xzH1QflwryLuD9IRVZyKQDO0ow1JUfoh+uL2cxMX+x54H8Ghx9gjJfehEOEiOFmcIMVm6pEHaQC358v63jFodfOmTNvCkWlZJ/bWd9MIxbtEHSU5fM9XVLscvwih3h3dzN/zRUxCPU5zaOjsyigNLlDt+6+XcxTibyY4D8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552912; c=relaxed/simple;
	bh=+U4NUhzKtF3iaqxkjxI+IFGed8Vvw8nCA5q4a9gp7Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=koUKPdBbACf4BPC7cyz+xzfe/qvDyPCVx4EnE4UX8paC3ywuPAUzIErdr7AlYA13gvqH0ubCZbEmNZoANGUPKN0I005ZlyJJl8oYQRcaN07UEXZ1+bOFj9xO5JDmTs6j/Wx7QqmX0ovPZ6SosHA4up/fjFgzW/sV0+B0+zNN0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q4VMMO6a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q4VMMO6a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7D219F0;
	Wed, 16 Sep 2026 03:01:29 -0700 (PDT)
Received: from e127648.carmbridge.arm.com (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A253C3F86F;
	Wed, 16 Sep 2026 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789552893; bh=+U4NUhzKtF3iaqxkjxI+IFGed8Vvw8nCA5q4a9gp7Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4VMMO6anAb22G15ijiEgbyXYFZ1L1UIkumiSX+dZ6JZKz5QmxwE2I1xqbxGvlqjk
	 kSKs19t85UI03ZLWHuIjta321yW42GC4oS2tb5zFcOYgmhxaateCZ7BMvX5W+X5deE
	 3b2/crnShg87pxtwuKizbGf85SQXSalcAbnL9mvE=
From: Christian Loehle <christian.loehle@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Elif Topuz <elif.topuz@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shubhang Kaushik <sh@gentwo.org>,
	Christoph Lameter <cl@gentwo.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path candidates
Date: Wed, 16 Sep 2026 11:01:16 +0100
Message-Id: <20260916100116.701206-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916100116.701206-1-christian.loehle@arm.com>
References: <20260916100116.701206-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Picking the first eligible idle CPU leaves a scan-order bias. Concurrent
slow-path selectors can choose the same CPU before either task is enqueued.

Use reservoir sampling in the tie branch, resetting the candidate count
when a lower advertised exit latency is found. Use the per-CPU scheduler
PRNG and reciprocal_scale() to avoid variable division or a second scan.

This reduces deterministic convergence without reserving the chosen CPU.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff5793bddc35..6836a8364440 100644
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
@@ -8459,6 +8460,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
+	unsigned int nr_candidates = 0;
 	int least_loaded_cpu = this_cpu;
 	int shallowest_idle_cpu = -1;
 	int i;
@@ -8482,9 +8484,12 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 			if (idle && idle->exit_latency < min_exit_latency) {
 				min_exit_latency = idle->exit_latency;
 				shallowest_idle_cpu = i;
+				nr_candidates = 1;
-			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
-				   shallowest_idle_cpu == -1) {
-				shallowest_idle_cpu = i;
+			} else if (!idle || idle->exit_latency == min_exit_latency) {
+				nr_candidates++;
+				if (nr_candidates == 1 ||
+				    !reciprocal_scale(sched_rng(), nr_candidates))
+					shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
 			load = cpu_load(cpu_rq(i));
-- 
2.34.1
