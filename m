Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3E3E3146
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099832; cv=none; b=tbrPKe9obDZ25f/0LjrRxGbRJ8dHnvr6fJyq4TN6+oRF/SKiRsGdIvXcnIjMcYbWxcy3nCJzN58FErAja6T2pRYD8O6tVK7IOEVLlHKzvWAV1ilcEI8Pmoqpe0AQqpk2OMgSnrwXRqXACztrXjaR/DzDmIu5EEdurmQ0SJmVabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099832; c=relaxed/simple;
	bh=Q1sbhVKuou1qBZ5TiuWKeYkxsOTOORlBbqa1wCehRcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BHwflsr9ybvIHTE16lxst9TcIGPcIIHzkvqWdgj5QJM/9ZMe7rT3QK1fgSTyIF9VokgO4XMtdpc+9svlskOklA18FEmLAeOvyregvX6L1OHIlXpZTmkxWJTIg7409/SJyzBaqIGwCvmhmQbO3l4x6VQEEqjIP/G/FWG5Bv0DOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NCBhHkX7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCBhHkX7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45d96d21e82so1146631f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779099829; x=1779704629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FqObqQgoqGLmSu5TEn1vtNWLkK+0u7UlUpxqilZBr8E=;
        b=NCBhHkX7qThuTyu1ImBHtnL2kAdQiL5oHaIOdWLCL2VUFHd2vklvFXNHOJdP8b0krz
         CM4ETzhgzO0WD8lp6oCVm+d1bhF7eVFwQTUgR/Fv+2ghNXz+MLlMfv3T2V8ASnQ92goq
         UuC/uMD7VmSnA0H7EOrx+62xta7OSXqbYTc+kyxyS+un5JE7Q3nhEJZTCs/Z+6mKmtny
         GPL8B/Z+MjNdzhjYlCWU/NgqDfztLcuktfu556SLmTTSm0TkCjxQCmYjJJrix6+9lI+l
         dckjezXSoS2SWtz1KPaklfZMWni5IGLxlfcuNjO+Xv6/lCaatfULZsjQ0lm2xXy8MaXg
         U3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099829; x=1779704629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqObqQgoqGLmSu5TEn1vtNWLkK+0u7UlUpxqilZBr8E=;
        b=iLqaP4MLR5suigZXGiw49kwN+bTcO1e9/YodACFlVA05c5VsgFvoK8fIQbr/B3FBWh
         AIUlV/DVuCNi9kiCyhOtTuWTBI4GF/nNavcQcG+WvZCFRyv2x4o4uQk917CtWd4uAnZ+
         NdfgfPtw0hUidDXjGTjUHuPcwMwamssPtbIAdaviah9wOImGlV7lI3mlszcWA8vPKTeN
         fzNrRcKhkoT1l506vzrOxfIm8GM+cH6KuOhtRA2osmXSgHQinmWAf4monj70OrtnDgFW
         jwctmz4xml7UTSi+3k3Blf6iji7AbbFncH96yxQEt7ZJYMY0R6yNur6iAQGWfT2mbbBi
         sFQg==
X-Forwarded-Encrypted: i=1; AFNElJ8EVG2LqI0k1f6rEhBYogN+TU7t+jaiAGLDZLAfy1du/h0dvAglrDotuXVZB5/POF9Y1hnjYBCSCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKQI9nFYNN88I9TkmLtkEPXBTLwsyTLSPDDqAOP4BTf7zfAAi
	CjB3jFBVhbSj/g0C5xauu3ddDVxwrRC9qYbBWyOG6gs39EY3VnPI7Df8CIDZxDaq5PI=
X-Gm-Gg: Acq92OEVDhp9Vz+krAegT00xL6F+ejpr5N5GwnR/prYqUVSwyW/J6qMevZqQhnHs3gn
	819EXOY2Vb6jewPK7jT2vsoNgDHUnUZcibRbaznQGs1/gRPQbdKYTtmT629mKZ5HQXGwjiRmAS3
	QgEIQZezD3Gn3wtZHOtSOQph7hDLuDRnJxuqB9FHX8JoqiO30u5oxNDHQ4u4TIxbnRG6NTykLij
	Znzbvp8nGHXGVSuSCrAhDYRAg7cBa1M5MITmIN+r8p4nN7dUmjJrkbw9xYiGYy/6C/5JUjv8a0u
	0CXJ35hDjVC21YtbhuaTZncUj80Wc/JE/StqC4L5va2wKTzGdBbMWncEBOGw9dFvkDn2ks4r52S
	bPPdLZPiOi6OuTJU1lJPtrB32EcCcmNa2LWtGrCVQcwATh+s4lJOmo1nHCKsYBMq3/Vtzp7HG2Z
	1BVmcaoAD/0Yr2h/kb6R6Xb2ld2cYd4xk=
