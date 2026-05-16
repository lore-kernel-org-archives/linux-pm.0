Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4527707
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778900903; cv=none; b=Z4I6FMu0xHYv4DX6BupeQhzvWuzFI2wSynh60DlBBq4hbDHxqbfHJyc7RjF/zpsDCkMbYDsaZSiGblkvOhEtx/O9qB/dyrj0CUBc9cj36jsev5GTlZF/MgfaT1RQmAtYCEsBwQCfCyah/oVMpSdTpixE/oZsbkyfeKzIBPKklMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778900903; c=relaxed/simple;
	bh=De2hxXjelXLIk6PTP47Rzp3UeCt6uyDrKW3n3h2Jj4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m42spQWaDjUupOCxjIJ9/+p5s3wJhPGvmX0+SeR8eUpBQxE0fokLcQcnx8BHGiJ9W8uZqWczVJpNeIco2IGKKYpCwQOUyKpY2zJuEjXjos26DblwgraOarsUXkIp7krxbLZwet8bBcxVs76PZD/nplSfqpJiZB7mShcdLl1X80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=fTSOpnqy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="fTSOpnqy"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a044cb827so240620f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 20:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1778900900; x=1779505700; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+BgJ+JcnmfxGMf1H17dvufrUNSH2R/540QSZv4B4T0=;
        b=fTSOpnqy4Fbze73DeL9a47OXz9EZ31xM/g72DQhbg++Ff+wxbj/k1Z+09gv/JL48g3
         BWmcouZJA/ALd++NA6MiGt08ky2MWZqOXGMM7+tGVlG0vP+9WDS8CvN/4+kwjV5tKKUo
         34+1Vx6L1ccgmbkCEDdDjPq0i4q+iUe9cLoM0u93vuKhBz78CZOHpkx5bfSBfvgiFFGc
         haDhCAk7wl2/6DLazX1jmLDGRXBkZ2dkp9EtvjE2eQwVs+l+6iMt5ZTiH1AJVCq3xVPS
         geeS9ZVZ2BSBhbtlakMSuAoxdrTbkH5U4R/X9A4klvLyO73tD169NFmGdaOGTQ7jw6Vs
         xu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778900900; x=1779505700;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+BgJ+JcnmfxGMf1H17dvufrUNSH2R/540QSZv4B4T0=;
        b=TJPCZCNplEMqm68O2YM8ujPiAyT9lMAmxrQohjHn89iKDfY7UcC3iw4nmad6qfq6ur
         R1POL0dqPE7iiLEtxX7nMak44377L36njQscekN+oRIEAvHrlWEjG0Td7ai8W5f44lsk
         vKb0ukACffP4Ct43H6KuwQcXaMwrT+yGsj+aHWIeRpxUPgPcDUQw7gMcQzvHi4AwUgRB
         kwvNqG61XY7X9g8RdBVFH3qH1Xh7sOeXprDIrSWS6kR4BW1Y7wiYJ3avoDnSBl/xxPgL
         Y811dJ4Oqoye/9lAmKBY/fP2khVg1Ir3jjGIs0E8nwprBpbMx0T9nOmrAJbhZO+pSIaI
         IHLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qU71dcea8+vEmNnG/hJ8D5fDbAl41QWSugzPXiAQJy300F9uvvsVWlh6A833SQmECDuiLTkvGeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9+fOHpTGO8Uu9tAGYCk9dwWrPa+canNvDnoFdywK2WopAw+u
	9MwvrmNjGwivSQY/fZ4gtVAJFItjzQw1+R1TrcA2gf+VcH4Zb/Xhs3n4cJ6sadP713Q=
X-Gm-Gg: Acq92OFVtLxm0njqlqNzkGmcgwH7J1gPm8NS1mt3Bqgkg27m+SoWnWh7Fmkfb//4XoP
	gK4nOD65xd/T/7o7GcylTypSTqjObsZULpcLJb8hLoLGZC9vOABiqOh10oSMRY2vmTEl4wWyrtd
	WRNoAcbpaNhEPT2H1rJZfX2i1yfVEVpBL0Ps8d3dmsbZ1CDLYqz3egZeWboIs4HlVRkSQEgxwrg
	BQNoN3/9TRSVqIYVDjdRDcwbMGJK/WlZFY0osTc18PpN1YHcwzGJGbCv6aORajxFh8/upYSHO+o
	piHJtNA7IvZpXYln624P6G3VU4SgXOtOIFqnfI5TxYjQeFoDd2e0Ce9M392ODIhzY56HcPkMAje
	bBqj/EC3oiP3C4rwtp/SF5ri95iSPQVLDVC/76G43P124eVB1EjjSmIDYRG6ay6nWFQmZ4yUaTj
	EVKGOeqYfWmcF2Ke/gXTF3lxUuwA==
X-Received: by 2002:a05:6000:250a:b0:45d:4b37:7fcf with SMTP id ffacd0b85a97d-45e5c58951emr8858808f8f.15.1778900899984;
        Fri, 15 May 2026 20:08:19 -0700 (PDT)
Received: from airbuntu ([149.40.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm17027129f8f.15.2026.05.15.20.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:08:19 -0700 (PDT)
Date: Sat, 16 May 2026 04:08:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Call update_util_est() after
 dequeue_entities()
Message-ID: <20260516030817.e2ysxb2s6pbq4nrr@airbuntu>
References: <20260512124653.305275-1-qyousef@layalina.io>
 <15a0cfb8457b7d9d767e7f2d2bcfd56b155f6c0b.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15a0cfb8457b7d9d767e7f2d2bcfd56b155f6c0b.camel@linux.intel.com>

On 05/15/26 11:35, Tim Chen wrote:
> On Tue, 2026-05-12 at 13:46 +0100, Qais Yousef wrote:
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
> > +	int ret;
> > +
> >  	if (task_is_throttled(p)) {
> >  		dequeue_throttled_task(p, flags);
> >  		return true;
> > @@ -7409,8 +7411,9 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!p->se.sched_delayed)
> >  		util_est_dequeue(&rq->cfs, p);
> >  
> > +	ret = dequeue_entities(rq, &p->se, flags);
> >  	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
> 
> I thought that util_est_update() was called intentionally before dequeue_entities
> to update the utilization of task p up to this time right
> before the dequeue.  Then dequeue_entities() is called later
> with up to date task utilization estimate of p.

No. If you look at older versions of dequeue_task_fair() you'll see it was done
at the end.

util_est is a holding function, it should remember the last util_avg value at
dequeue, so the updates must happen first.

> 
> Perhaps util_est_update() should be moved before
> util_est_dequeue() so the updated utilization of p
> is subtracted from the rq utilization.

We actually should subtract the old value always before updating it. The update
happens only at dequeue. My rampup multiplier patches introduces updates for
running tasks, but has to do the dance of subtract, update and re-add otherwise
you'll end up with weird util values at the rq.

> 
> @@ -8002,10 +8002,10 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 return true;
>         }
>  
> +       util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>         if (!p->se.sched_delayed)
>                 util_est_dequeue(&rq->cfs, p);
>  
> -       util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>         if (dequeue_entities(rq, &p->se, flags) < 0)
>                 return false;
> 
> 
> Tim
> 
> > -	if (dequeue_entities(rq, &p->se, flags) < 0)
> > +	if (ret < 0)
> >  		return false;
> >  
> >  	/*
