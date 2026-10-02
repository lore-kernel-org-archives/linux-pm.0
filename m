Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156B4F4CE6
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955919; cv=none; b=Twy/zGcWRd6aWBuEzci4JJ7+USTkf/fRERg2rqe1/NGQ62d7tdzE0/UVaMuQDmwJHtML1Mq5yccKRR+pwjGkVDMqwglRriJROvJQ1PQv1Wvkz66Tprc/npieJIvU2PQsz5siMD+kn5CWNwTnbV2RhI4Gzc0R8hfwi7nJRS/3h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955919; c=relaxed/simple;
	bh=F581+o6cP/xnDid67xwjYpL7pucVHQFB9JiK+L4tzNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwRoiZR2viL3w90tVaVhxMo873etIDaEUKIsvcXAsEeXFKLoUjOuEpVgZIEJLMgRUWeAZ9hvH8L22oY+u6TfbKjvG+KItL5GIiHz+WR3Qn0tG1hFp77cGIJWOzbQD4wSwy9KEQ19uS1F/qRMuK+bCA4ACnMHQSG/ZE6D5DAMUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=veltNQRM; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veltNQRM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso133385e9.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955915; x=1791560715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4ZO8O8UQqhOQZi3vmWpFQCY4/FzwZ/+ZmiCQhYWZzw=;
        b=veltNQRMwNGXy5Bw50o5aLVi/6GjaYwq6URwo9v4Q7eJdiKlhuLUo87oXsTEmusyBu
         mXgG94JzDjEVW1IdRGzOmlqVUXwjstjYepqkBSC/JFxixhrAY3sdBOQQS5Pln2h+FVHw
         z5WSW6qGej+cAbYJ7QCg9DYzVP6WoBfkd+yCGzvXJV05Cqcr17YNOwvBSXU1mBWUNS7+
         XvKFVF9hYrz7vOJzTP1hofXSNi94WMFd/6F8ut4dpqCArtMCUvm+kNcX0bNEkdJQJ0W4
         XD78EQ9wsGH0QftiToMvrKDOnkM1dQ8wtcCJbpaO882jjLC3Mv+F5DfZL+Uxme2KdeLa
         iSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955915; x=1791560715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4ZO8O8UQqhOQZi3vmWpFQCY4/FzwZ/+ZmiCQhYWZzw=;
        b=QF3k+U0/+CG3eNA1i+WK5aXX83mN9JH9XAWRneoPrRzUq18BsloNeCA673K6iZFfuh
         53sfyqalJ0bqrY2EVND4xKADOaJhJQLLaXO/+Ej6ow5aQfVGPKGtj6Tg95m09k/yZiA3
         qsSdrVilH6RDVOEyqtRDGGCD8vY/mpUm7gqCDV0QZWMfstDsqCNaQ6+/Eg6O6gk83J1P
         vbECCE+G90fbwxXc6mzXB2KeFKIlgn87ouspm5mv7H4DUOgbdgAKb9AvaChMUDYzkorv
         kyHtIGdhfxx96gVCUoF8uqdj6+FPWtn5KLYrC7AKEPRYl3sDTPv6xU5brFK2wcBQdIl2
         8wQA==
X-Forwarded-Encrypted: i=1; AKwUvBzTIiZst+viv+wWVrjrjXJHnn2UfAAXJrzUGABvpWaIMfdkSdRmHYUnlQPym7cC1MjpFO9EI5bNlA==@vger.kernel.org
X-Gm-Message-State: AFuF++nYIU4y/PcmaaxB6AiTXvL3BOYUZ027a79tglHNHWzxEBzq6Ste
	dh8x/XAyOBTY00AHh0ePlY0AjhSWeCy5L6JsYyit4PfHbCTdCBK1vS7EPL/cWkcADzI=
X-Gm-Gg: AYBFou1YIdLG+QkP5oL1BAahVoe3orP+LFU9cIy+DVRiFwWd8tc+saIb2OtanZAkphz
	azfBJqMekzlCjcyvimNZFM1yhogsme9/swbZIPfWKvILdpGwzx/ARuNyDK+Etw3Hwm8Sq/9aeiR
	6eMyc8YV1AXp84GY0ML0XkU6qfhHnLP3JnYrgYtohw+W6WV+E26y6DQIpj9GTuYjCqz+NaQgKXa
	kqTaTG9pAf+fK6UJOnIBDecgnCF5KOhb3ItkF631rIUxS+7qRAZ03Vgqof69soF1w4131TbDqfU
	qO2xszpW00qa60MZfo4siUX+TDAHzbyhAVyvyuivDjW2D25bIkdSlFvUh5jVaH9VuyrTcyDEuzF
	HxIrspPXQ//QmbIIOc9KhPUuiBAcQ7XAIRFLj9Zi9aBT8HCvhDHoM6gvBN/mk5trx0VS2R+Vwzw
	qG+/1AzyuxBGFbQTGvZXgbmmxWL6iSsDLr45cAhnzrILXkpNsSgQ7ZoI+7vvFIfhBIqZQJzG3Cm
	UV4527k7wcfRULV
