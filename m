From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 6 Jul 2018 16:12:12 +0100
Message-ID: <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706131243.GV2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 06 Jul 2018 at 15:12:43 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:40PM +0100, Quentin Perret wrote:
> > +static long 
>    compute_energy(struct task_struct *p, int dst_cpu, struct freq_domain *fd)
> > +{
> > +	long util, max_util, sum_util, energy = 0;
> > +	int cpu;
> > +
> > +	while (fd) {
> > +		max_util = sum_util = 0;
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
> 
> I had a wee little wtf moment when I realized this crosses root_domain
> boundaries but that that is actually desired. A comment might be in
> order.

Indeed, the selection of CPU candidates is guaranteed to be within the
root_domain, but the boundaries for the energy calculation can be
different. The OPP in a FD can be driven by a CPU outside of the
root_domain we're currently looking at ... I'll add a comment about
that.

I guess it is also worth mentioning that in the case mentioned above the
scheduling decisions made inside one root domain can indirectly be
impacted by the scheduling decisions made in another root domain. Some
CPUs inside one root domain might look expensive to use simply because
they run at a high OPP because of other CPUs of the same FD being
over-used in another root domain.

This is arguably not desirable, but I'm not sure if this is a problem.
It would be wise for users not to split a frequency domain in multiple
root domains IMO but we can't really prevent them from doing so ...

Another solution would be to ignore the CPUs outside of the root_domain
and to accept that this can lead to sub-optimal scheduling decisions
from an energy standpoint.

> 
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			util += cpu_util_dl(cpu_rq(cpu));
> > +			/* XXX: add RT util_avg when available. */
> > +
> > +			max_util = max(util, max_util);
> > +			sum_util += util;
> 
> Did you want to use sugov_get_util() here? There is no way we're going
> to duplicate all that.

I need to look into how we can do that ... Sugov looks at the current
util landscape while EAS tries to predict the _future_ util landscape.
Merging the two means I need to add a task and a dst_cpu as parameters
of sugov_get_util() and call cpu_util_next() from there, which doesn't
feel so clean ...

Also, if we merge sugov_get_util() and sugov_aggregate_util() with
Vincent's patch-set I'll need to make sure to return two values with
sugov_get_util(): 1) the sum of the util of all classes; and 2) the util
that will be used to request an OPP. 1) should be used in sum_util and
2) could (but I don't think it's is a good idea) be used for max_util.

This probably won't be pretty :/
