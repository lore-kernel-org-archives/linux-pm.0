From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH RFC 3/8] sched/cpufreq_schedutil: make worker kthread be
 SCHED_DEADLINE
Date: Wed, 24 May 2017 10:31:40 +0100
Message-ID: <20170524093140.flycfuvvut4psbb5@e106622-lin>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523085351.18586-4-juri.lelli@arm.com>
 <20170523185222.sewatquohs3vuped@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170523185222.sewatquohs3vuped@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 23/05/17 20:52, Peter Zijlstra wrote:
> On Tue, May 23, 2017 at 09:53:46AM +0100, Juri Lelli wrote:
> > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > index e2a6c7b3510b..72723859ef74 100644
> > --- a/include/uapi/linux/sched.h
> > +++ b/include/uapi/linux/sched.h
> > @@ -48,5 +48,6 @@
> >   */
> >  #define SCHED_FLAG_RESET_ON_FORK	0x01
> >  #define SCHED_FLAG_RECLAIM		0x02
> > +#define SCHED_FLAG_SPECIAL		0x04
> >  
> >  #endif /* _UAPI_LINUX_SCHED_H */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 7fc2011c3ce7..ba57e2ef9aef 100644
> 
> > @@ -4205,7 +4212,9 @@ static int __sched_setscheduler(struct task_struct *p,
> >  	}
> >  
> >  	if (attr->sched_flags &
> > -		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
> > +		~(SCHED_FLAG_RESET_ON_FORK |
> > +		  SCHED_FLAG_RECLAIM |
> > +		  SCHED_FLAG_SPECIAL))
> >  		return -EINVAL;
> >  
> >  	/*
> 
> Could we pretty please not expose this gruesome hack to userspace?
> 
> So if you stick it in attr->sched_flags, use a high bit and don't put it
> in a uapi header. Also make the flags check explicitly fail on it when
> @user. Such that only _nocheck() (and thus kernel) callers have access
> to it.
>

Sure, I should have done it in the first place.

> Also, there's not nearly enough warnings and other derisory comments
> near it.

Eheh, I'll add all the derisory remarks I'm capable of. :/

Thanks,

- Juri
