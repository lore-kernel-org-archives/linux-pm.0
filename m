Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196015CD7E
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809872; cv=none; b=LoerHcJw/YiXKxyCRKdxI/iFkG5oOVW1XktbJzHYa3g5rVBLjPRvcL3atG27uIcFV8af61fafywlQLE4p45qo5MZxC7vdod1lJhwSg+Sfh2WPAnneczZFUKIcj0BnFRQbuZIJlf+jlTSzpfBvUZw/qEW4W8cEKhfvBKDtGArqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809872; c=relaxed/simple;
	bh=da9x2UQs6nwzzUg39HdIg9yvtfaggKdmyVqHkyu09cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stDFcgd4vORz8JJxJSDD/SIUjDC8eM/HpGq8Hqktxon7Ese7ix1zFSQGw3UDpCbNpt54M+Ts3ec1XdGQXPSfh6NLf42q7IuRcmBlk6S8EGhTV3/lNbMGEHnIHUMA1ee/+XTHLQqGIAFmNKfOEfrnoaZ+dNh6WwFcUGnr2VqCyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=u2qK6vT9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="u2qK6vT9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso77527165e9.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778809868; x=1779414668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSE2fHvcsYkXCPQL3z/UDGo46iU1Vsr1oVZT9CMtGLY=;
        b=u2qK6vT9urr3DI+EbTCTdILsdaub6f1izNFR687+rjmS1uk0ivx6pli8u2cTgW8KaX
         jWT7dUAcjfn2ZIZu0mwBjeJIQP75I2h82jNBUXIv6U0uGKZke3lZbGzNVm06fNpKG56x
         M9DFnzZte2+UVBB6dG76n85onrxsizTigdOE7IQPZzEYw49bMtNzcfiQKVt1vZSQnoyX
         eNclN3tcz46VB3R/TQniri4FR6Dp2XSQB3fis8i7XN6FgptOGKDPngqYPM79nxgaFiFK
         2KcCLQcimULgmLSAhXMjuT1PVBgw2+bWxHhAElO+ow5gmY/xec3R3m8ThdHcFumMRk0F
         TTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778809868; x=1779414668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSE2fHvcsYkXCPQL3z/UDGo46iU1Vsr1oVZT9CMtGLY=;
        b=bJ3pszJryJZcTK4KavGcjNFZrEFGZrZaaCoGifRtgx8ictcMcIk/m55amO2ZYgycNJ
         Z+hq4eS3fxN0LNX9JQGZtaVn2QjrWD4X9Bt+7ItIaV4zvs93ohQTfRJ3dwYADh4U86bQ
         ryGiyYZ0u93vDbORxIQY7AwofnLiwwbruSON5XgxJPDl6J8v7HrapXz8Oo654hpVHmVG
         UwPrF3FW4PgpnXaJmsyH5Z1+MA+i6Yqj2oV1bhI06ld714SeGW1P7BdBUQyato9SVtQ7
         fyIu2D+0udsnrXHyC/mR3z/q3yIesjQ1UkfQpBFgOuy8eRHx501lu98x+MMI1QlI03E2
         /DUw==
X-Forwarded-Encrypted: i=1; AFNElJ+LI6t7iEcC2CpzjLa3qWTvdxay1ENJqA604/KVHw+WK9cMShTBAQs7URdgRY8qBCpM8D1xYzSymQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxymIem0zUuhgRVrzwuRrnwJ9SFvuXYc2E25BLwNEKN5UoA9867
	5oZ+6aP/5z6FDcudL+DNWzgBeyBPfL4PaUGr1MjMRAxPHAf9X1IZ+EQgC5OSgHgW/VQ=
