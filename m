Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4B4F472F
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955918; cv=none; b=IbeYVnosAzbyM+4hvwBG1EboyCIy7/ajPR3vBdn2G+R92LfO1VFETz5LmNVqCtrHGaG3j5NPsXZTau7kIpnXsqRPHt0WmQpscwBvfGx0RuL5FM/nRKb9hg8xm6WEZ0/WPPp2Sqrk+OJSl2tycTMvLEpW8Gv02j2MOvO4tNFMtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955918; c=relaxed/simple;
	bh=SXGyDDrL/ROMF7j4me/V61A0ATkUfNuEhqq23wRxJKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=It9DqQr9/ylzpfOkcRCtT805K3jg+p2aPArg4NEfs3WK7jO43nUJj2GLR8Bb+WQCZhQLycaCMD7D8nbyoqQxBN4JdWuOFPQzNq7RNwbJrpJ5u9Qkou3aP3PXdgumqYzYezisKqKo/ZUiL8duC5fX5aloj306AWFzghp2cNXxRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VvGkMXHS; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvGkMXHS"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff72474fso227315e9.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955912; x=1791560712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWycLynOeS31BSwjrLwbY4e26mfEhfwnJrseaf0sLdU=;
        b=VvGkMXHSajdhTb3ICPZExOazL8mMdD4NV9jtU6So+v0VoT+euHXkdOgq3pTUpFKQZ4
         O0FAM4aei/H9yekwUC+F6yu4/jHGevmq+yC06dBmKHzfsage8XA3flUIhdPoMf2lYgVQ
         CipPiy1joCyyVaCC9Xg9IWsHBgzk8iAx+zK39LorlV+2Ud8avc569auFTocc89FFhLce
         slxu1g01YzWb0VDvXQWze/K/pk0K+uyvWVyXxNWx1eMg6wRs/hm7qsk0aj3U11/OVuKZ
         3e5Lsr71PVPhVLirj0170e3yWL9487nDwNy3vtIiYAnBzAVQRW6gJjI+4ycPJhkETd14
         OQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955912; x=1791560712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GWycLynOeS31BSwjrLwbY4e26mfEhfwnJrseaf0sLdU=;
        b=wiNxEj3PrcstZXDiEMK7l6HFzvegZ/NIgJNG2EK5Xfpz0N1U/hB4AOyKEJ8lSe8Q+h
         Qir7Bc50QvXBTPCcFYZBerlbdKuTsV+5xc6hpEQDq6Xi8FBTjDik43wFFBPwQ4zsOt3t
         HXz0R8ZOfPjMWXxmbXvLNSXr3H63vela2lTq7KvqEdDelbS0yV+WeW4i3qI6Tx4KeN7U
         G3vdqpFLC1uPMVJx0XJb+tLfudgw65l0pWA+Olji05+wST9tv5PUePuV/0hynSy7H1B6
         x28GYxVa7+oT1HBdNoLE/DtOGuFDAf1usZ+JpAZIBVx970sZT0TcjcoFq4c42cVoSRPd
         exqg==
X-Forwarded-Encrypted: i=1; AKwUvBysvMHZl0VUfXQ+JpBa7ko1jgp3DGtCHOP5F4zc+qvworlUR9mv0gZKQgGASl1xx2SAb1KeVs1jaA==@vger.kernel.org
X-Gm-Message-State: AFuF++krwjegxFnPW5+jbOmLwfkE1uFIxesXaoGceDUdyU71ibSVlUET
	8GJJczKVBpinkOW9sQfLQ6RNBj8Psj81h8GfLMqpsCqghZXOdCgnUmaL4oki2qeBFC0=
X-Gm-Gg: AYBFou2jtkgA8PLlko1M3pepTkbkeINrGwHiPx5+JEhJCX7zHOQzFF/DoJePEpFT1i7
	9bMwmvukB8HbvypSf9gVG6a5SOiHUsXrVQ1+f1ucgRhSmKIGZnz5V1as1nhNLZUlR2Q0rjDy9hH
	XHZ3GVbELy1zlvcubHqJpoLWBL98Q+RdeDHktsXppV7y4dQHMrNY+ecxEan1vsCkLP7feKqTIDh
	ztRwfzqJbvEjhlWJVtTNJAEKDmKnygP2IJsBpYw5AgMtGtruGi52f4+jWWOyOAjNWhoYIt+qRva
	Alpid0W+W+jYO7QNQXN+UmAZ5ck3003upHGOLMqg90Zb5TCcozszOePloG2bcQCe4K3QYxtAyVS
	gpe7O8TLom39EqeTJBg6ZNqLycVUbypm+YsIgrOaD2xM3OXUA+DT6+3HVSAPwXDbfhvtYZs/GEy
	JYG9Ap0hZHNwDYGV2SfYyHjyneLEGxEDn904NxZvyaPUMF+b7sg21I/UCXWNFFVVv1ey+h2lVPn
	YKpDr8/qtuUzCIcGYATQiGPERVm
