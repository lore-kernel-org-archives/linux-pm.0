Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB347CC92
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037882; cv=none; b=nxG4qQspiFOr4+BPfbm8s+lZ1n6c+JaDaTD9l2X060XG1umT2W9lH1fjFDHSNrQ7z/Lt4gJirGVA9LZxh4CYHWNJYVCicNjGpy0DHZ8pR6n7SltLq5ITWYZihGR6W90jTCPwmZpBxWv3lqln1lEXuojvK1pre5mCDLP4oiIJ1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037882; c=relaxed/simple;
	bh=4DxiNj8LGc7bL1pawhem3WQOEu1nmY0/BoLG3Gvfp4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL93bitqyYwQdl/Cy06Tk5Atvvc6HjR89ggiadGWq9zg2j+07vlijKd0aEpGsJ5OrvOhdhTjcIA5L+DKI0uZ+CX/ZhO0Bz0eX0cbG8b2/DoJTQbxyLsOn99VBaacPldwgToS4kCld5AYz4HzWysg3NrZ3xkqOle0kaiJ87ah8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=lDRJ8mID; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="lDRJ8mID"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so8500695e9.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1784037878; x=1784642678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fqK+GBNhdCvtIbsu2YQsK51wtgWHCipu2zsRpqXFuU=;
        b=lDRJ8mIDgstJQ7RU2u/ReqnBBpUT6tpDd9nUvM4YJMYb9Qwrx28vLVThunrf6+FhAV
         zSGoQrXNVgVplxhiysljb2SAG4EV85ysqV7KYnGpuImZwdZJ883QPoy+dmirK//ZHOfv
         gL/mw3fR8A6qKEcGSos1bcN709SNGdLQ+FtKFNld7/RDyn3dqpz1m0xXbvEQqzKQCLG9
         oYasyFA1/8w7amKnom/UNx9oKNBDqvTickmAtrwzOcOjO7cKxlvVgOHONVqskTj6E41Q
         nXHXm+zR1FSfB5dowvIShxEaHqDj3mYgp2D+aWiX1DhR+h9o9pG+oAyzrjKvAeeYOxWw
         mQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037878; x=1784642678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fqK+GBNhdCvtIbsu2YQsK51wtgWHCipu2zsRpqXFuU=;
        b=B45Biz/5I7+tIJyg4XkvlAtYD1dPvFXwr+D0dI+eLoECirr9kuaiuBuS0ig9E7uL/L
         xho8K4fH840H51JM9EfttiO7aHgTgkx0kaWbvgV/+ahj7P6LD97rwSZC1HRvX4eplB5c
         clgOMDG3iSIHtUFH7eWAiw0DigWWJGkCHiQH9TvJxGGuC0rmlBYmOYZw2qlkuGGjDFjs
         GIuBwB6Q9khDdZpfp9+YFxDFPIKGeu0Pv4lKsp7sZFTAXv/xvumTsF2katrF5x+CQ/Rp
         3N6D84P8EnBIkVK3obQ5ELrPyD76qGGAWNHv+sBYWcG+enN43+wvoNWzJ8g9OUYfKK26
         0wNA==
X-Forwarded-Encrypted: i=1; AHgh+RoCCYGcywd8YCA9RecWHBPMih2OOCDsLTH0T3aYML7wTHNok8zzwevsFQf+YYgrBU8fewghEPN6ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGv5RXYTZlnQt8/Knih6jq2KOTtOoZaHYYf3NroT7ZLvBbjeXx
	4woggJPEHfWiu6w7vw2FM4ckLs7Q1Nhn6PXonMGlNUP5r9vsuw13SzcczdI3TFRDN1w=
X-Gm-Gg: AfdE7cnTwKiFbi6wX9lhCRSfWeRjpKJsj3GAw6x53r5pE/BpCGUA3ywI67ctkQMxTlr
	3/xUXKevy5FcayDkhkbOYBJlKomxOXIbO2Nve7lGf2g5ISiXcwZI2Gc+0/TyF23Klxvk55+aPaT
	z5TIsTHHXRWmK7q+uVEUlZdFyTsu08MyLIBsQm7EGalbZaINZ3FCxBi7iinB4tHZfaC6S7K/aZJ
	FZWzMi7BAekOFhyV4Obvbc/vTRSqFgHYRdAGuqlFc92vuLAPq6Q1rFx0Db6eBXBZLnZdX6CSkbF
	rgbayzfrvTXiqazKMbwh6aZzKGrOfNk2bH7N9lWGy5z8CW8kLgJT8MRyPlQfYQ+UucIRj8QtUYi
	vNJbONkh+B2RSZEDGzFEoflUN61GnnK9yrhMnrcMnKIQkCn6yK1oeBQM+1BM4aZjgIL0hm7TMtX
	ZEBDz6KujZvbEuYU7jEw==
