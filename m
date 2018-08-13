From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Date: Mon, 13 Aug 2018 11:17:24 +0100
Message-ID: <20180813101724.GB2605@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807135403.s7jktvxmhycujeht@queper01-lin>
 <20180809154156.gdsx2vacjmp6p6dp@darkstar>
 <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Quentin!

On 09-Aug 16:55, Quentin Perret wrote:
> Hi Patrick,
> 
> On Thursday 09 Aug 2018 at 16:41:56 (+0100), Patrick Bellasi wrote:
> > > IIUC, not far below this you should still have something like:
> > > 
> > > 	if (rt_rq_is_runnable(&rq->rt))
> > > 		return max;
> > 
> > Do you mean that when RT tasks are RUNNABLE we still want to got to
> > MAX? Not sure to understand... since this patch is actually to clamp
> > the RT class...
> 
> Argh, reading my message again it wasn't very clear indeed. Sorry about
> that ...
> 
> What I'm try to say is that your patch does _not_ remove the snippet of code
> above from sugov_get_util(). So I think that when a RT task is runnable,
> you will not reach the end of the function where the clamping is done.
> And this is not what you want AFAICT.
> 
> Does that make any sense ?

Oh gotcha... you right, I've missed that bit when I rebased on tip.
Will fix on the next iteration!

-- 
#include <best/regards.h>

Patrick Bellasi