X-Received: by 2002:a05:600c:a306:b0:49f:f099:6f8c with SMTP id 5b1f17b1804b1-4a0275758cemr42890805e9.9.1790955912417;
        Fri, 02 Oct 2026 08:45:12 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:11 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 07/18] sched/fair: Add push task mechanism for fair
Date: Fri,  2 Oct 2026 17:44:04 +0200
Message-ID: <20261002154415.2270586-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task doesn't have wakeup events anymore or at a far
too low pace. For such situation, we can take advantage of the task being
put back in the enqueued list to check if it should be pushed on another
CPU.

Add a push task mechanism that enables fair scheduler to push runnable
tasks. EAS will be one user but other feature like filling idle CPUs or
short slice tasks can also take advantage of it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   7 ++
 3 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 837dc74c9a8d..18692b752814 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu)
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu)
 	__must_hold(__rq_lockp(rq))
 {
 	lockdep_assert_rq_held(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f12678850ce2..00078ac7fada 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8179,6 +8179,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 	}
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
+
 /*
  * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
  *
@@ -8195,6 +8197,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	update_curr_eevdf(cfs_rq);
 	update_entity_lag(cfs_rq, se);
@@ -9799,6 +9802,157 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return target;
 }
 
+DEFINE_STATIC_KEY_FALSE(sched_push_task);
+
+static inline bool sched_push_task_enabled(void)
+{
+	return static_branch_unlikely(&sched_push_task);
+}
+
+static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
+{
+	if (!task_on_rq_queued(p))
+		return false;
+
+	if (p->se.sched_delayed)
+		return false;
+
+	if (p->nr_cpus_allowed <= 1)
+		return false;
+
+	return true;
+}
+
+static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
+{
+	if (!__check_pushable_fair_task(rq, p))
+		return false;
+
+	return false;
+}
+
+static inline int has_pushable_tasks(struct rq *rq)
+{
+	return !plist_head_empty(&rq->cfs.pushable_tasks);
+}
+
+static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->cfs.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+
+	/*
+	 * Remove task from the pushable list as we try only once after that
+	 * the task has been put back in enqueued list.
+	 */
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+	return p;
+}
+
+static int
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
+
+/*
+ * See if the non running fair tasks on this rq can be sent on other CPUs
+ * that fits better with their profile.
+ */
+static bool fair_push_task(struct rq *rq)
+{
+	struct task_struct *next_task;
+	int prev_cpu, new_cpu;
+	struct rq_flags rf;
+	struct rq *cur_rq;
+
+	next_task = pick_next_pushable_fair_task(rq);
+	if (!next_task)
+		return false;
+
+	if (is_migration_disabled(next_task))
+		return true;
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	prev_cpu = rq->cpu;
+
+	/*
+	 * We need to release rq lock and take both task and rq w/o
+	 * triggering a deadlock.
+	 */
+	raw_spin_rq_unlock(rq);
+
+	cur_rq = task_rq_lock(next_task, &rf);
+
+	/* Task already migrated */
+	if (cur_rq->cpu != prev_cpu)
+		goto skip_push;
+
+	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
+
+	/* Task doesn't need to migrate */
+	if (new_cpu == prev_cpu)
+		goto skip_push;
+
+	update_rq_clock(cur_rq);
+	cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
+
+skip_push:
+	task_rq_unlock(cur_rq, next_task, &rf);
+
+	/* Restore rq state */
+	raw_spin_rq_lock(rq);
+	put_task_struct(next_task);
+
+	return true;
+}
+
+static void fair_push_tasks(struct rq *rq)
+{
+	/* fair_push_task() will return true if it moved a fair task */
+	while (fair_push_task(rq))
+		;
+}
+
+static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
+
+static inline void fair_queue_push_tasks(struct rq *rq)
+{
+	if (!sched_push_task_enabled() || !has_pushable_tasks(rq))
+		return;
+
+	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), fair_push_tasks);
+}
+
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_push_task_enabled())
+		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+	plist_node_init(&p->pushable_tasks, p->prio);
+	plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+{
+	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
+		__fair_add_pushable_task(rq, prev);
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	cfs_rq->curr = NULL;
 	if (se->on_rq)
 		__enqueue_entity(cfs_rq, se);
+
+	/*
+	 * The previous task might be eligible for being pushed on another cpu
+	 * if it is still active.
+	 */
+	fair_add_pushable_prev(rq, prev, next);
 }
 
 /*
@@ -15379,6 +15539,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 		goto repick;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	if (on_rq)
 		__dequeue_entity(cfs_rq, se);
@@ -15423,6 +15584,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
+	fair_queue_push_tasks(rq);
 
 repick:
 	/*
@@ -15439,6 +15601,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e025d2a6c302..74130bd2a2c8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -721,6 +721,8 @@ struct cfs_rq {
 		unsigned long	runnable_avg;
 	} removed;
 
+	struct plist_head	pushable_tasks;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
@@ -3877,6 +3879,8 @@ static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
+DECLARE_STATIC_KEY_FALSE(sched_push_task);
+
 #ifdef CONFIG_MEMBARRIER
 
 /*
@@ -4209,6 +4213,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
+extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu);
+
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

