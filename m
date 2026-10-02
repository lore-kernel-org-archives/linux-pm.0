Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B194495ACF
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955908; cv=none; b=BT0c8SajM8JWX8WiKHsdBCVc/USF7ZuxfG4oJUK3qYOG++6Lz0PLtwuCrCSRk9C6PTBKsVy5dfhn+GVn820S8u34QtZcl0JoYvxs+PTe1zRPawY2euY1xd00s7oBotv/IE5rqllBPqsPWfP+2j+NrteRG3d2B6OZiQPqbEdmcYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955908; c=relaxed/simple;
	bh=mqcr69n+Cki+W9shlrgvILn8znvb3ow0aMd43jWczjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAA2o0aWbLSVYPUXzUnCi6BdjQJH5NAHQx10U3EiJIbiL8PLXXlcYvjettOGjTLBbxbUWI6TPqqfTahEdDjgcRbalEoF4N0LGkG3BsoDXHn1t77lumvlmjbYVB1CXs9sXr+EtUgQIjjntDFqDo6SzSf4y9Mqq0d2rUZy5IvjE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jea4L/F9; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jea4L/F9"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso423125e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955904; x=1791560704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a8shURt70eLGsxqpmwK6tNDdH4TKn99x5ZtIeJ/6eoc=;
        b=Jea4L/F9KkLMqP8MfoclZPMkoNv6wS5GriQB0bxaFLR79R/Q6qQoQS5DwTQz/YhIyH
         VGvqHb+iKhaFYjg1mngmRW1lzUfbpA3clITHZbemzdBbtbiEQPZ/TJwT9gQVdGnVnI4q
         hKUjZTC0BrJr/rr6x/ai/4eU9tsNtgm4O06L9IeR6UO1HmcWj9EotCOO54QffOE4LGcU
         uQbi4QuiW6PjNQbIx1MW4HBw7Bq4GGvFz3NZX0mAHTkbfo9yAeVz60hCZdfIHjpxAFzg
         0NPS64Tv23igOggS9bRxWgfece/rPq20rhwsabl8e87f+JjzGM9XIpPk+7HnnMF8DK7f
         pHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955904; x=1791560704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a8shURt70eLGsxqpmwK6tNDdH4TKn99x5ZtIeJ/6eoc=;
        b=r9GyGbGJ9ADSqwRgkzXuLNegSZivzAkYuMc40HituV50g+QTdvhk4kJk0DnfoowunE
         CYK/FvSxkub3oaJk1gINbkSbi8OQJcNvGLc2xGn3rPmJltMuZqfZ8yM+j7IzYb0+878D
         RKcT+e3My0xYl7LNL+ImFjk9EwPPm2e5OfD77KONAASy1Q/rRrhOLGESEyP5yxtFT02f
         5T0/DuIzjcwtbpgtjmDCbm7zwx8DV0oYl2hBZqsRZiUdD3m3flB00AaqSAebc1B9lbPx
         P8bq4GfCtw8rs2U3X1VI3uV963xL9y8eBBOOM+fzuaFXgqFUSWFcD2oez7lCYaTCKFBx
         zTzA==
X-Forwarded-Encrypted: i=1; AKwUvBzwQ2PbW/psIwyo/EXb/1utzhCwtJjO7RBRfHSvzZ4bVtrQ6kOY60Z0FhQ7QC+zcSOZAfp5FDiDTw==@vger.kernel.org
X-Gm-Message-State: AFuF++l26jf82TIX/YLzm6oKVUAPeUvaTBCJtqCGQipANGG+17afu5gq
	MWhXZhjXroJQJy5zKH1KsPfPA9IK3ShUtJ4SpNUHCFy3dNd1aEv3AI2G96Lj9DAVb6U=
X-Gm-Gg: AYBFou1iwCrFxz1gzwRgLPJu5wRRxMOo7UbhgmSEspBq3ViXegZdgwtJLaSz1u9odnS
	VjbORR9ffUi4vq4lXfFdZDQveXwk18zyXQIuMVumcNsoBhVZL9991YBkgDctqAYFdQBnmNcCRgN
	kHF3KdZRLrepoW+8Pc/uUrOtliA2HtLDmSoovYjN4PQZYVmy6oO9T9tOEid0KvZ3Mfp7vR2I0l1
	h2CyR2Z1LO4fq3o1WgaazLTgNyQy2WR6+vSZyPpenhsF6nBMmQMVUAdBDxR03ohUbIyZe+9U92r
	p8TZ4bVAhI4TqzBhWWS9C4qftrWGAnilliBXkpv+YvSzQ8lO7vzZfvbwwKxz3s6oBQaAli/P8dv
	lt68mKllcq+fwcMYA/f+08sUS4KXFFoANH2B7VVre9e7qFOBqDkhFEhJoDEcC7sv3s2bJqUDY87
	cY+PF0fTyPdKlaOAU69PWAWf/1JbwAGJNuGAxVqFMdrJd8GPTPzO8wKl0rrWbfPwvE0X8eof6/v
	oOPFCgQoa43osGB
X-Received: by 2002:a05:600c:6092:b0:4a0:20c7:6d4c with SMTP id 5b1f17b1804b1-4a027452eb0mr57787735e9.0.1790955904125;
        Fri, 02 Oct 2026 08:45:04 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:03 -0700 (PDT)
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
Subject: [PATCH 01/18 v2] sched/eevdf: Decay positive lag of sleeping entities
Date: Fri,  2 Oct 2026 17:43:58 +0200
Message-ID: <20261002154415.2270586-2-vincent.guittot@linaro.org>
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

Similarly to delayed dequeue that enables an entity to decay its negative
lag while sleeping, a task should not keep a positive lag forever.

The sleep duration and the weight of the entity is used to decay the
positive lag at wakeup.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 51 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03206e15e6fe..8cda1d39b037 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -897,6 +897,51 @@ bool update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return avruntime - vlag != se->vruntime;
 }
 
+static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq);
+
+static __always_inline
+void decay_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+	s64 delta_exec, vlag = se->vlag;
+	unsigned long cfs_load;
+	struct rq *rq;
+
+	WARN_ON_ONCE(se->on_rq);
+
+	/* Negative lag implies delayed dequeue */
+	if (vlag <= 0)
+		return;
+
+	rq = rq_of(cfs_rq);
+
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
+	cfs_load = cfs_rq_load_avg(cfs_rq);
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
@@ -7987,7 +8032,7 @@ static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
+	int task_wake = flags & ENQUEUE_WAKEUP;
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight;
@@ -8019,6 +8064,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
+	if (task_wake)
+		decay_entity_lag(cfs_rq, se, flags);
 
 	if (se->on_rq && se->sched_delayed)
 		requeue_delayed_entity(cfs_rq, se);
@@ -8048,7 +8095,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (!task_new)
+	if (task_wake)
 		check_update_overutilized_status(rq);
 
 	assert_list_leaf_cfs_rq(rq);
-- 
2.53.0

