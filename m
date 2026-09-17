Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB874D4879;
	Thu, 17 Sep 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659694; cv=none; b=X3w9VMH7XHg5FInlptfTOesweMdZpzDfsAjXMeWvId6Ojpsd5ebcue/is4ljNspdHZMvFcSZ8aQRNZ+t+NVxRp7OHTAhrTwAkDyiBc/FYEAgM67/BBbHRmx8mQhDlvipDW5OG3l4r/FoWdcC4DEC1wSde6lTAR58pbykYZ6mMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659694; c=relaxed/simple;
	bh=ulDHPGJnezoxQS1STH+QyuV1/zf3Ld6oZMvKyAKAl+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bKYtN+96qot3AbmNpn7X/zwq7L9MxBNhUYsVPfs1O4AQAhEh4kvK/ci6LjkWzO9PSOrM/94db19L4TCLhUsOJ2qe1ShpVbJAI9H2MRRAiuuHLBY0aG1QyZ/nVLSb91CRhC1sZyPuwJh2wBGef59CyVMSK5DE3/8xg88EzGb+3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=bJVhIIEL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="bJVhIIEL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607B81596;
	Thu, 17 Sep 2026 08:41:18 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.50.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5CF73F7B4;
	Thu, 17 Sep 2026 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789659681; bh=ulDHPGJnezoxQS1STH+QyuV1/zf3Ld6oZMvKyAKAl+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJVhIIELC7dSKDJ7SkfDJ7OVUSpcVL3pcvqal3AlWe60wJt3vNGd0NMv5GoIaurXr
	 USD3Hyruf6cnLbmgXNRjMx/0K5vyQBwpugdqlZMuSk6fBFJUiGg5lMKTXDYVAeL6o9
	 55lPO0aggEDTxLeje87EKw2BNW8ZNONuESXrrCDY=
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
Subject: [PATCH v2 1/2] sched/fair: Drop idle recency from slow-path CPU selection
Date: Thu, 17 Sep 2026 16:39:14 +0100
Message-Id: <20260917153915.1563875-2-christian.loehle@arm.com>
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

The slow-path CPU picker favours the most recently idle CPU as a proxy
for cache warmth.

A more recent idle stamp may make ongoing entry more likely. If entry
cannot be aborted, that CPU must finish entry and then exit, potentially
paying more than an already-resident CPU with the same advertised exit
latency. The advertised worst-case latency covers both cases. idle_stamp
does not timestamp the current CPUIdle entry, so this is only a heuristic.

A recent scheduler-idle transition may also mark a short gap in recurring
task activity, making the CPU likely to be busy again soon.

Drop the timestamp tie-break and retain the first candidate unless a
lower advertised exit latency is found.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7455a83a6a99..ff5793bddc35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8459,7 +8459,6 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
-	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
 	int shallowest_idle_cpu = -1;
 	int i;
@@ -8481,22 +8480,10 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 		if (available_idle_cpu(i)) {
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
-				/*
-				 * We give priority to a CPU whose idle state
-				 * has the smallest exit latency irrespective
-				 * of any idle timestamp.
-				 */
 				min_exit_latency = idle->exit_latency;
-				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			} else if ((!idle || idle->exit_latency == min_exit_latency) &&
-				   rq->idle_stamp > latest_idle_timestamp) {
-				/*
-				 * If equal or no active idle state, then
-				 * the most recently idled CPU might have
-				 * a warmer cache.
-				 */
-				latest_idle_timestamp = rq->idle_stamp;
+				   shallowest_idle_cpu == -1) {
 				shallowest_idle_cpu = i;
 			}
 		} else if (shallowest_idle_cpu == -1) {
-- 
2.34.1