X-Received: by 2002:a05:600c:530f:b0:49f:fefa:cfcd with SMTP id 5b1f17b1804b1-4a0276a2270mr54724405e9.5.1790955914780;
        Fri, 02 Oct 2026 08:45:14 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:12 -0700 (PDT)
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
Subject: [PATCH 08/18] sched/fair: Optimize push task mechanism for fair
Date: Fri,  2 Oct 2026 17:44:05 +0200
Message-ID: <20261002154415.2270586-9-vincent.guittot@linaro.org>
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

Instead of always unlocking local rq in order to lock both task and rq
in a safe order, just try to lock the task. If the task is already locked
by something else its state will probably change and the conditions used
add it in the pushable list are probably not true anymore. As a result
skipping the push sequence seems like a good choice.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  | 48 ++++++++++++++++++++++++--------------------
 kernel/sched/sched.h |  3 ---
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18692b752814..837dc74c9a8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
  *
  * Returns (locked) new rq. Old rq's lock is released.
  */
-struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p, int new_cpu)
+static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
+				   struct task_struct *p, int new_cpu)
 	__must_hold(__rq_lockp(rq))
 {
 	lockdep_assert_rq_held(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00078ac7fada..6ba2efeba435 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9871,8 +9871,7 @@ static bool fair_push_task(struct rq *rq)
 {
 	struct task_struct *next_task;
 	int prev_cpu, new_cpu;
-	struct rq_flags rf;
-	struct rq *cur_rq;
+	struct rq *new_rq;
 
 	next_task = pick_next_pushable_fair_task(rq);
 	if (!next_task)
@@ -9881,38 +9880,41 @@ static bool fair_push_task(struct rq *rq)
 	if (is_migration_disabled(next_task))
 		return true;
 
-	/* We might release rq lock */
-	get_task_struct(next_task);
-
 	prev_cpu = rq->cpu;
 
 	/*
-	 * We need to release rq lock and take both task and rq w/o
-	 * triggering a deadlock.
+	 * The safe lock ordering for task and rq is task 1st then rq but we
+	 * already get the rq so just try to get task too. If task is already
+	 * locked, it is waiting for the rq's lock and it is about to change
+	 * task state so skipping the push sequence in order to speed up the
+	 * release of the lock is the best choice.
 	 */
-	raw_spin_rq_unlock(rq);
-
-	cur_rq = task_rq_lock(next_task, &rf);
-
-	/* Task already migrated */
-	if (cur_rq->cpu != prev_cpu)
-		goto skip_push;
+	if (!raw_spin_trylock(&next_task->pi_lock))
+		return true;
 
 	new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
 
 	/* Task doesn't need to migrate */
 	if (new_cpu == prev_cpu)
-		goto skip_push;
+		goto no_push;
+
+	new_rq = cpu_rq(new_cpu);
 
-	update_rq_clock(cur_rq);
-	cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
+	deactivate_task(rq, next_task, 0);
+	set_task_cpu(next_task, new_cpu);
+	raw_spin_rq_unlock(rq);
 
-skip_push:
-	task_rq_unlock(cur_rq, next_task, &rf);
+	raw_spin_rq_lock(new_rq);
+	WARN_ON_ONCE(task_cpu(next_task) != new_cpu);
+	activate_task(new_rq, next_task, 0);
+	wakeup_preempt(new_rq, next_task, 0);
+	raw_spin_rq_unlock(new_rq);
 
-	/* Restore rq state */
+	/* Restore rq lock state */
 	raw_spin_rq_lock(rq);
-	put_task_struct(next_task);
+
+no_push:
+	raw_spin_unlock(&next_task->pi_lock);
 
 	return true;
 }
@@ -10432,6 +10434,9 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 	 * if it is still active.
 	 */
 	fair_add_pushable_prev(rq, prev, next);
+
+	if (next && next != prev)
+		fair_queue_push_tasks(rq);
 }
 
 /*
@@ -15584,7 +15589,6 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
 
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
-	fair_queue_push_tasks(rq);
 
 repick:
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 74130bd2a2c8..293f23620282 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4213,9 +4213,6 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
-extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-				   struct task_struct *p, int new_cpu);
-
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

