From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 6 Jul 2018 18:04:44 +0100
Message-ID: <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706154949.GO2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 06 Jul 2018 at 17:49:49 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 04:12:12PM +0100, Quentin Perret wrote:
> > On Friday 06 Jul 2018 at 15:12:43 (+0200), Peter Zijlstra wrote:
> 
> > > Did you want to use sugov_get_util() here? There is no way we're going
> > > to duplicate all that.
> > 
> > I need to look into how we can do that ... Sugov looks at the current
> > util landscape while EAS tries to predict the _future_ util landscape.
> > Merging the two means I need to add a task and a dst_cpu as parameters
> > of sugov_get_util() and call cpu_util_next() from there, which doesn't
> > feel so clean ...
> 
> Just pass in the util_cfs as computed by cpu_util_next(), then schedutil
> will pass in cpu_util_cfs(), the rest is all the same I think.
> 
> See below.
> 
> > Also, if we merge sugov_get_util() and sugov_aggregate_util() with
> > Vincent's patch-set I'll need to make sure to return two values with
> > sugov_get_util(): 1) the sum of the util of all classes; and 2) the util
> > that will be used to request an OPP. 1) should be used in sum_util and
> > 2) could (but I don't think it's is a good idea) be used for max_util.
> 
> I am confused, the max/sum thing is composed of the same values, just a
> different operator. Both take 'util':
> 
> 
> +	util = schedutil_get_util(cpu, cpu_util_next(cpu, p, dst_cpu))
> +	max_util = max(util, max_util);
> +	sum_util += util;

'max_util' is basically the util we use to request an OPP. 'sum_util' is
how long the CPUs will be running. For now it's the same thing because I
just used the util of the different classes and assumed that OPPs follow
utilization, but if we start using sugov_get_util() things will become
more complex, especially because of RT tasks.

In your example, schedutil_get_util() will return arch_scale_cpu_capacity()
if a RT task is running. We're going to select an OPP with that so
that's what you want to put in max_util. But we also need to know how
long we are going to run at that OPP to compute the energy, and in this
case arch_scale_cpu_capacity is probably _not_ what you want to account in
sum_util ...

Now, I'm not sure if accounting the RT-go-to-max thing here is really
going to help us. This is really an ON/OFF thing, so depending on 'luck',
the OPP landscape that you'll observe in compute_energy() can be very
different depending on whether or not a RT task is running in a FD. And
that will change abruptly when the RT task goes to sleep.

What I'm proposing is to predict in compute_energy() what is the OPP at
which CFS tasks run (cfs_util + dl_util +rt_util, to make it simple),
and ignore the oddity of having an RT task running. But that makes it
harder to factorize things with schedutil more than they are, that is
true ...

I hope that makes sense

Thanks,
Quentin
