Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3864F55B8
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955926; cv=none; b=jj/UBBwtWICscOiW7V7DItWZKzUf7wbETEB34fgXngP3SzZTX9MUyUJSV4EpfD1X0XgQlYwlSQk1BnuNw+i8UD3NiTnqsomSDbefUYkVbTW6YWTAjSG9eFi+ZVJw9DDSO5qRyEGoY2iOVi9Vcem0YjgIN6N38I7aLwqoZqaVR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955926; c=relaxed/simple;
	bh=g8ii3PyBa0GiHh/9S+lqpPXalszN2DsJKkDUpSbsdmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmmP2cRivGQbcIy0Otzl0K+171iFUcx6wIu9RxO45/oRER98KMO/CMliPobyX/oIjCn3ejZMJABUwSQCmcDHlCz96wggQcTujIWio1SQlgzEXZxD5Y1Smu8te6UtyfkvC8jju3cj4f9zFrfHcO6hfB1xRTCggcbGExhFsY77L1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCt63O+h; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCt63O+h"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so261495e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955917; x=1791560717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nEo/LxwFi1EqrOkkcTTlEnXPhiZDemt/Tt2IhYFOTaI=;
        b=oCt63O+hGo7Ys7L58ABzIznQdFa1xPVXIVtaNv8aeEwxK5n6ff+zXBZnvp93ldnYqR
         327ehEAhnwGXUQpzckSSLYkzHXjgoUjLpYM5ILJlTfwmTmwVYhG8whjRevf2TZp36PWB
         zrAqgyDScubLuKiZ7BAG0m7nHm4M/XB98ViXAjeE1vC0nlBPmt19l0lyXO2k/Rw5IbOv
         yGHQUfibLhaQCOmYFW20Kb38SJDHYb+vlycDPD0dvC/t6Vx7vPtL3sYya4DWwhoFuh14
         jQftif9Sm1q1c2cYtVWlhsfpXVIbcbLHxZF8gkIcc2G9lOQMkWAmyaHu3DK/14pckp5D
         Fobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955917; x=1791560717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nEo/LxwFi1EqrOkkcTTlEnXPhiZDemt/Tt2IhYFOTaI=;
        b=gdTRarKB79kFL4nw79QkyMmV9MDguN53kTtVykbh4pHCu+zdJ54GKpOWrH6m89WVlP
         I5RYK+XbCSS6Mc17FKxgyrRclHNbO8bKpfLQZ8/FVbVhqvUGaRK+Ps0omkmzAPMrBgYF
         gyIEvQmCoDJrsyiyOpqNC3n0BG8gEid+MAxcA9FhaCJzqjeoxiGhpTq1UxL8yzd8g7vW
         6FONcbazylQyVAU9b5nUaVC5OObVHMnLVec8kM7mXBSd+Q8IfAOYaOIOe4HoYmc/bY54
         AtMtm7IdcVL6G/tvU0mHs70pkH6KKs3oaaJlOArqGoKiTBlYC6u0riFFx8Uti1MD+Q6X
         pnvA==
X-Forwarded-Encrypted: i=1; AKwUvBzI2SYhiMNcfhpexeoKcykSglT/nmEfd1WTh++skCJGbYIJXBDYB5fJ/P3BPg+UwijaeH0QGYBYnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m93i/UtcXC8QY1KTCbX7qpv5hqxawJ8Opt4bF9Ztco4kYUA1sz
	xQQhxqcZAJ5T5URUDMfQLQJ2GBY9b+uSmNjsWnZ1CbjncdfRkfAKhvP/EwSV+JgQJIE=
