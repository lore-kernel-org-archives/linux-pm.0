Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8441B340
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676391; cv=none; b=rSiQTmf2t3VaWr/Py+H2+O0Vl+0WOV5rCNvWs9JfPixH6dx7TGkV/6u5tml6DM0glblVClWOn7S1EHgWeDo1x31PO7B/jvg22Wui8jfYJp7U4W2ml1dfd6SdIUwN1ybQAlQ6NssNgdpQfLS+bDFQopOIvmnd0tPtWri8pSXPw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676391; c=relaxed/simple;
	bh=F819HVJfVVEbUn1eomfSOkkaw5nwB8PAG2EEKY+pEm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2xUGHHcHRu9druxw8/sikFDz8LUWtJ8HIe78c9fO4wrSv4+yt5UzkFzisM7mBSSvcZ7/gjJVXTpYQvLOpU2S6TVvZCOtWTgsON3BZzP1qFpg4H65QFbLm2fFBbLW4VoZcTF+IOTQdUYcB3ai+91prgiMJkyRhFYs4G1HIXnYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zsLXjbp1; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsLXjbp1"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1860558fso4331620f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778676388; x=1779281188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c7eU4JPhtw1c7hjc4A2hrzIBeAUh0u29gCDSXvZHjqc=;
        b=zsLXjbp1d09isor2PKaVSUo7JiVX/+Gb+Jz/os/G8+hDOvyFKBR5SRMsTwa69O9IXu
         em1ZoTX05h+yNGQKLye3ZfFOVEQdwZCergXo7umptWlfZcyyTmtX6/29b0HcM6D9CAWf
         6UxseizGqha2grXzCzdGiCFqFtNw78nyHxvvl8ZKt+aO2TxaJ7vlNBK6yXC2EmLdhzXa
         vyKCZdqcQ+y0OSGX+Qx27bbBieZwUIwK9zM7xNKCGcvhzF5DGNpaCb1PfIRNBGppJW3+
         oU1SP1J8Yk70eFKVXlX2/zj4LLDcHvcWMGLiK0N+MT7i47IymRm85TeaN2gYbtre+o2p
         dNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676388; x=1779281188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7eU4JPhtw1c7hjc4A2hrzIBeAUh0u29gCDSXvZHjqc=;
        b=XGmmX+3Q2flrHz9H9g1wUN3h6ultlj+12grEh3Y5xcfWAjURxuCZl4Ml7UtmSmvIRG
         Dd/Ixu/1/NXxFVTya2WX3rRccjTlib7Xh3/ybWnXTlca9dAXaHh6VyDosF6zatS5KaXn
         K3Q9LnV1wT2RV5JrqVKII5yE4xcnlsi2rnYPCxZFay9xIq7GHwEJIIIfYOB+m2oZTs5A
         uF7grrOP7PxAK+Q2/2KCOxZxZL8kBYLbGi/Ao+sBy06hjeO/Mc43rh58DBVvjg7t0Q4y
         ZlnxyiSUkMh5+Pu8IHnXaTQqli1xpgj4ghEhf+mWaFByj7CKhoHAj1UBpVglkm/yPUFx
         Nl6A==
X-Forwarded-Encrypted: i=1; AFNElJ8FjVR4LB2EBlGnNRr7fBCRNIah5xzyxbcKilTNz4N3BehWWM79gIm8eMSkBh1b5k31bvmk2Q+fDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDLjrpnJwG5X6maaLR4DhZcPpMeLjpNUxNi1O4N/HK+U5LQd3
	O7HYhdP2Znmaqjzb2nsEEPi24UNCLkmnfmO7H58WceQ2PzYyj+VqFZiXFoM+uTBV0I4=
X-Gm-Gg: Acq92OFl/mpveC3Z+5YUKGw18E47EPhln24U07hDBIwjVh7UF6jd84SSa/aobQysl97
	GqLvCUA9pWNRLPaXz+HNsPgvAkmUF0yT0LaNqHBB9Iz42NYWFruhTxafSkNNABF/AJzxkBF0Cfm
	63H0RMJJbRHWi025UFkCs7hvhNdDizNzJb5DJSuV0qlmAuOuXrs6Nw0T/KdmNSnITziLTNeiIkB
	t+GWUaW9v5nBJS2o9Q1/AYYE6pH8WX7z8jILMEciRVPFwa2r/ktloo5bxXQsOKiFajql4NRHQYN
	pAgIP2XWERMkrlyxZK2xeI+uGaz1FiUek5GEG9gPnpdifr1gZx6W3yJvoQnIYMS+n/DOX4cE5GV
	vzXoFbT+lOGgwUakhzQe0hvype1vIUZq7Beu/wJT7yFeJlC6+TH5QFloVBSJ3egSzgPhyzlpLLJ
	FugloREZkFkhL8gybkmwxWj9p7t9i7hw==
X-Received: by 2002:a5d:5f82:0:b0:449:4079:4c39 with SMTP id ffacd0b85a97d-45c5a1a791bmr5023036f8f.29.1778676387540;
        Wed, 13 May 2026 05:46:27 -0700 (PDT)