X-Received: by 2002:a05:6000:2584:b0:43d:7783:c684 with SMTP id ffacd0b85a97d-45e5c5e6d3dmr22742378f8f.43.1779099828698;
        Mon, 18 May 2026 03:23:48 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:7413:a5e:e760:505b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767ee0sm34024455f8f.1.2026.05.18.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:23:48 -0700 (PDT)
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
	qyousef@layalina.io,
	linux-kernel@vger.kernel.org
Cc: tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com,
	tglx@kernel.org,
	rafael@kernel.org,
	jstultz@google.com,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Update util_est after updating util_avg during dequeue
Date: Mon, 18 May 2026 12:23:45 +0200
Message-ID: <20260518102345.268452-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

util_est_update() must be called after updating util_avg during the dequeue
of a task and only when the task is not delayed dequeue.

Move util_est_update() in update_load_avg().

Fixes: b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
Reported-by: Qais Yousef <qyousef@layalina.io>
Closes: https://lore.kernel.org/all/20260512124653.305275-1-qyousef@layalina.io/
Reviewed-and-tested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 188 ++++++++++++++++++++++----------------------
 1 file changed, 92 insertions(+), 96 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 728965851842..09d3acd2d2bc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4930,13 +4930,86 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
+#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
+
+static inline void util_est_update(struct sched_entity *se)
+{
+	unsigned int ewma, dequeued, last_ewma_diff;
+
+	if (!sched_feat(UTIL_EST))
+		return;
+
+	/* Get current estimate of utilization */
+	ewma = READ_ONCE(se->avg.util_est);
+
+	/*
+	 * If the PELT values haven't changed since enqueue time,
+	 * skip the util_est update.
+	 */
+	if (ewma & UTIL_AVG_UNCHANGED)
+		return;
+
+	/* Get utilization at dequeue */
+	dequeued = READ_ONCE(se->avg.util_avg);
+
+	/*
+	 * Reset EWMA on utilization increases, the moving average is used only
+	 * to smooth utilization decreases.
+	 */
+	if (ewma <= dequeued) {
+		ewma = dequeued;
+		goto done;
+	}
+
+	/*
+	 * Skip update of task's estimated utilization when its members are
+	 * already ~1% close to its last activation value.
+	 */
+	last_ewma_diff = ewma - dequeued;
+	if (last_ewma_diff < UTIL_EST_MARGIN)
+		goto done;
+
+	/*
+	 * To avoid underestimate of task utilization, skip updates of EWMA if
+	 * we cannot grant that thread got all CPU time it wanted.
+	 */
+	if ((dequeued + UTIL_EST_MARGIN) < READ_ONCE(se->avg.runnable_avg))
+		goto done;
+
+	/*
+	 * Update Task's estimated utilization
+	 *
+	 * When *p completes an activation we can consolidate another sample
+	 * of the task size. This is done by using this value to update the
+	 * Exponential Weighted Moving Average (EWMA):
+	 *
+	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
+	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
+	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
+	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
+	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
+	 *
+	 * Where 'w' is the weight of new samples, which is configured to be
+	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
+	 */
+	ewma <<= UTIL_EST_WEIGHT_SHIFT;
+	ewma  -= last_ewma_diff;
+	ewma >>= UTIL_EST_WEIGHT_SHIFT;
+done:
+	ewma |= UTIL_AVG_UNCHANGED;
+	WRITE_ONCE(se->avg.util_est, ewma);
+
+	trace_sched_util_est_se_tp(se);
+}
+
 /*
  * Optional action to be done while updating the load average
  */
