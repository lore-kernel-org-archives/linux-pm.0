Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978412;
	b=2q3597TK7gCmELp892QJZe8H/0KqGbmWu9ajkszSN1+92phs2LYiuX3rVJ/I2t8NYkGj
	 KNmpy9fE7CNLAHJ73J+e9/tDXqR9+bcMYrz9/DtePDEJ2v4042ZH8D0MOjIoshMZLo7yh
	 QtvFSjFdZ3l9pPocFdNG3nbI7eDhFq8deYCco7IFv3uRzxkrQWgHIGR6t7+coxoQI3rAS
	 Z72K9fD+eK1XGS1IPqBQyXV38iYMb94prT1huPPVwELmbXHUk7IX/6BSWGww1uq8LKtj5
	 OvRLIJSrHW96ql9C/9fh7+vs3TYsm0Gs3YXgBYE5G7NQ3iMDUDM/Ai0o24vKGP8wANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
	b=NJW5wcy6Ydhezk8B4E0y0jpTLXRqQtcfqX1/LJh5RGSApSopZpfshWx8B0hcl7JQpHJq
	 S6gGKEN5WyopZIU/DLS3/goCVlRNVuQPzcPews0MkdWTqK90m1H1FIBWmmE++Fkssiyfz
	 C8khGM5IHqSrYLnguCY4x1jTDpNdUOlFyIxxRjXlj9CjTy4riGGwVlLQ6e6Kufz8UdsGC
	 L2SGMIOO08gqb/4lAZSZHoBJJvIp4EQvmobwVusj2l2T/RHPmYG+659XWcu+OFatVt+iK
	 RK5MQXY0cYIsClwpS/xVM9vgc7Fwy3HuYNEnCUcfM2cXV09gYKRaZOi0xAcnciziDYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VoXPf2oL;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724F606EEA6
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1724F606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VoXPf2oL
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so6421155e9.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978409; x=1794583209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
        b=VoXPf2oLIqYEZI6x2o/FPB+P+jCsne0NbS/8hF/6xoWC8KidTBYh0OXPYNf0lYyZXN
         B+7FpZbOyn5nazMbWuc8IvN2jyX81GRgGq+EjyLVm6wXuSGikqdrr4FOeXwacZTbo13L
         NueMFflSU190T17bE0s07fnoVmjyo8MOOI2xXyMy2bTUEdpz7UShDsUA+5LRFpQsPlIp
         aDjxGB9dF4J3yl/j55ftFNH+ITGAF40eFt1NrIK6ZaQU6jao06ZkUu9ZtDShsKeWt5Mn
         RPkcLFR5pBujDGtnfgFSdAw5LhfHNu3V8kMhvQAOuH386irx9HVRknGijfULx1iv+gbt
         O+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978409; x=1794583209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4qbyeG9eFUqyN+f4sUofqJ7pdB2mxcChsrdeY7rrJZg=;
        b=b76Z5MeIksJP1EnqkyJ4A2lU1qALnqY1HmZOi6W/IWRBW8oIxbpiHD9c4dv1+LErjA
         0yvAEC/IMUYQMR4v/b+12WMLP+cPQW3okfmH48qC/mlq6zdbLM9782P2jDuH3u79Orzv
         UZXvH5O0sYP01wIRCXhZd5NirttxE6QJs8+Plag4Cd4YwKM29cpXr7DQu+nbJ8E1NoYV
         MLP1RhW7muRqI9lIHOBjqih846p28L5ZgYrg80//7WnI9S2svaSssq9NJT1JFUK6moIx
         2R9tRY+En8ldURViPv+UB9wRQCFh+NuZxRZne8ujh0UciD+61BqevJPKWAXrYDKSPuwp
         QJ0A==
X-Forwarded-Encrypted: i=1; AKwUvBxpJ2o9mC1xfQGVQZlGRCxOjygnP8XaqTsR/kTy9pZMjoq9V2Q4zDHimNO61T5v1dQ1HdkltXg/0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/iG9LqxD0vmk4/88AHsgahmi3+kzTKzI+Zu4H3ivskcKonZkZH
	bUdezcdDUHpqTyO1/xVWl7Ujo2UP5bhap1FbHhdlLIcU6etphGHyP/ThiuiCSoek/OI=
X-Gm-Gg: AYBFou0vZgwaV9GcggPOMPQE8aSRNJrp9UOQ6O/fPGQz4Mg9Ud770ObglAjRQxWa3iY
	G7LXEBoIC4hLWaGjXOaLq4cdXFhs8FjVRQ4YGOR+prs33wCbZ6b2/+nYJWgPx7kgo2cwMLBaGgO
	EeE+e1mHo8myu85hAZIWBq1ZMV661KhwRAD1+d6LZTGl52gS2bYPWou3D2E5HdNxMDiFMD71eKo
	C7xinrv6ZD09b9FzYvRg3/TT03+D2UISxh3HeqC637qvH7DlbJNLasx67s5UUeYitRmF0Ei5S36
	8czYAG/XxGrLYUoAhqjD1V3Z+rQ8u1PM6abpAPzJxnrua4KorZkPkqlFAq1o5ngRfj/0eSisxaC
	Ti0uv0BhUNqrumgEqynBq5GgMjAeC+WadwTdHnPdaI2WhYEC4bLJRNWvzRnrewBhIqBjbX0Z1sY
	OSqugLV4LqFTJPrl2xuBxodfA5W7dHMxZpdwBssVR3jUYm330++hAtVzM3isB3oJmnm7EdWJvIb
	Qjrqd4P02yZ9q3CuaJ0SdlaVH+3sGAvmDnrTjLHEF2yHj7ugC/1/uuFdbsnMnbssrhk8ph9hIG9
	PgreU3dlTfi01tH0Zn+dlHeT6uHvE5eWxmigqGdvZSqjx5w=
X-Received: by 2002:a05:600c:8b28:b0:4a1:a2c0:7b73 with SMTP id 5b1f17b1804b1-4b6dfba8628mr43728685e9.30.1793978409162;
        Fri, 06 Nov 2026 07:20:09 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:08 -0800 (PST)
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
Subject: [PATCH 10/20 v3] sched/core: Add rq flag to tick parameters
Date: Fri,  6 Nov 2026 16:19:37 +0100
Message-ID: <20261106151947.3991524-11-vincent.guittot@linaro.org>
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
index d71da9069218..a1a3aa45ecf6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -923,7 +923,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, &rf, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -5857,7 +5857,7 @@ void sched_tick(void)
 	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
 		resched_curr(rq);
 
-	donor->sched_class->task_tick(rq, donor, 0);
+	donor->sched_class->task_tick(rq, donor, &rf, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
@@ -5953,7 +5953,7 @@ static void sched_tick_remote(struct work_struct *work)
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
index 0403c4634281..8728e394d4fb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3822,7 +3822,7 @@ void scx_tick(struct rq *rq)
 	update_other_load_avgs(rq);
 }
 
-static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
+static void task_tick_scx(struct rq *rq, struct task_struct *curr, struct rq_flags *rf, int queued)
 {
 	struct scx_sched *sch = scx_task_sched(curr);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2999d3f88e4..3bcb663ebcde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -15686,7 +15686,7 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr) {}
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
index b88857dd3941..95a18c0d21c6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2751,7 +2751,7 @@ struct sched_class {
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

