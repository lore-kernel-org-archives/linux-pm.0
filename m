From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Thu, 9 Aug 2018 16:55:53 +0100
Message-ID: <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807135403.s7jktvxmhycujeht@queper01-lin>
 <20180809154156.gdsx2vacjmp6p6dp@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809154156.gdsx2vacjmp6p6dp@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Thursday 09 Aug 2018 at 16:41:56 (+0100), Patrick Bellasi wrote:
> > IIUC, not far below this you should still have something like:
> > 
> > 	if (rt_rq_is_runnable(&rq->rt))
> > 		return max;
> 
> Do you mean that when RT tasks are RUNNABLE we still want to got to
> MAX? Not sure to understand... since this patch is actually to clamp
> the RT class...

Argh, reading my message again it wasn't very clear indeed. Sorry about
that ...

What I'm try to say is that your patch does _not_ remove the snippet of code
above from sugov_get_util(). So I think that when a RT task is runnable,
you will not reach the end of the function where the clamping is done.
And this is not what you want AFAICT.

Does that make any sense ?

> 
> > So you won't reach the actual clamping code at the end of the function
> > when a RT task is runnable no?
> 
> ... mmm... no... this patch is to clamp RT tasks... Am I missing
> something?
> 
> > Also, I always had the feeling that the default for RT should be
> > util_min == 1024, and then users could decide to lower the bar if they
> > want to.
> 
> Mmm... good point! This would keep the policy unaltered for RT tasks.
> 
> I want to keep sched class specific code in uclamp at minimum but
> likely this should be achievable by just properly initializing the
> task-specific util_min for RT tasks, if the original task has
> UCLAM_NOT_VALID.

+1, it'd be nice to keep the cross-class mess to a minimum IMO. But
hopefully this RT thing isn't too ugly to implement ...

> 
> > For the specific case of RT, that feels more natural than
> > applying a max util clamp IMO. What do you think ?
> 
> I'll look better into this for the next posting!

Sounds good :-)

Thanks,
Quentin