-#define UPDATE_TG	0x1
-#define SKIP_AGE_LOAD	0x2
-#define DO_ATTACH	0x4
-#define DO_DETACH	0x8
+#define UPDATE_TG	0x01
+#define SKIP_AGE_LOAD	0x02
+#define DO_ATTACH	0x04
+#define DO_DETACH	0x08
+#define UPDATE_UTIL_EST	0x10
 
 /* Update task and its cfs_rq load average */
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -4979,6 +5052,9 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		if (flags & UPDATE_TG)
 			update_tg_load_avg(cfs_rq);
 	}
+
+	if (flags & UPDATE_UTIL_EST)
+		util_est_update(se);
 }
 
 /*
@@ -5037,11 +5113,6 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
-static inline unsigned long task_runnable(struct task_struct *p)
-{
-	return READ_ONCE(p->se.avg.runnable_avg);
-}
-
 static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
@@ -5084,88 +5155,6 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
-#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
-
-static inline void util_est_update(struct cfs_rq *cfs_rq,
-				   struct task_struct *p,
-				   bool task_sleep)
-{
-	unsigned int ewma, dequeued, last_ewma_diff;
-
-	if (!sched_feat(UTIL_EST))
-		return;
-
-	/*
-	 * Skip update of task's estimated utilization when the task has not
-	 * yet completed an activation, e.g. being migrated.
-	 */
-	if (!task_sleep)
-		return;
-
-	/* Get current estimate of utilization */
-	ewma = READ_ONCE(p->se.avg.util_est);
-
-	/*
-	 * If the PELT values haven't changed since enqueue time,
-	 * skip the util_est update.
-	 */
-	if (ewma & UTIL_AVG_UNCHANGED)
-		return;
-
-	/* Get utilization at dequeue */
-	dequeued = task_util(p);
-
-	/*
-	 * Reset EWMA on utilization increases, the moving average is used only
-	 * to smooth utilization decreases.
-	 */
-	if (ewma <= dequeued) {
-		ewma = dequeued;
-		goto done;
-	}
-
-	/*
-	 * Skip update of task's estimated utilization when its members are
-	 * already ~1% close to its last activation value.
-	 */
-	last_ewma_diff = ewma - dequeued;
-	if (last_ewma_diff < UTIL_EST_MARGIN)
-		goto done;
-
-	/*
-	 * To avoid underestimate of task utilization, skip updates of EWMA if
-	 * we cannot grant that thread got all CPU time it wanted.
-	 */
-	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
-		goto done;
-
-
-	/*
-	 * Update Task's estimated utilization
-	 *
-	 * When *p completes an activation we can consolidate another sample
-	 * of the task size. This is done by using this value to update the
-	 * Exponential Weighted Moving Average (EWMA):
-	 *
-	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
-	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
-	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
-	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
-	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
-	 *
-	 * Where 'w' is the weight of new samples, which is configured to be
-	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
-	 */
-	ewma <<= UTIL_EST_WEIGHT_SHIFT;
-	ewma  -= last_ewma_diff;
-	ewma >>= UTIL_EST_WEIGHT_SHIFT;
-done:
-	ewma |= UTIL_AVG_UNCHANGED;
-	WRITE_ONCE(p->se.avg.util_est, ewma);
-
-	trace_sched_util_est_se_tp(&p->se);
-}
-
 static inline unsigned long get_actual_cpu_capacity(int cpu)
 {
 	unsigned long capacity = arch_scale_cpu_capacity(cpu);
@@ -5618,7 +5607,7 @@ static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool sleep = flags & DEQUEUE_SLEEP;
-	int action = UPDATE_TG;
+	int action = 0;
 
 	update_curr(cfs_rq);
 	clear_buddies(cfs_rq, se);
@@ -5638,15 +5627,23 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
-			update_load_avg(cfs_rq, se, 0);
+			if (entity_is_task(se))
+				action |= UPDATE_UTIL_EST;
+			update_load_avg(cfs_rq, se, action);
 			update_entity_lag(cfs_rq, se);
 			set_delayed(se);
 			return false;
 		}
 	}
 
-	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
-		action |= DO_DETACH;
+	action = UPDATE_TG;
+	if (entity_is_task(se)) {
+		if (task_on_rq_migrating(task_of(se)))
+			action |= DO_DETACH;
+
+		if (sleep && !(flags & DEQUEUE_DELAYED))
+			action |= UPDATE_UTIL_EST;
+	}
 
 	/*
 	 * When dequeuing a sched_entity, we must:
@@ -7409,7 +7406,6 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
-	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;
 
-- 
2.43.0

