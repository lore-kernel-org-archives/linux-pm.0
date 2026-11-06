Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978404;
	b=ReXaF510cTrb2D26VfWV2dQIte9LhrmvkTPEumuE90AGHZWjHHffY2Y06DNZfS5nFdUn
	 lEG5ur+D8Aiz9blv2V3Ar6ISBU1Xk3PIaA5FNXj3ZibdGUeZDzro0OOQ6rLhuCZzkO4s0
	 wcEWzuDOAZZkvsywfYfwaKAXbIWn9Xzi4alsIUQ4a1OzS4alifvUMNBnkOlwwegyn8qKg
	 APwhHUeBh5chqrepZc7CCzvQNRd468TMCmgQvHUWTAdcctiFfz/asox+VjFpjfi5n7okB
	 OrYAteuCmHSDBCcYc80I98UbQfMzmvtXcT9VyVT4ZXY+ycnTCssh9HHxrKPF9hduWtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
	b=nv1j7FedBEnICSxrJJgjK079iguGUh9zAFbN1TkSrFUeyEvV85aVAyVOoHVKv/Qs4/rk
	 SSHHXffGUMnWzbukMw+7XGPOt6iXXHH7YHaa9uoaXL8hU2MTtO698vD+EJ5pR8HDWDVJz
	 qebyqTdYcSMA/etqm8gRKgZnyclkm7n/ppC/+8dj7HE27gxKOxPVTj+CRHzx9haFNU55K
	 37oT64hon1BUj1AigVddTS6s2KkUr2z/Bxm2I/qu6yQ6ToPsKSOV70R1B/w5Uug79Vx2Y
	 wFS7kvTmrT8OWKvDBv4/5Y/NpN6z0D7en21ENWeksICO3Yd75he5/OZ7WDGQDTtO8ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i1WasBA1;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36858606A335
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36858606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i1WasBA1
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so8033565e9.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978401; x=1794583201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
        b=i1WasBA1F8IdFNhWlR+IMa7LWgkopw9CDfif5WVvvAQKFyekauGD+r83mrBn+5GlZo
         2q8L+3y46KKzp9rQPV5Dsz0mqpVhse1ezxCR9DjjE5Sq3/mdPwY8X/Sj2EvTTT5Qk7D8
         tbEofTdoC347mEaYnKii9UfOaJ3Qsu7npWLZpeibfxI4JulP85ahQN2x85hJVOc5xqQJ
         As4CYj4ihevSXyctUXDKHL9lvRJomMovq5d1c5ZvOAb/TJq3VX4NQ08M2YdFH+kdtq4n
         BN518jPpwbj5V+Z4TCmC4QqAdwn+CPSq1GhW+KjDi5z5P899w9fWWEcQ0PYozjAZDbaD
         tZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978401; x=1794583201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNvYaN9+IditNDhq23YRJI+wa1XYmfweeiUK+nE25zk=;
        b=futd5v4NMowu5EbKcrkc1SxeIchYkPrZ5XAmgKbM+sWLMEE0VRDLhEbvThOmAWLea9
         NNs1RYl0WNcKLhF341L2G6AceRyGMTsXgE/d07PJHAlWnWpbwHQPIfLnLsZ4IYYCGz0Q
         JOqEUMJtG/IP1QwXmuKcm2rc+9NJrtCRKSRQwr3VGo/0Ce4M047lwhJE06nv6ewLpubh
         xetJ529NJYHKoKUxIEpRGC8ZuloRo7riSGKF9uwR1SvejEdAnIqJnrpf64+HTCBYS5Kh
         bJjt06J6EQgDfOsoyyXCHf1WRHpkqPbk/jlb0xibaspHXy7Is8SWF1yUQyHtoIo6mrXF
         xYuw==
X-Forwarded-Encrypted: i=1; AL+hErG82pap1GdP6NHUo6r5Hxtc3NJZ2Jy0pjsMsZpXt+jpivaMLSqOR19c+7Hxkkyb5LripJLDaNx56A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cEnp4EtsuoAK+nsbRb9c0EdbnxAx3SRZP9iZ58t5Yt5kQf9Ob
	YAfHYB4mowCvjONvo0t5FG9fZoFjuoiSBdID7J6lrtpMDg9Qg7OrhZ1gUuVYzQ1/5h8=
X-Gm-Gg: AYBFou0+iqwfncHGFff3i/Pru6oA9xGLud5fZK+bNtv1rQAWe/EAm4FlZCb2gp+Sskm
	okxHp5kPZNJdfyoT61BLYP2GU2OHav8E/fYk8FhgN//LtQs0bqfyphTpFTrPyNXiQu3MtIRBJO0
	NwGPezD8QmasQrMwo6GO7cbjmjQPtXaDYuaIc5Dfwq09DvT0dCpEi1JVUBXCfR/X2ROfdnKaQQU
	4mO1HbQkI7rQYyJ9bSVT4CM1zqAS2gdwmZ25q7Z7SouKRcMW0k4DWRDrf2EGyP1/SFu0ovZMpWJ
	xhhf57mOr3C0D84+WBTjofMDnhJuIz7XcIfObyVeVeBRTqBstzAsr5+zJ549/ainB30iSVtZDSX
	7zPdjuQUaaVLYD66KkDO5xJXjYsOTGz615nIp62krQT/7w2UFRp7t4/UQe/mGcGat14+6H27lA7
	sCYMcez46CZ5QfOy3j6UCTGLPI6BEX+7E5iK28695hpdY/FEqa+VOcsF0XGr2oD7iG7O5SuGnrQ
	ETHljcFh9kqnw/r3jn3iKnzN3FYK/ZNstRIBzk39bx0MOEP8xjqcqJ/m3b9806EqAExkQpi6OkI
	/TWq3gK3yJiYD2sJuo8T2X427zpPQ4NExhSgkufjCaVPcrY=
