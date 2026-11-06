Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978410;
	b=VZvcJPdWb47Lnz+gv+li/B0X8ScrUnJ1dhMpJ0AocnyWJxrzPBHwOEOovnAu+pHu833U
	 /HJcflb1akTZ2fDL7Wf1h3RDrOe4vwZ0bI+ZnWT66qcXenw/thI5py/5gV9dTS9Uv401B
	 wlSdR68M3ijfIoWuAY/jmJaiiyxMbYVYXwuGSR4WDMcq9BIioUwW9lwgh6onLlOmKeZe3
	 Oy53Qm6uv2BoACPaJaNpybMJikq0clXpMeBhU22RiR30P4vGKlPCKCYmeT7RbFx4pNR4y
	 RW4PiKGLM4XLanuINkrVIcybCgyNJzQA2HBk3BNDrwsAoyuauyzMd9Zxa6UlDB0MY2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
	b=CpToTbTlnWNpHg4hqu+SJZ5CUuH4VOYCfzK3BvV1/YxcpXYD+lNRzXavcfSxVkoqxEVz
	 AegbsSn9Jk21qX3LZc5xDev97EyrPigp7T3aSkuhQCORmlfhwwagOTmGkofT4uWHoqd/d
	 xVnJImC2k9LObQrK5O5xdg7f3Q/WiisNAzz+iVsBtDhBG5td7OgIGlijo7OO9iR3xDpAt
	 xeqpjANpjmrI/pBir7fZd9iYn148t08dLqP8cHmTs/12JtaNUloRFERefV/wNKvcIDZ6k
	 sACyOPqT84TkEgxh7w02Wq6uKZAAYftz1S98Fze1iizJqU3GOFBIr7fde/FA4Xt9Bug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bXGz7mRT;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D0606D801
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6D0606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bXGz7mRT
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490f38e9688so620374f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978407; x=1794583207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
        b=bXGz7mRTZWmNRo0YCRJ374sGZEkQpwGUN4qyeBlm0muKQGAAg63Ji19QaTScqucXaE
         shckfsS8wRNlwrxIXO5o3wInb0oJEKo9JPYU4ea/D+NI/F2pBsrDcs5GRPf2l4tQvecP
         /DDuvIbiRoiE2V3jAMKtsIIDOBFpZgoERH/aboEMsGdXUT5kUKTr0MRCQSAwpHz/gQNd
         ogknyxZpcLtp0E2kx+AUtp285q5jN9+20HBBXh7KEWM7NURNJ7hKE/j18ENA+0ucx1Eg
         1h7Rkw8Hgwz+QPA2hNlYwVRI/IUCrmyZEb0/6kwHt0sSAj0DXerMOmXp5dZaFYGrbWna
         jA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978407; x=1794583207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgP1RfWkzsd+DjtzV4UbJ47EPKUkaZ358Ml7CyDptEY=;
        b=EeDoy3xhVg/uvqtpQyePVtMqW5E1kT+Nrke/L5btESRvqF9/N9EHql1cAf8zIdi5ix
         5SmoYTDzslyNaPPq7RThgdBiKnZcxWjfG7aPO3b4SiFX5z4JSfiPW9dzj8nvB/eQIa/a
         3DkKSTnGvCqtid8zfZqB/e3jw8KalrWKo2fzAuMxlYFrAKH6jNXUrX3GXe/XxZXr8Atm
         yHW4f/mSBQgvAZdRQhMew6de+/gwbRVGYDittYhd/kX+bFSSQccPPa1lCzRmiDf7JXdx
         yLxoEsGyKs/Wu17OkMnPBJGgckZ8IyIdxlCne6EPYYd7kGUJawk4zmVMqv5YibrAEjUc
         wxYQ==
X-Forwarded-Encrypted: i=1; AL+hErGhPHbO81CIxelO0qnRWg8eoFPF7xhYu3s+NoCjKI9z8tYsNPxnZswS+s4mcmRY8iJomCtC7xusIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z85wJ5p8P1quhMydgm67Qa90QHACbT40RvWNJ898gPLGo4wbXo5
	qcAOl+BwbCpb7X0QN8BGwq6d6NA2dk43OwqDVFDOz78P5S9s13CtAqQbwY5N5st3+ao=
X-Gm-Gg: AYBFou1lj1dmGWCQo/g0aZyy5sMrUgr/eoN3YEI9l/GamXhhVdBUOG3IZ8yLclfhk4f
	snnutjFQ25VcCAj9md8k9zkCCoC0cN0yw4KFusymcDH4nTjWeciFD0Vurbei7IhCPoErE2Q+fRW
	+cYf9rLjuisNlVULjLjol0ovwYClW66iDAsxeRX9ez4JYou0uoTCwzpcKsdO276I6exG9UU3iCX
	LpzP+X9gRiMqK+9oEF807Xgsq1C+cgrNo7ywmOuO4QnfyLAK5f0+BAABpn1db499QZJZPeTcSK5
	0UUZZapf8LERToKtlKgUOGNxgBVw0PG0plvviRdj+TUoIGDIMGqb2fwoLsIQCkWZtigURHpMGRt
	5PRxbXMQB0Xl4EUu7rYk7195jaHqhLyW/4F8ZN9+u+5lF+OpmyqYQ3SZFcg0dGRnVVJ3/9PzwgR
	OpHRxZJrlZp/Ln9k8hdr+VAzV3DKD4zi8Md5r80yTuno5GHCh+/CijJD7JzwJJBFHw89uDlPz8m
	DueIInTsU3hZ/X/aBGgYBAiXwZ/amLUT4nrZI2DefP6asD++U6Xkvsm9/1D2Nu6De0rtSG7Uivk
	u974GyBz4EPz69QfEj3jFXA4pc9BU61S+X0bz9/MhbIagDzceaFZ+qNIQl1S4F9eAN1M
X-Received: by 2002:a05:6000:990:b0:48d:f160:efad with SMTP id ffacd0b85a97d-4911ad38a5emr11827296f8f.30.1793978407281;
        Fri, 06 Nov 2026 07:20:07 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:06 -0800 (PST)
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
Subject: [PATCH 09/20 v3] sched/fair: Optimize push task mechanism for fair
Date: Fri,  6 Nov 2026 16:19:36 +0100
Message-ID: <20261106151947.3991524-10-vincent.guittot@linaro.org>
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

Instead of always unlocking local rq in order to lock both task and rq
in a safe order, just try to lock the task. If the task is already locked
by something else its state is probably changing and the conditions used
to add it in the pushable list are probably not true anymore so skipping
the push sequence seems like a good choice.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  | 44 +++++++++++++++++++++++---------------------
 kernel/sched/sched.h |  3 ---
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1096ea9cbc4c..d71da9069218 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2589,8 +2589,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
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
index e37f8b55a293..e2999d3f88e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10148,8 +10148,7 @@ static bool fair_push_task(struct rq *rq)
 {
 	struct task_struct *next_task;
 	int prev_cpu, new_cpu;
-	struct rq_flags rf;
-	struct rq *cur_rq;
+	struct rq *new_rq;
 
 	next_task = pick_next_pushable_fair_task(rq);
 	if (!next_task)
@@ -10158,38 +10157,41 @@ static bool fair_push_task(struct rq *rq)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 74e68d458509..b88857dd3941 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -4223,9 +4223,6 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
 	wakeup_preempt(dst_rq, task, 0);
 }
 
-struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
-			    struct task_struct *p, int new_cpu);
-
 static inline
 bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
 {
-- 
2.53.0

