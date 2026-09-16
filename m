Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4584BD0F2;
	Wed, 16 Sep 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552918; cv=none; b=YAlTfiA25+Pf3fKVi/LdLrUYDZBDo0+3HLIIzOpKLbt9tlLqnwqapb1y+XWZO8dWsizP3E6MXIkg53aCsBPegEx6FyCQFJZj5BViCFrv7QCG/jFIt8/oSvXUv/o+nqD6s+Vto1ZkQcdfHro7z2R9gWrcrEBnSJEupK2unCXwu5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552918; c=relaxed/simple;
	bh=HVVfzed720/rXRspNBfPrMK4Ps/7gqBjL4uqDIo/5Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pz1jZgVcLfMBZ8E8pSAtt/gwnPfarX7/nq767LfFWqH+i+32/pvJOn2h396ig867xA/T9g+pil1otFF4Avgci36x42nL0giG69jYDd/ogckX8VCTZDmOvc4sRvPK/Q8c7IBRXotYUZWD5uO1zbrBDp3FK8MmVj9jlMIJxI9USwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ie2R/szZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ie2R/szZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA6A1176A;
	Wed, 16 Sep 2026 03:01:26 -0700 (PDT)
Received: from e127648.carmbridge.arm.com (unknown [10.0.129.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A384E3F86F;
	Wed, 16 Sep 2026 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789552890; bh=HVVfzed720/rXRspNBfPrMK4Ps/7gqBjL4uqDIo/5Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ie2R/szZG9eP9YOERTdXZlTlVdwz/i8uQGEfkM5W28JrcqNOnK68OewUlsmfNOWa4
	 aPBK+eXibzbo4z9HDDY4gE/+XAXKbaNdaGdnPyM6V/41PLt6KmcbsiA+62PGHINyg6
	 Ur6hZcMFZuwAw0I2D+l+RJ8Uqc3v39VnwyongDW8=
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
Subject: [PATCH 1/2] sched/fair: Drop idle recency from slow-path CPU selection
Date: Wed, 16 Sep 2026 11:01:15 +0100
Message-Id: <20260916100116.701206-2-christian.loehle@arm.com>
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

The slow-path CPU picker favours the most recently idle CPU as a proxy
for cache warmth.

A more recent idle stamp may make ongoing entry more likely. Among CPUs
with equal advertised exit latency, this may favour the one with the
highest wakeup cost: if entry cannot be aborted, it must finish entry and
then exit, while an already-resident CPU only needs to exit. The same
advertised worst-case latency covers both cases.

idle_stamp does not track the current CPUIdle entry, so an older
scheduler-idle CPU may also be re-entering.

A recent scheduler-idle transition may also mark a short gap in recurring
task activity, so the CPU may soon be busy again.

Drop the timestamp tie-break, retaining the first idle candidate unless
a lower advertised exit latency is found.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
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
@@ -8480,23 +8479,11 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 
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