X-Received: by 2002:a05:6000:2203:b0:48e:2a6c:153b with SMTP id ffacd0b85a97d-493cb334277mr304843f8f.35.1793978401501;
        Fri, 06 Nov 2026 07:20:01 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:00 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/20 v3] sched/fair: Prepare select_task_rq_fair() to be called for new cases
Date: Fri,  6 Nov 2026 16:19:34 +0100
Message-ID: <20261106151947.3991524-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update select_task_rq_fair() to be called outside of the 3 current cases:
- wake up
- exec
- fork

We wants to select a rq in some new cases like pushing a runnable task on a
better CPU than the local one. In such case, it's not a wakeup , nor an
exec nor a fork. We ensure to not distrub these cases but still go through
EAS and fast-path.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 75 +++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 039dce244aaa..8f99c8bf1a80 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6170,6 +6170,18 @@ static void sync_entity_load_avg(struct sched_entity *se)
 	__update_load_avg_blocked_se(last_update_time, se);
 }
 
+/*
+ * Synchronize task load avg of dequeued entity without locking
+ * the previous rq.
+ */
+static void sync_task_load_avg(struct task_struct *p)
+{
+	if (task_on_rq_queued(p))
+		return;
+
+	sync_entity_load_avg(&p->se);
+}
+
 /*
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
@@ -8802,7 +8814,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 	 * prev_cpu's last_update_time.
 	 */
 	if (!(sd_flag & SD_BALANCE_FORK))
-		sync_entity_load_avg(&p->se);
+		sync_task_load_avg(p);
 
 	while (sd) {
 		struct sched_group *group;
@@ -9318,7 +9330,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * that the task fits with CPU's capacity.
 	 */
 	if (sched_asym_cpucap_active()) {
-		sync_entity_load_avg(&p->se);
+		sync_task_load_avg(p);
 		task_util = task_util_est(p);
 		util_min = uclamp_eff_value(p, UCLAMP_MIN);
 		util_max = uclamp_eff_value(p, UCLAMP_MAX);
@@ -9912,7 +9924,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	target = prev_cpu;
 
-	sync_entity_load_avg(&p->se);
+	sync_task_load_avg(p);
 	if (!task_util_est(p) && p_util_min == 0)
 		return target;
 
@@ -10060,46 +10072,55 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 }
 
 /*
- * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
- * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
+ * select_task_rq_fair: Select a target runqueue for the task.
+ * There are 2 ways to select the target runqueue:
+ * - The fast path which only looks for an idle CPU in the LLC or the smallest
+ *   asymmetric domain (i.e. the lowest domain with all compute capacities).
+ * - The slow path which looks for the idlest CPU in the highest domain with
+ *   the relevant SD flag set.
  *
- * Balances load by selecting the idlest CPU in the idlest group, or under
- * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
+ * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU and no
+ * flag (Push) uses the fast path.
  *
- * Returns the target CPU number.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
+	int new_cpu, cpu = smp_processor_id();
 	struct sched_domain *tmp, *sd = NULL;
-	int cpu = smp_processor_id();
-	int new_cpu = prev_cpu;
-	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
-	int sd_flag = wake_flags & 0xF;
+	int sd_flag = select_flags & 0xF;
+	int want_affine = 0;
 
 	/*
-	 * required for stable ->cpus_allowed
+	 * Required for stable ->cpus_allowed
 	 */
 	lockdep_assert_held(&p->pi_lock);
-	if (wake_flags & WF_TTWU) {
+
+	if (select_flags & WF_TTWU) {
 		record_wakee(p);
 
-		if ((wake_flags & WF_CURRENT_CPU) &&
+		if ((select_flags & WF_CURRENT_CPU) &&
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
+	}
 
-		if (!is_rd_overutilized(this_rq()->rd)) {
-			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
-			if (new_cpu >= 0)
-				return new_cpu;
-			new_cpu = prev_cpu;
-		}
+	/*
+	 * We don't want EAS to be called for exec or fork but it should be
+	 * called for any other case such as wake up or push callback.
+	 */
+	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
+		new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+		if (new_cpu >= 0)
+			return new_cpu;
+	}
 
+	if (select_flags & WF_TTWU)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
-	}
+
+	new_cpu = prev_cpu;
 
 	for_each_domain(cpu, tmp) {
 		/*
@@ -10133,8 +10154,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 
 	/* Fast path */
-	if (wake_flags & WF_TTWU)
-		return select_idle_sibling(p, prev_cpu, new_cpu);
+	if (want_sibling)
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 	return new_cpu;
 }
-- 
2.53.0

