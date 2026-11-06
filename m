Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978406;
	b=3pNqcdj2mfMJnnopKQibPOa/1WdDjfz2ugK10ZbbZE27bDjfu69yZtoG4gXBCMDTMeIP
	 xVs8L3UIDzNr7DXOZYU/qWqxIZgRLhI9Xz1qE7AIcpHEIy3rp7fWZ1rhb4A0wYR8k1cUm
	 bCwvXM3xnpIalatkiL4RreiIendr7W1hO3HObxgI+dRQwIzOGDcGYHvJa4jHTW428UicI
	 Vh6EZzu8YVa1Y6bL+939iYZ+ofrm6hYyijCGG8N4eWBt/ET8JTCfymKhoLhxNRUIaf4UV
	 YgoRQok75ntbH1qBKCTmQDXOCzFkaEnFdex39m8zUfJQU7XrsVKrRzvMMqLUwJc5INA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
	b=fUil62t22DmZUMqlrO6rBFBaL7zNNgla3zYwp5D7DEAXyixCxSVQIW6Et08fSLBQ4Vpx
	 HzmYrKQsCwxCeJKNDdnN1+P3Fi/bP350YsJMlh/PJ+EpA9uA6C0nHfDoI5iX48H5BBeoO
	 wM3xpDzaUWdmrYCPfuBmu3ivIgpozR8qr6RmReFO98MaR7VTTTXxttwWTp1TCcKFEJjc5
	 MSBCFpkXeSWPqxD3JtCw3lNajyrBLPdV1sE3Z3Mgwtv/McYgBSzCdrwErlbyQvIoFYQxj
	 lWMn19UZ5SnSikjurKPFHi2rk704GKfL/opDzw9lxvOfMIbZRwjOEfYzqzQi6pjCpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GPc4FXfv;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87363606D838
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87363606D838
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GPc4FXfv
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df4f540ebso478163f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978404; x=1794583204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
        b=GPc4FXfvt22gzbqk5vLcMJLU7lpQxUVhsGhlDOPR6xbaQxeCjQAw2eDN9uk5b1ppTt
         wjhsATHwexBOQJ2/TH65uzpS9IMffrm8qrAWtM7C9L8GZO+xm6uxD3cIoQQ2jFmhqtNy
         U8IqAMu46IhPsOaeY+npFI0M4fMczSC9d3nHF6n7w0NCgoqrx/G8rBNWyJcFAiXzUR+X
         hXgJ1g8DtS+lS7cThTHHRPZ842Po7/NMzKlAu4nObeRVIbD/Ye61LEPJlyrJJv5NUOF1
         hcSv0Dvy7d7GLd2UswhbHUtXHuLWDUwoesm4rLJbzbJ5OmWFR84prhlx2QYVMdvJvLSN
         wqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978404; x=1794583204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ax9wKvQi8wDHGlmZ36S1nfv+j45lridyrMN7C7ii6Q=;
        b=wCwTkEtw4UYaDMek87GHkrvXE7BabS3CiNCwHPr8IIXjPgPlw1SKrLCZO3AqLxEMTz
         9bg0POQzUlUvy1MJe6oXLWfHWb8MwBoTH3ZTACUKRN2AGw5TNbrX9Jhy3Jzt3wiLj6xG
         aoTypzytei7vYcAw3XjdzXfHhs9NvhUTdYkLjGXjEP5iG0fxHTaTw847AC4P7evK0CEN
         XZyDgGscbN7gyCxNmXwRJCadtxE1O+ozg3dnvy95BP1CUZv923zrl7we/ROSQwSvrvx4
         n5OFeNFfmIGWCTYxyGS8lFsYPtuIJspDBsyXOvR/Ycdtthb3JJq7NtgRwQhC6DzK77VB
         4gAg==
X-Forwarded-Encrypted: i=1; AL+hErEOGj4uk6+wU/5qzShHnHXzPrf61vt6V7lL67pjmZHSTCmWOa1FYzSaENUHCsSHyNsaik5i9CX8VQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+30fbTA5cGWgAmZ7zqF7k460Rszcuin/EWN+ZjVY+u1v+d36RA
	ueH5M9i15lBYCjtaZEse2fVzcP4okqnASUxlrqo4o0KclegbW22PKZ6JK7uRYA0JK74=
