From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Thu, 6 Sep 2018 16:59:36 +0200
Message-ID: <20180906145936.GF27626@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
 <20180904134748.GA4974@localhost.localdomain>
 <20180906144053.GD25636@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906144053.GD25636@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 06/09/18 15:40, Patrick Bellasi wrote:
> On 04-Sep 15:47, Juri Lelli wrote:

[...]

> > Wondering if you want to fold the check below inside the
> > 
> >  if (user && !capable(CAP_SYS_NICE)) {
> >    ...
> >  }
> > 
> > block. It would also save you from adding another parameter to the
> > function.
> 
> So, there are two reasons for that:
> 
> 1) _I think_ we don't want to depend on capable(CAP_SYS_NICE) but
>    instead on capable(CAP_SYS_ADMIN)
> 
>    Does that make sense ?
> 
>    If yes, the I cannot fold it in the block you reported above
>    because we will not check for users with CAP_SYS_NICE.

Ah, right, not sure though. Looks like CAP_SYS_NICE is used for settings
that relates to priorities, affinity, etc.: CPU related stuff. Since
here you are also dealing with something that seems to fall into the
same realm, it might actually fit more than CAP_SYS_ADMIN?

Now that I think more about it, would it actually make sense to allow
unpriviledged users to lower their assigned umin/umax properties if they
want? Something alike what happens for nice values or RT priorities.

> 2) Then we could move it after that block, where there is another
>    set of checks with just:
> 
>       if (user) {
> 
>    We can potentially add the check there yes... but when uclamp is
>    not enabled we will still perform those checks or we have to add
>    some compiler guards...
> 
> 3) ... or at least check for:
> 
>      if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> 
>    Which is what I'm doing right after the block above (2).
> 
>    But, at this point, by passing in the parameter to the
>    __setscheduler_uclamp() call, I get the benefits of:
> 
>    a) reducing uclamp specific code in the caller
>    b) avoiding the checks on !CONFIG_UCLAMP_TASK build
> 
> > >  {
> > >  	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > >  	int lower_bound, upper_bound;
> > >  	struct uclamp_se *uc_se;
> > >  	int result = 0;
> > >  
> > > +	if (!capable(CAP_SYS_ADMIN) &&
> > > +	    user && !uclamp_user_allowed) {
> > > +		return -EPERM;
> > > +	}
> > > +
> 
> Does all the above makes sense ?

If we agree on CAP_SYS_ADMIN, however, your approach looks cleaner yes.