X-Received: by 2002:a05:600c:354e:b0:493:e38b:182d with SMTP id 5b1f17b1804b1-493f881800dmr151762695e9.22.1784037877743;
        Tue, 14 Jul 2026 07:04:37 -0700 (PDT)
Received: from airbuntu ([149.50.209.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493fd3ccfd4sm186652205e9.2.2026.07.14.07.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:04:36 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:04:31 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in
 fits_capacity()
Message-ID: <20260714140431.i3zvadvrg54c5ij6@airbuntu>
References: <20260504020003.71306-1-qyousef@layalina.io>
 <20260504020003.71306-5-qyousef@layalina.io>
 <CAKfTPtBKpFPS4AfsF_ihjW-m-FqcSXgg1fO_ZBV_Qjvr++iTHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBKpFPS4AfsF_ihjW-m-FqcSXgg1fO_ZBV_Qjvr++iTHw@mail.gmail.com>

On 06/04/26 12:08, Vincent Guittot wrote:
> On Mon, 4 May 2026 at 04:00, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Replace hardcoded margin value in fits_capacity() with better dynamic
> > logic.
> >
> > 80% margin is a magic value that has served its purpose for now, but it
> > no longer fits the variety of systems that exist today. If a system is
> > over powered specifically, this 80% will mean we leave a lot of capacity
> > unused before we decide to upmigrate on HMP system.
> >
> > On many systems the little cores are under powered and ability to
> > migrate faster away from them is desired.
> >
> > Redefine misfit migration to mean the utilization threshold at which the
> > task would become misfit at the next load balance event assuming it
> 
> Do you mean at the next tick?

Yes. But the way currently load balancer works it could take several ticks to
trigger, but implementation wise we assume next tick. I'll update the wording.
Hopefully with your push lb it will always trigger on next tick worst case
scenario.

> 
> > becomes an always running task.
> >
> > To calculate this threshold, we use the new approximate_util_avg()
> > function to find out the threshold, based on arch_scale_cpu_capacity()
> > the task will be misfit if it continues to run for a TICK_USEC which is
> > our worst case scenario for when misfit migration will kick in.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  kernel/sched/core.c  |  1 +
> >  kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++--------
> >  kernel/sched/sched.h |  1 +
> >  3 files changed, 34 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 49cd5d217161..47ec8ea7c52e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -8921,6 +8921,7 @@ void __init sched_init(void)
> >                 rq->sd = NULL;
> >                 rq->rd = NULL;
> >                 rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> > +               rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
> >                 rq->balance_callback = &balance_push_callback;
> >                 rq->active_balance = 0;
> >                 rq->next_balance = jiffies;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f179faf7a6a1..4e1ed3c7f96e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -97,11 +97,15 @@ int __weak arch_asym_cpu_priority(int cpu)
> >  }
> >
> >  /*
> > - * The margin used when comparing utilization with CPU capacity.
> > - *
> > - * (default: ~20%)
> > + * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
> > + * lower capacity for too long. This the threshold is the util value at which
> > + * if a task becomes always busy it could miss misfit migration load balance
> > + * event. So we consider a task is misfit before it reaches this point.
> >   */
> > -#define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
> > +static inline bool fits_capacity(unsigned long util, int cpu)
> > +{
> > +       return util < cpu_rq(cpu)->fits_capacity_threshold;
> > +}
> >
> >  /*
> >   * The margin used when comparing CPU capacities.
> > @@ -5180,14 +5184,13 @@ static inline int util_fits_cpu(unsigned long util,
> >                                 unsigned long uclamp_max,
> >                                 int cpu)
> >  {
> > -       unsigned long capacity = capacity_of(cpu);
> >         unsigned long capacity_orig;
> >         bool fits, uclamp_max_fits;
> >
> >         /*
> >          * Check if the real util fits without any uclamp boost/cap applied.
> >          */
> > -       fits = fits_capacity(util, capacity);
> > +       fits = fits_capacity(util, cpu);
> >
> >         if (!uclamp_is_used())
> >                 return fits;
> > @@ -10299,12 +10302,33 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >  {
> >         unsigned long capacity = scale_rt_capacity(cpu);
> >         struct sched_group *sdg = sd->groups;
> > +       struct rq *rq = cpu_rq(cpu);
> > +       u64 limit;
> >
> >         if (!capacity)
> >                 capacity = 1;
> >
> > -       cpu_rq(cpu)->cpu_capacity = capacity;
> > -       trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> > +       rq->cpu_capacity = capacity;
> > +       trace_sched_cpu_capacity_tp(rq);
> > +
> > +       /*
> > +        * Calculate the util at which the task must be considered a misfit.
> > +        *
> > +        * We must ensure that a task experiences the same ramp-up time to
> > +        * reach max performance point of the system regardless of the CPU it
> > +        * is running on (due to invariance, time will stretch and task will
> > +        * take longer to achieve the same util value compared to a task
> > +        * running on a big CPU) and a delay in misfit migration which depends
> > +        * on TICK doesn't end up hurting it as it can happen after we would
> > +        * have crossed this threshold.
> > +        *
> > +        * To ensure that invaraince is taken into account, we don't scale time
> > +        * and use it as-is, approximate_util_avg() will then let us know the
> > +        * our threshold.
> > +        */
> > +       limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
> > +       limit -= TICK_USEC; /* sd->balance_interval is more accurate */
> > +       rq->fits_capacity_threshold = approximate_util_avg(0, limit);
> 
> update_cpu_capacity() is called in build_sched_domain() and also
> during periodic load balancing, but fits_capacity_threshold is fixed
> and should be set once
> 
> I'm not sure to get what you want to do here. Do you want to get a
> tick margin at max compute capacity compared to
> arch_scale_cpu_capacity() ?

Yes. If a task continues to run how will the util signal grow by the time the
next tick arrives, if we are going to cross the capacity, then it is misfit
now. This will automatically adjust the value to be low for little cores and
high for bigger cores. IOW smaller cores need higher margin and bigger cores
need smaller margin.

> 
> On the big core (1024), this means a threshold of 1023 which sounds reasonable.
> On the little core (280), this means a threshold of 268 (1ms tick).
> However, reaching 268 at max freq on the little core requires 41ms,
> whereas the task will be at 602 after 41ms running on the big core

I think you're talking about the invariance problem (black hole effect that
distorts util at lower capacities/freqs). Yes this is a problem, but the new
approximate function don't take invariance into account. And with util_est
fixes using rampup multiplier of 1 we will always rise at a constant rate as if
we are running at biggest core/max freq. So I'd expect util_est to rise to 602
after 41ms regardless if we are on little or big core - which is the major
problem the rest of the series fix. From what I've seen the little cores
capacity can be hit within ~13ms if util rises normally. Which is a true
reflection of how slow they are. And the major problem folks encounter of tasks
stuck on little core for many 10s of ms.

Even when the rampup multiplier is 0, the values are still correct. It is true
they will take longer to reach this threshold, and arguably will need more than
1 tick to hit the capacity once reached it, but two things to keep in mind:

1. This current slow rise behavior is good for power, and we want to retain
   this behavior for them.
2. If we more accurately represent the threshold to counter for distortion,
   the tasks will get double hit, the slow rise time AND the higher threshold,
   which is genuinely a problem today with the 80% threshold for example. So
   while it is not accurate when rampup multiplier is 0, but I do believe it is
   correct as tasks are already getting a perf hit to rise to this value slower
   than they should (due to invariance impact), and from experience this is
   a high enough of a penalty already even for those tasks that are not
   important. We don't want to grind them to a halt. That said we can work in
   the future to create two thresholds, but I don't see the point at this
   stage and not keen on the additional complexity in general.

> 
> 
> 
> 
> >
> >         sdg->sgc->capacity = capacity;
> >         sdg->sgc->min_capacity = capacity;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index a445add5cc3a..24008f1ec812 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1236,6 +1236,7 @@ struct rq {
> >         unsigned char           nohz_idle_balance;
> >         unsigned char           idle_balance;
> >
> > +       unsigned long           fits_capacity_threshold;
> >         unsigned long           misfit_task_load;
> >
> >         /* For active balancing */
> > --
> > 2.34.1
> >