X-Gm-Gg: Acq92OHnqNOHYDsAq7No7fTihTJIornkb4KaqX1w+dF6th/oCYnQH9IXeZUVTZMeiAm
	+JSECo4ZjPzSsVvVPzNxi0ucRcsgI2kgfHZmTvGwJZCHSw0ZYBwtHi/mff8CdqK9mqDHOZTs4d/
	JIQP/xuOAelNrpNhYtQltdKcK25WN1/xuLbtTOIHHtepIruelSfqUTa/lJZJyPhwa57awpiB1cv
	7mqKCXYwt4CfMtARoGEPAaS/yZvrdP2jqUIAPnF8RewKkhNfSPPi7dkziW4WPVEgHdSR4bQPRmi
	ufHTNecrhFqVV7Ovh1j1gCl+krhi3Q4a3tTP2saAB/J+I6N/PX1Al4t9Y7NXVExl99Hqo8uR2d3
	IpbwKtCE5YuUYvzXDvXiM5doppNrUvNhITW9kAc0W1YVAdGDA9TYLIWKsdmbvDG6iOJ7Gun1Vtf
	ilsYXTIvb3GcxTnLAt
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-48fe632663emr24703935e9.18.1778809868087;
        Thu, 14 May 2026 18:51:08 -0700 (PDT)
