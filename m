Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978394;
	b=BzQ2/f/GvhS2oUDExOUIuvKJFcoUAQf1EU2FjX0yWNMwWuX17arffjlG32G2rl8yYPya
	 CeY+Ng89OAis0oX1E+xuXM0j/o5sHkNrc9I4J03KSJ9biUjz9xUIX6JzZQ2yoTpmD4U0c
	 ws3WMM9mmtIi2SjovU+BMqhQ6XFaf7f9WEOiNYST6i5JH0nG+Zxzn0rq/wux4OtQXTrC6
	 Goj94EahiVQddNGXe5D06L//OA1a8TwutRdcpAVXovfXFtQOQLUmyYwNeSrOQklPhB/UU
	 b57xGlQ2rC8UpAa8fFmzpXIJHjQtU30cQfKs/zs2XAYOp9dmZkQ5rAS8Mc1QWlnzw0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
	b=SJdZW8myhkq4pLkYk86p2eZtWJatdFo8eFPYzAi739PlzuNbf/+EUObq//aoTZw+GTHt
	 VGNptGLdE4gyKABn8yv/e5EKpwNDQCMiic8bDfpfGGmYz/ffn37MGWhLE/c+wWyh3hxCX
	 Au6zWvQEJzuEL3Gw6/5MZX8tZQXJWvm58iEFFk014eTPNe7jhz1HpE7cA8gcJ6Ib+2LWu
	 ydp096dAXvmq5w/3tLyibToNNgRT7RaV2dFVjxcq3kEuP1rHRfvtd3JVzDDxnH6rVCWIS
	 DU3B73XY0zA0+FW961Lck9g5ulJ9JveR951Ho2KCyzFliPRl1BU5n4b1WHDpkxJsfFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g8K158OZ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16447606A335
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16447606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=g8K158OZ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so7805515e9.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978392; x=1794583192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
        b=g8K158OZ23iDQti1eYSVQ5cpHwf65n3zh3k7KX4SMXxFadIzuE6o7AYd6w1tZla/r+
         fzoxaM0ppo91sy1Ubzo2L66F66OS65ERG5eglxUg5LSRokwTSf8N3qTU0VqbUOE8C9Ab
         oz1oEgZKDYmgCifvb4WHpFJGnTq403Qz7jHvO/mEunMfOl9cInOswOG6BoaMbV6XFwPo
         WFa4rNNMuk5uqWhjWJKlfzYxpbhEzPv/yiRPgPdXv5ghs+TgrTG87vEQFS0m8GOsIT3L
         n+ztF+3PjlEKSvcnI0T0k7hf84RsIz3rapm3W8Xn8Kt/Bc99DMaga6+KgEuRdi1+SrLb
         F4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978392; x=1794583192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8VT8bYUpBknJkW/DEKgzXQmlXEu+lCYZieExjd9raE=;
        b=patArMnNgiTrDMZ4WZcZDpEVDzkKiUaycVaGVZaHLtX5Sch7zwKnOd7TyxkiyGgvMN
         6MQvizKRNPne9vGZTO/5GeRboovm9EBoqoTSfLHaJ0h+lIskgKmF0wc/webhxq8fxylS
         yMysCMRD4jsPh+IWrNMd7Tl+u6oMQ9TN15xF3mK0k+0O6Zv8aCBKF9WR5KWeDKTLabds
         2zyHdkpq723zHnKw9TShmjiBmuto6B5D1+UFp798LXWyGK8TBjLYJJhdtb28TzQLPRfi
         JTv0RmXxtTsD1hmZ/6kcQXvBSozMXvn4OwQpdW79c/JjEY5CKKx6HaTTEDdvg/dfw1TC
         VPUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxaz+wWHy1SzvBFYmAmAi94StReNrOQkRSy2AzpfdXl+yiuxa65cTHmjOJdPWN/v/oYwKPeQxus2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8DghJyKBg0ApAEub5+5gwqDy4aRosP2sdQ9b++RL9YMR/g+EHF
	RN+Pp2Y2bqvVaplm/rMGx6A83th5Cq3dXrd9nkMwD+Brwzr5nmzUZ8TukcI9qxHydBQ=
X-Gm-Gg: AYBFou12Zjv2Pfq0HCFq1LdenNFRRIN1Wjyn1YgQPxxcqMg5IKlR5ZVh8yEuJkpuHT5
	Ruar42x5ZWwUkweypVgZ0mVbHYMd9JHtqmydgBXkdD7KCSHyovCcvxEyWl1UwDTpQ0VMqTN5fFg
	3JKK33ctO4M/RxtGStUEfzKe1fAC5ihDgDbQe/Ta5hZER3/3+kXFUKqtYOIwnLtptpxABs9u5Vs
	33tbKY0MUauwqyZrFZmfQRSm08ftA/55zwbAb93i9A6SmlLBb6s+gpPo6I7BY0mjVzEkD0IfG2R
	kHzvMfQ+YEWsvRBm19kdlDIj55eql0YcqioEHnpD3NMvjcB47kQNzGEy+lLUrI0693PvkXlnfro
	vfXgfcLoO/HNYWEKcaV47gvVE3qFgKmp+fizqmy0G8LsbFtAuXR6a0aGoiG4PKkSBFSwqkfSNVm
	W2kC4O7EvN1tuihpSeOE0OhAj/J6vG9TN9hYTljxglDxAvHAx/RxM+5kisEWKQLm5BRdkYFYKiq
	JPT3Fp1ssWGqN1WKBAvRq1fzaN9bkG21whpXMYpPviixMRV6i37i9vQNneF1B+c5Er+cgkY+1PV
	+xo+vhbfH0iDX0ud5kWqeGjWpAbO6dY0430k1OtG3kldAbReXxZjU0iBD4qurUZS7Ckf