Received: from vingu-cube ([2a01:e0a:f:6020:1b29:23a9:fb39:a3cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm39668569f8f.0.2026.05.13.05.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:46:26 -0700 (PDT)
Date: Wed, 13 May 2026 14:46:25 +0200
From: Vincent Guittot <vincent.guittot@linaro.org>
To: John Stultz <jstultz@google.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Call update_util_est() after
 dequeue_entities()
Message-ID: <agRyoe1wHyZ-vMk9@vingu-cube>
References: <20260512124653.305275-1-qyousef@layalina.io>
 <CANDhNCqRU1paGDQPK8nHEA-yejxBm5ATPrNzvqSfnzU09Xk_7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqRU1paGDQPK8nHEA-yejxBm5ATPrNzvqSfnzU09Xk_7Q@mail.gmail.com>

Le mardi 12 mai 2026 à 13:52:09 (-0700), John Stultz a écrit :
> On Tue, May 12, 2026 at 5:47 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > update_util_est() reads task_util() at dequeue which is updated in
> > dequeue_entities(). To read the accurate util_avg at dequeue, make sure
> > to do the read after load_avg is updated in dequeue_entities().
> >
> > util_est for a periodic task before
> >
> >                                 periodic-3114 util_est.enqueued running
> >    ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
> > 183┤                ▖▗  ▐▖         ▖ ▗▙   ▗   ▗▙▖▖       ▖▖   ▖       ▖▖        ▗  ▟  ▗▄▖          │
> > 139┤               ▐▛█▜▙▞▀▄▄▞▚▄▟█▞▙█▄▟▀▚▄▄▞▚▄▄▟▀▀▛▄▝▄▄▄▙█▛▛█▛▜▛▄▄▀▄█▙▛▛▛▙▄▀▄▄▖▜▄▟█▟▀▜▟▄▜▀▄▄▟▙▖     │
> >  95┤              ▐▀    ▘   ▝   ▝        ▝▘        ▘   ▘▘       ▝▘       ▝▘  ▝    ▝        ▀       │
> >    │              ▛                                                                                │
> >  51┤             ▐▘                                                                                │
> >   7┤      ▖▗▗  ▗▄▐                                                                                 │
> >    └┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬┘
> >   0.00      0.65       1.30      1.96       2.61      3.26       3.91      4.57       5.22     5.87
> >
> > and after
> >
> >                                  periodic-2977 util_est.enqueued running
> >      ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
> > 157.0┤               ▙▄ ▗▄  ▗▄▄▄ ▗▄  ▗▄▄▄▗▄▄  ▗▄▄▖ ▄   ▄▄▄   ▄  ▄▖▖  ▄▄▄▄▄▖▖▝▙▄▄▄▄▄▄▖ ▗▄           │
> > 119.5┤             ▗▄▌▘▀▀ ▀▀▀ ▝▀▀▘▝▀▀▀ ▝▀▘ ▝▀▀▘ ▀▝▀▘▀▀▀▘▝▀▀▀▀▀▀▀▘▝▝▀▀ ▀   ▝▝▀  ▀   ▀▀▀▀            │
> >  82.0┤             ▟                                                                               │
> >      │             ▌                                                                               │
> >  44.5┤             ▌                                                                               │
> >   7.0┤      ▗   ▗▖ ▌                                                                               │
> >      └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
> >     0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.56      5.21     5.86
> >
> > Note how the signal is noisier and can peak to 183 vs 157 now.
> >
> > Fixes: b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >
> > This is split from [1] series where I stumbled upon this problem. AFAICS it
> > needs backporting all the way to 6.12 LTS.
> >
> > [1] https://lore.kernel.org/lkml/20260504020003.71306-1-qyousef@layalina.io/
> >
> >  kernel/sched/fair.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 728965851842..96ba97e5f4ae 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7401,6 +7401,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >   */
> >  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> > +       int ret;
> > +
> >         if (task_is_throttled(p)) {
> >                 dequeue_throttled_task(p, flags);
> >                 return true;
> > @@ -7409,8 +7411,9 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >         if (!p->se.sched_delayed)
> >                 util_est_dequeue(&rq->cfs, p);
> >
> > +       ret = dequeue_entities(rq, &p->se, flags);
> >         util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> > -       if (dequeue_entities(rq, &p->se, flags) < 0)
> 
> Hrm, so the Sashiko tool raised a reasonable concern on the earlier
> version of this:
>   https://sashiko.dev/#/patchset/20260504020003.71306-1-qyousef%40layalina.io?part=12

Even without sashiko, this is what the comment says just below in the function ;-)

Below is a different way to fix it which also covers cases when we have both
DEQUEUE_SLEEP and DEQUEUE_DELAYED

---
 kernel/sched/fair.c | 189 ++++++++++++++++++++++----------------------
 1 file changed, 93 insertions(+), 96 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c83fbe4e88c1..0976adc12594 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5120,13 +5120,87 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
@@ -5169,6 +5243,9 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		if (flags & UPDATE_TG)
 			update_tg_load_avg(cfs_rq);
 	}
+
+	if (flags & UPDATE_UTIL_EST)
+		util_est_update(se);
 }

 /*
@@ -5227,11 +5304,6 @@ static inline unsigned long task_util(struct task_struct *p)
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
@@ -5274,88 +5346,6 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
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
@@ -5828,7 +5818,7 @@ static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool sleep = flags & DEQUEUE_SLEEP;
-	int action = UPDATE_TG;
+	int action = 0;

 	update_curr(cfs_rq);
 	clear_buddies(cfs_rq, se);
@@ -5848,15 +5838,23 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)

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
@@ -7628,7 +7626,6 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);

-	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;

--
2.43.0




> 
> Specifically, we shouldn't reference p after dequeue_entities() or we
> risk racing with it being woken up, running, and maybe exiting on
> another cpu.
> And this moves the util_est_updat() call to after dequeue finishes.
> 
> Maybe there's some way to have util_est_update() compensate for the
> unfinished accounting that will be done in dequeue_entities()?
> 
> thanks
> -john