Received: from airbuntu ([185.253.98.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c885d5sm24867135e9.5.2026.05.14.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 18:51:07 -0700 (PDT)
Date: Fri, 15 May 2026 02:51:05 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20260515015105.2dmiy7wqpzdg25wt@airbuntu>
References: <20260512124653.305275-1-qyousef@layalina.io>
 <CANDhNCqRU1paGDQPK8nHEA-yejxBm5ATPrNzvqSfnzU09Xk_7Q@mail.gmail.com>
 <agRyoe1wHyZ-vMk9@vingu-cube>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agRyoe1wHyZ-vMk9@vingu-cube>

On 05/13/26 14:46, Vincent Guittot wrote:
> Le mardi 12 mai 2026 à 13:52:09 (-0700), John Stultz a écrit :
> > On Tue, May 12, 2026 at 5:47 AM Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > update_util_est() reads task_util() at dequeue which is updated in
> > > dequeue_entities(). To read the accurate util_avg at dequeue, make sure
> > > to do the read after load_avg is updated in dequeue_entities().
> > >
> > > util_est for a periodic task before
> > >
> > >                                 periodic-3114 util_est.enqueued running
> > >    ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
> > > 183┤                ▖▗  ▐▖         ▖ ▗▙   ▗   ▗▙▖▖       ▖▖   ▖       ▖▖        ▗  ▟  ▗▄▖          │
> > > 139┤               ▐▛█▜▙▞▀▄▄▞▚▄▟█▞▙█▄▟▀▚▄▄▞▚▄▄▟▀▀▛▄▝▄▄▄▙█▛▛█▛▜▛▄▄▀▄█▙▛▛▛▙▄▀▄▄▖▜▄▟█▟▀▜▟▄▜▀▄▄▟▙▖     │
> > >  95┤              ▐▀    ▘   ▝   ▝        ▝▘        ▘   ▘▘       ▝▘       ▝▘  ▝    ▝        ▀       │
> > >    │              ▛                                                                                │
> > >  51┤             ▐▘                                                                                │
> > >   7┤      ▖▗▗  ▗▄▐                                                                                 │
> > >    └┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬┘
> > >   0.00      0.65       1.30      1.96       2.61      3.26       3.91      4.57       5.22     5.87
> > >
> > > and after
> > >
> > >                                  periodic-2977 util_est.enqueued running
> > >      ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
> > > 157.0┤               ▙▄ ▗▄  ▗▄▄▄ ▗▄  ▗▄▄▄▗▄▄  ▗▄▄▖ ▄   ▄▄▄   ▄  ▄▖▖  ▄▄▄▄▄▖▖▝▙▄▄▄▄▄▄▖ ▗▄           │
> > > 119.5┤             ▗▄▌▘▀▀ ▀▀▀ ▝▀▀▘▝▀▀▀ ▝▀▘ ▝▀▀▘ ▀▝▀▘▀▀▀▘▝▀▀▀▀▀▀▀▘▝▝▀▀ ▀   ▝▝▀  ▀   ▀▀▀▀            │
> > >  82.0┤             ▟                                                                               │
> > >      │             ▌                                                                               │
> > >  44.5┤             ▌                                                                               │
> > >   7.0┤      ▗   ▗▖ ▌                                                                               │
> > >      └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
> > >     0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.56      5.21     5.86
> > >
> > > Note how the signal is noisier and can peak to 183 vs 157 now.
> > >
> > > Fixes: b55945c500c5 ("sched: Fix pick_next_task_fair() vs try_to_wake_up() race")
> > > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > > ---
> > >
> > > This is split from [1] series where I stumbled upon this problem. AFAICS it
> > > needs backporting all the way to 6.12 LTS.
> > >
> > > [1] https://lore.kernel.org/lkml/20260504020003.71306-1-qyousef@layalina.io/
> > >
> > >  kernel/sched/fair.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 728965851842..96ba97e5f4ae 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7401,6 +7401,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> > >   */
> > >  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  {
> > > +       int ret;
> > > +
> > >         if (task_is_throttled(p)) {
> > >                 dequeue_throttled_task(p, flags);
> > >                 return true;
> > > @@ -7409,8 +7411,9 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >         if (!p->se.sched_delayed)
> > >                 util_est_dequeue(&rq->cfs, p);
> > >
> > > +       ret = dequeue_entities(rq, &p->se, flags);
> > >         util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> > > -       if (dequeue_entities(rq, &p->se, flags) < 0)
> > 
> > Hrm, so the Sashiko tool raised a reasonable concern on the earlier
> > version of this:
> >   https://sashiko.dev/#/patchset/20260504020003.71306-1-qyousef%40layalina.io?part=12
> 
> Even without sashiko, this is what the comment says just below in the function ;-)

Yeah I read it but it didn't really register properly :-)

> 
> Below is a different way to fix it which also covers cases when we have both
> DEQUEUE_SLEEP and DEQUEUE_DELAYED

Works for me. It looks even more stable now

util_avg

                                    periodic-2737 util_avg running
   ┌───────────────────────────────────────────────────────────────────────────────────────────────┐
140┤               ▟▟█▄▄██▙▄▟▟▙▙▟█▟▄▟▟▟▄▄██▄▟▙█▙▄▙█▙▄█▙▙▄▙▙▙█▟█▄▟▟▟▄▟█▟▟▄██▄▙█▟▟▄▟██▄              │
105┤              ▄██████████████████████████████████████████████████████████████████              │
 70┤             ▗▛▘                                                                               │
   │             ▐▘                                                                                │
 35┤             █                                                                                 │
  0┤       ▖   ▗▄▌                                                                                 │
   └┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬──────────┬─────────┬┘
  0.00      0.65       1.30      1.95       2.60      3.25       3.90      4.55       5.20     5.85

and util_eset

                                 periodic-2737 util_est.enqueued running
     ┌─────────────────────────────────────────────────────────────────────────────────────────────┐
140.0┤               ▞▀▀▀▀▀▀▀▀▀▀▀▀▀▜▀▀▀▜▀▀▀▀▀▀▀▀▜▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜▀▀▀▀▀▀▜▛▀▀▀▛▀▀▀▀▀▀▀▀▀▘             │
106.8┤              ▝▘                                                                             │
 73.5┤             ▗▘                                                                              │
     │             ▗                                                                               │
 40.2┤             ▖                                                                               │
  7.0┤       ▖   ▄▗▖                                                                               │
     └┬─────────┬─────────┬──────────┬─────────┬─────────┬─────────┬──────────┬─────────┬─────────┬┘
    0.00      0.65      1.30       1.95      2.60      3.25      3.90       4.55      5.20     5.85

Do you want to send a proper patch? Feel free to stick my
reviewed-and-tested-by.

Thanks!

> 
> ---
>  kernel/sched/fair.c | 189 ++++++++++++++++++++++----------------------
>  1 file changed, 93 insertions(+), 96 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c83fbe4e88c1..0976adc12594 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5120,13 +5120,87 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	trace_pelt_cfs_tp(cfs_rq);
>  }
> 
> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> +
> +static inline void util_est_update(struct sched_entity *se)
> +{
> +	unsigned int ewma, dequeued, last_ewma_diff;
> +
> +	if (!sched_feat(UTIL_EST))
> +		return;
> +
> +	/* Get current estimate of utilization */
> +	ewma = READ_ONCE(se->avg.util_est);
> +
> +	/*
> +	 * If the PELT values haven't changed since enqueue time,
> +	 * skip the util_est update.
> +	 */
> +	if (ewma & UTIL_AVG_UNCHANGED)
> +		return;
> +
> +	/* Get utilization at dequeue */
> +	dequeued = READ_ONCE(se->avg.util_avg);
> +
> +	/*
> +	 * Reset EWMA on utilization increases, the moving average is used only
> +	 * to smooth utilization decreases.
> +	 */
> +	if (ewma <= dequeued) {
> +		ewma = dequeued;
> +		goto done;
> +	}
> +
> +	/*
> +	 * Skip update of task's estimated utilization when its members are
> +	 * already ~1% close to its last activation value.
> +	 */
> +	last_ewma_diff = ewma - dequeued;
> +	if (last_ewma_diff < UTIL_EST_MARGIN)
> +		goto done;
> +
> +	/*
> +	 * To avoid underestimate of task utilization, skip updates of EWMA if
> +	 * we cannot grant that thread got all CPU time it wanted.
> +	 */
> +	if ((dequeued + UTIL_EST_MARGIN) < READ_ONCE(se->avg.runnable_avg))
> +		goto done;
> +
> +
> +	/*
> +	 * Update Task's estimated utilization
> +	 *
> +	 * When *p completes an activation we can consolidate another sample
> +	 * of the task size. This is done by using this value to update the
> +	 * Exponential Weighted Moving Average (EWMA):
> +	 *
> +	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
> +	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
> +	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> +	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
> +	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
> +	 *
> +	 * Where 'w' is the weight of new samples, which is configured to be
> +	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
> +	 */
> +	ewma <<= UTIL_EST_WEIGHT_SHIFT;
> +	ewma  -= last_ewma_diff;
> +	ewma >>= UTIL_EST_WEIGHT_SHIFT;
> +done:
> +	ewma |= UTIL_AVG_UNCHANGED;
> +	WRITE_ONCE(se->avg.util_est, ewma);
> +
> +	trace_sched_util_est_se_tp(se);
> +}
> +
>  /*
>   * Optional action to be done while updating the load average
>   */
> -#define UPDATE_TG	0x1
> -#define SKIP_AGE_LOAD	0x2
> -#define DO_ATTACH	0x4
> -#define DO_DETACH	0x8
> +#define UPDATE_TG	0x01
> +#define SKIP_AGE_LOAD	0x02
> +#define DO_ATTACH	0x04
> +#define DO_DETACH	0x08
> +#define UPDATE_UTIL_EST	0x10
> 
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> @@ -5169,6 +5243,9 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  		if (flags & UPDATE_TG)
>  			update_tg_load_avg(cfs_rq);
>  	}
> +
> +	if (flags & UPDATE_UTIL_EST)
> +		util_est_update(se);
>  }
> 
>  /*
> @@ -5227,11 +5304,6 @@ static inline unsigned long task_util(struct task_struct *p)
>  	return READ_ONCE(p->se.avg.util_avg);
>  }
> 
> -static inline unsigned long task_runnable(struct task_struct *p)
> -{
> -	return READ_ONCE(p->se.avg.runnable_avg);
> -}
> -
>  static inline unsigned long _task_util_est(struct task_struct *p)
>  {
>  	return READ_ONCE(p->se.avg.util_est) & ~UTIL_AVG_UNCHANGED;
> @@ -5274,88 +5346,6 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  	trace_sched_util_est_cfs_tp(cfs_rq);
>  }
> 
> -#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
> -
> -static inline void util_est_update(struct cfs_rq *cfs_rq,
> -				   struct task_struct *p,
> -				   bool task_sleep)
> -{
> -	unsigned int ewma, dequeued, last_ewma_diff;
> -
> -	if (!sched_feat(UTIL_EST))
> -		return;
> -
> -	/*
> -	 * Skip update of task's estimated utilization when the task has not
> -	 * yet completed an activation, e.g. being migrated.
> -	 */
> -	if (!task_sleep)
> -		return;
> -
> -	/* Get current estimate of utilization */
> -	ewma = READ_ONCE(p->se.avg.util_est);
> -
> -	/*
> -	 * If the PELT values haven't changed since enqueue time,
> -	 * skip the util_est update.
> -	 */
> -	if (ewma & UTIL_AVG_UNCHANGED)
> -		return;
> -
> -	/* Get utilization at dequeue */
> -	dequeued = task_util(p);
> -
> -	/*
> -	 * Reset EWMA on utilization increases, the moving average is used only
> -	 * to smooth utilization decreases.
> -	 */
> -	if (ewma <= dequeued) {
> -		ewma = dequeued;
> -		goto done;
> -	}
> -
> -	/*
> -	 * Skip update of task's estimated utilization when its members are
> -	 * already ~1% close to its last activation value.
> -	 */
> -	last_ewma_diff = ewma - dequeued;
> -	if (last_ewma_diff < UTIL_EST_MARGIN)
> -		goto done;
> -
> -	/*
> -	 * To avoid underestimate of task utilization, skip updates of EWMA if
> -	 * we cannot grant that thread got all CPU time it wanted.
> -	 */
> -	if ((dequeued + UTIL_EST_MARGIN) < task_runnable(p))
> -		goto done;
> -
> -
> -	/*
> -	 * Update Task's estimated utilization
> -	 *
> -	 * When *p completes an activation we can consolidate another sample
> -	 * of the task size. This is done by using this value to update the
> -	 * Exponential Weighted Moving Average (EWMA):
> -	 *
> -	 *  ewma(t) = w *  task_util(p) + (1-w) * ewma(t-1)
> -	 *          = w *  task_util(p) +         ewma(t-1)  - w * ewma(t-1)
> -	 *          = w * (task_util(p) -         ewma(t-1)) +     ewma(t-1)
> -	 *          = w * (      -last_ewma_diff           ) +     ewma(t-1)
> -	 *          = w * (-last_ewma_diff +  ewma(t-1) / w)
> -	 *
> -	 * Where 'w' is the weight of new samples, which is configured to be
> -	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
> -	 */
> -	ewma <<= UTIL_EST_WEIGHT_SHIFT;
> -	ewma  -= last_ewma_diff;
> -	ewma >>= UTIL_EST_WEIGHT_SHIFT;
> -done:
> -	ewma |= UTIL_AVG_UNCHANGED;
> -	WRITE_ONCE(p->se.avg.util_est, ewma);
> -
> -	trace_sched_util_est_se_tp(&p->se);
> -}
> -
>  static inline unsigned long get_actual_cpu_capacity(int cpu)
>  {
>  	unsigned long capacity = arch_scale_cpu_capacity(cpu);
> @@ -5828,7 +5818,7 @@ static bool
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
>  	bool sleep = flags & DEQUEUE_SLEEP;
> -	int action = UPDATE_TG;
> +	int action = 0;
> 
>  	update_curr(cfs_rq);
>  	clear_buddies(cfs_rq, se);
> @@ -5848,15 +5838,23 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> 
>  		if (sched_feat(DELAY_DEQUEUE) && delay &&
>  		    !entity_eligible(cfs_rq, se)) {
> -			update_load_avg(cfs_rq, se, 0);
> +			if (entity_is_task(se))
> +				action |= UPDATE_UTIL_EST;
> +			update_load_avg(cfs_rq, se, action);
>  			update_entity_lag(cfs_rq, se);
>  			set_delayed(se);
>  			return false;
>  		}
>  	}
> 
> -	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> -		action |= DO_DETACH;
> +	action = UPDATE_TG;
> +	if (entity_is_task(se)) {
> +		if (task_on_rq_migrating(task_of(se)))
> +			action |= DO_DETACH;
> +
> +		if (sleep && !(flags & DEQUEUE_DELAYED))
> +			action |= UPDATE_UTIL_EST;
> +	}
> 
>  	/*
>  	 * When dequeuing a sched_entity, we must:
> @@ -7628,7 +7626,6 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!p->se.sched_delayed)
>  		util_est_dequeue(&rq->cfs, p);
> 
> -	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>  	if (dequeue_entities(rq, &p->se, flags) < 0)
>  		return false;
> 
> --
> 2.43.0
> 
> 
> 
> 
> > 
> > Specifically, we shouldn't reference p after dequeue_entities() or we
> > risk racing with it being woken up, running, and maybe exiting on
> > another cpu.
> > And this moves the util_est_updat() call to after dequeue finishes.
> > 
> > Maybe there's some way to have util_est_update() compensate for the
> > unfinished accounting that will be done in dequeue_entities()?
> > 
> > thanks
> > -john
