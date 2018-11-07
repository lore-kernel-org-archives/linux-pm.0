From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 7 Nov 2018 15:14:14 +0100
Message-ID: <20181107141414.GF9761@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107131632.GP9781@hirez.programming.kicks-ass.net>
 <20181107135738.GE14309@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107135738.GE14309@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2018 at 01:57:38PM +0000, Patrick Bellasi wrote:
> On 07-Nov 14:16, Peter Zijlstra wrote:

> > Please write cmpxchg loops in the form:
> > 
> > 	atomic_long_t *ptr = &uclamp_maps[clamp_id][group_id].adata;
> > 	union uclamp_map old, new;
> > 
> > 	old.data = atomic_long_read(ptr);
> > 	do {
> > 		new.data = old.data;
> > 		new.se_cound--;
> > 	} while (!atomic_long_try_cmpxchg(ptr, &old.data, new.data));
> > 
> > 
> > (same for all the others of course)
> 
> Ok, I did that to save some indentation, but actually it's most
> commonly used in a while loop... will update in v6.
> 
> Out of curiosity, apart from code consistency, is that required also
> specifically for any possible compiler related (mis)behavior ?

No; it is just the 'normal' form my brain likes :-)

And the try_cmpxchg() thing is slightly more efficient on x86 vs the
traditional form:

	while (cmpxchg(ptr, old, new) != old)