X-Gm-Gg: AYBFou3yXLUcZi1BrHt4i79awtVxUQ1Vyp1vCJ4KKvU5qX9f9sE3vCLwb0w2AWN4BMO
	9/g4RMloY9Or9jP/x0kk2hQ1+VtS8l/q6jznhUTT4AkHSzinOMm0jBA3BreXPHhCt9KCPOwoQvh
	prUtJnUUxMSZK/Iuu4wfMsrFZMWRkQwBZl+UEachrD8oM4Xaf7es01kePYQBG9h2FOpZ4js6Gg4
	zB3A4PXIEW2scY47dOX/Z0nRysI+u8M0oeLtf12p3kVr7oLWqCD3Zm8B8PvplvkUizjkCaNTl6G
	5qtbJzk1MM47EEM3waEmBbf8TeqBg8Sijha0SECn5w6g+oq4QyUDHEHCpCxU4kwZDy6Q0OLITJE
	ayneD9N/ZO8k0H3NdLDV9dG6jtiY3nrAgJyYoV+3WkMGMHRH36YDp6sOM5kn4s7qz7pxVSWyfYx
	+lVxoj+Dcs/4ot2nFtnqK6hzm4eyEWQjoutpR4BBK7SRSdsnTTqEukJZeCLJ0vaxZzBnk8BV4ph
	n6njymxT4HHLHEuMn0zm9voFc3goVcatQTkXIz3UyPPIwi7SVTw1kig5nW6lT6fZAeoZVbiaT3B
	JH1DGpKgL8PUWYJ/qL5txC4hO/M2DmN7G9x50G+GIvW6VPw=
X-Received: by 2002:a05:6000:4013:b0:48e:5db7:fd6c with SMTP id ffacd0b85a97d-492732dc848mr6173133f8f.4.1793978403829;
        Fri, 06 Nov 2026 07:20:03 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:02 -0800 (PST)
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
Subject: [PATCH 08/20 v3] sched/fair: Add push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:35 +0100
Message-ID: <20261106151947.3991524-9-vincent.guittot@linaro.org>
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

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task doesn't have wakeup events anymore or at a far
too low pace. For such situation, we can take advantage of the task being
put back in the enqueued list to check if it should be pushed on another
CPU.

Add a push task mechanism that enables fair scheduler to push runnable
tasks. EAS will be one user but other feature like filling idle CPUs or
short slice tasks migration can also take advantage of it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |   4 +-
 kernel/sched/fair.c  | 177 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h |   7 ++
 3 files changed, 185 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d71da9069218..1096ea9cbc4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2589,8 +2589,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
index 8f99c8bf1a80..e37f8b55a293 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8405,6 +8405,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
 	}
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
+
 /*
  * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
  *
@@ -8421,6 +8423,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	update_curr_eevdf(cfs_rq);
 	update_entity_lag(cfs_rq, se);
@@ -10071,6 +10074,163 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
+	if (next == p)
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
+	__releases(__rq_lockp(rq))
+	__acquires(__rq_lockp(rq))
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
+static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev,
+				   struct task_struct *next)
+{
+	if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
+		__fair_add_pushable_task(rq, prev);
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -10552,6 +10712,18 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	cfs_rq->curr = NULL;
 	if (se->on_rq)
 		__enqueue_entity(cfs_rq, se);
+
+	if (next) {
+		/*
+		 * The previous task might be eligible for being pushed on another cpu
+		 * if it is still active.
+		 */
+		if (next != prev)
+			fair_add_pushable_prev(rq, prev, next);
+
+		if (next->sched_class != &fair_sched_class)
+			fair_queue_push_tasks(rq);
+	}
 }
 
 /*
@@ -15667,6 +15839,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 
 static void switching_from_fair(struct rq *rq, struct task_struct *p)
 {
+	fair_remove_pushable_task(rq, p);
 	if (p->se.sched_delayed)
 		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
 }
@@ -15710,6 +15883,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 		goto repick;
 
 	clear_buddies(cfs_rq, se);
+	fair_remove_pushable_task(rq, p);
 
 	if (on_rq)
 		__dequeue_entity(cfs_rq, se);
@@ -15754,7 +15928,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
-
+	fair_queue_push_tasks(rq);
 repick:
 	/*
 	 * A same-task repick skips put_prev_task_fair(), but
@@ -15770,6 +15944,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7a95df4f14d2..74e68d458509 100644
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
@@ -3887,6 +3889,8 @@ static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
 
+DECLARE_STATIC_KEY_FALSE(sched_push_task);
+
 #ifdef CONFIG_MEMBARRIER
 
 /*
@@ -4219,6 +4223,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
+struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+			    struct task_struct *p, int new_cpu);
+
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