X-Received: by 2002:a05:600c:64c5:b0:4a7:4697:dae3 with SMTP id 5b1f17b1804b1-4b6dfca2330mr52438285e9.24.1793978392407;
        Fri, 06 Nov 2026 07:19:52 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:19:51 -0800 (PST)
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
Subject: [PATCH 01/20 v3] sched/eevdf: Decay positive lag of sleeping entities
Date: Fri,  6 Nov 2026 16:19:28 +0100
Message-ID: <20261106151947.3991524-2-vincent.guittot@linaro.org>
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

Similarly to delayed dequeue, which enables an entity to decay its negative
lag while sleeping, a task should not keep a positive lag forever.

The sleep duration and the weight are used to decay the positive lag at
wakeup.

Apply the decay when enqueueing on prev rq for which we hold the lock to
get rq_clock_task().

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 124 ++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0feec172fd37..5cd171f830d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -897,6 +897,91 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return avruntime - vlag != se->vruntime;
 }
 
+/*
+ * Signed add and clamp on underflow.
+ *
+ * Explicitly do a load-store to ensure the intermediate value never hits
+ * memory. This allows lockless observations without ever seeing the negative
+ * values.
+ */
+#define add_positive(_ptr, _val) do {                           \
+	typeof(_ptr) ptr = (_ptr);                              \
+	__signed_scalar_typeof(*ptr) val = (_val);              \
+	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
+								\
+	res = var + val;                                        \
+								\
+	if (val < 0 && res > var)                               \
+		res = 0;                                        \
+								\
+	WRITE_ONCE(*ptr, res);                                  \
+} while (0)
+
+/*
+ * Remove and clamp on negative, from a local variable.
+ *
+ * A variant of sub_positive(), which does not use explicit load-store
+ * and is thus optimized for local variable updates.
+ */
+#define lsub_positive(_ptr, _val) do {				\
+	typeof(_ptr) ptr = (_ptr);				\
+	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
+} while (0)
+
+static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
+static unsigned long task_h_load(struct task_struct *p);
+
+static __always_inline
+void decay_entity_lag(struct cfs_rq *cfs_rq, struct task_struct *p, int flags)
+{
+	struct sched_entity *se = &p->se;
+	s64 delta_exec, vlag = se->vlag;
+	unsigned long cfs_load;
+	struct rq *rq;
+
+	WARN_ON_ONCE(se->on_rq);
+
+	/* Negative lag is managed by delayed dequeue path */
+	if (vlag <= 0)
+		return;
+
+	rq = rq_of(cfs_rq);
+
+	/* No fast access to prev rq task clock */
+	if (flags & ENQUEUE_MIGRATED)
+		return;
+
+	/* Compute sleep time */
+	delta_exec = rq_clock_task(rq) - se->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return;
+
+	/* For anything above ~4 seconds, save computation and clear the lag */
+	if (unlikely(delta_exec >> 32)) {
+		se->vlag = 0;
+		return;
+	}
+
+	/*
+	 * Use cfs' load and p's weight to estimate what would have been the
+	 * share for p. task's load contribution to cfs' load is replaced by
+	 * its weight.
+	 */
+	cfs_load = cfs_rq_load_avg(cfs_rq);
+	lsub_positive(&cfs_load, task_h_load(p));
+	if (cfs_load) {
+		unsigned long weight = scale_load_down(se->h_load.weight);
+
+		delta_exec *= weight;
+		delta_exec = div64_long(delta_exec, cfs_load + weight);
+	}
+
+	vlag -= calc_delta_fair(delta_exec, se);
+
+	/* vlag can't become neg while sleeping */
+	se->vlag = max(0, vlag);
+}
+
 /*
  * Entity is eligible once it received less service than it ought to have,
  * eg. lag >= 0.
@@ -4693,38 +4778,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	cfs_rq->nr_queued--;
 }
 
-/*
- * Signed add and clamp on underflow.
- *
- * Explicitly do a load-store to ensure the intermediate value never hits
- * memory. This allows lockless observations without ever seeing the negative
- * values.
- */
-#define add_positive(_ptr, _val) do {                           \
-	typeof(_ptr) ptr = (_ptr);                              \
-	__signed_scalar_typeof(*ptr) val = (_val);              \
-	typeof(*ptr) res, var = READ_ONCE(*ptr);                \
-								\
-	res = var + val;                                        \
-								\
-	if (val < 0 && res > var)                               \
-		res = 0;                                        \
-								\
-	WRITE_ONCE(*ptr, res);                                  \
-} while (0)
-
-/*
- * Remove and clamp on negative, from a local variable.
- *
- * A variant of sub_positive(), which does not use explicit load-store
- * and is thus optimized for local variable updates.
- */
-#define lsub_positive(_ptr, _val) do {				\
-	typeof(_ptr) ptr = (_ptr);				\
-	*ptr -= min_t(typeof(*ptr), *ptr, _val);		\
-} while (0)
-
-
 /*
  * Because of rounding, se->util_sum might ends up being +1 more than
  * cfs->util_sum. Although this is not a problem by itself, detaching
@@ -8152,7 +8205,7 @@ static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int task_wake = flags & ENQUEUE_WAKEUP;
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight;
@@ -8185,6 +8238,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_wake)
+		decay_entity_lag(cfs_rq, p, flags);
+
 	curr = (cfs_rq->curr == se);
 	/*
 	 * This can actually happen with CFS_BANDWIDTH, a task can be throttled
@@ -8225,7 +8281,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (!task_new)
+	if (task_wake)
 		check_update_overutilized_status(rq);
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.53.0