X-Gm-Gg: AYBFou0WX38h9f8Tk6xLvV3nArMCm5QUqF97YI1BG9PHGwFp7W9+SKYAfLx1UkT7Kof
	Y37qD8egyZ/RoOhSOV52GKyvuNcLCit1y/FZ8akeRbmINWYM4WJQMkTq0syivo5jw5PXQ5eTy/z
	nUBBXZjcSHTFXb8Q4gfC+0dPK+1X5qgxgdXVmn0amWYshVAn0W60wQDTJ9W9a9lUrw43/2BQtog
	yFV3iUkVUYzF88q9nMjDtVXB8ikdz89/b8zHuUmyNpj5awZjOrUjvv2oduVpl6XgKYQ9hmZ8lRw
	ArDTNyTTYFwiQ1q8qT/KrX3RQEreBVLlEjjEutvZACRcd4jNL5gIK3E9nnsqXJAHXPtdlK9Dmmo
	LdGHvI1Qb4OoXqg3aMKvPEn/zccTOwZslUo1ZlzK3PhH8gBFGSb8KrI/O/8Dy8pQm+E9Y45iyVt
	nlPI/stot6K/ekBhGu9LMHCZtP7LxRF5lqdeqkphAuXU1PYvFBocFz+0eo/LMLJP9M8aRNtNkMe
	zXQsLVRyTZdyw9GYZLMdk9JvIM=
X-Received: by 2002:a05:600c:4ecf:b0:49f:d087:6526 with SMTP id 5b1f17b1804b1-4a0276c616bmr60045805e9.34.1790955915970;
        Fri, 02 Oct 2026 08:45:15 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:15 -0700 (PDT)
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
Subject: [PATCH 09/18 v2] sched/core: Add rq flag to tick parameters
Date: Fri,  2 Oct 2026 17:44:06 +0200
Message-ID: <20261002154415.2270586-10-vincent.guittot@linaro.org>
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

In order to force migration in tick, we need to unlock the rq

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c      | 6 +++---
 kernel/sched/deadline.c  | 2 +-
 kernel/sched/ext/ext.c   | 2 +-
 kernel/sched/fair.c      | 2 +-
 kernel/sched/idle.c      | 2 +-
 kernel/sched/rt.c        | 2 +-
 kernel/sched/sched.h     | 2 +-
 kernel/sched/stop_task.c | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 837dc74c9a8d..1e34c8fdbee8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -923,7 +923,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, &rf, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -5800,7 +5800,7 @@ void sched_tick(void)
 	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
-	donor->sched_class->task_tick(rq, donor, 0);
+	donor->sched_class->task_tick(rq, donor, &rf, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
@@ -5896,7 +5896,7 @@ static void sched_tick_remote(struct work_struct *work)
 				u64 delta = rq_clock_task(rq) - curr->se.exec_start;
 				WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 30);
 			}
-			curr->sched_class->task_tick(rq, curr, 0);
+			curr->sched_class->task_tick(rq, curr, NULL, 0);
 
 			calc_load_nohz_remote(rq);
 		}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c0ebdcde5fe5..1f6bc63b3110 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2879,7 +2879,7 @@ static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_s
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued)
 {
 	update_curr_dl(rq);
 
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 53275bc7c029..cdf48af9f05e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3790,7 +3790,7 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct scx_sched *sch = scx_task_sched(curr);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6ba2efeba435..483ed5807dfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15346,7 +15346,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct sched_entity *se = &curr->se;
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 76f3c84ca684..1ba0303aacb4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -538,7 +538,7 @@ dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_idle(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	update_curr_idle(rq);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 1535046a23ff..35b3831a72cf 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2541,7 +2541,7 @@ static inline void watchdog(struct rq *rq, struct task_struct *p) { }
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
+static void task_tick_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 293f23620282..c1d7e04d2899 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2741,7 +2741,7 @@ struct sched_class {
 	 * sched_tick: rq->lock
 	 * sched_tick_remote: rq->lock
 	 */
-	void (*task_tick)(struct rq *rq, struct task_struct *p, int queued);
+	void (*task_tick)(struct rq *rq, struct task_struct *p, struct rq_flags *rf, int queued);
 	/*
 	 * sched_cgroup_fork: p->pi_lock
 	 */
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 1e0109ec36b3..3d99b23afd89 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -74,7 +74,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct t
  * and everything must be accessed through the @rq and @curr passed in
  * parameters.
  */
-static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_stop(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 }
 
-- 
2.53.0

