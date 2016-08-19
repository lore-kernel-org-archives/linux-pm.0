From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 19 Aug 2016 13:13:59 -0700
Message-ID: <20160819201359.GF11114@graphite.smuckle.net>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
 <02391a39-b785-6056-49c4-c0ff34b3b780@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35194 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754611AbcHSUOD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 16:14:03 -0400
Received: by mail-pa0-f42.google.com with SMTP id hb8so482435pac.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2016 13:14:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <02391a39-b785-6056-49c4-c0ff34b3b780@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Fri, Aug 19, 2016 at 04:00:57PM +0100, Dietmar Eggemann wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 61d485421bed..95d34b337152 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -2731,7 +2731,7 @@ __update_load_avg(u64 now, int cpu, struct sched_avg *sa,
> >  	sa->last_update_time = now;
> >  
> >  	scale_freq = arch_scale_freq_capacity(NULL, cpu);
> > -	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > +	scale_cpu = arch_scale_cpu_capacity(cpu_rq(cpu)->sd, cpu);
> 
> Wouldn't you have to subscribe to this rcu pointer rq->sd w/ something
> like 'rcu_dereference(cpu_rq(cpu)->sd)'?
> 
> IMHO, __update_load_avg() is called outside existing RCU read-side
> critical sections as well so there would be a pair of
> rcu_read_lock()/rcu_read_unlock() required in this case.

Thanks Dietmar for the review.

Yeah I didn't consider that this was protected with rcu. It looks like
I'm abandoning this approach anyway though and doing something limited
just to schedutil.

thanks,
Steve
