From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Thu, 2 Aug 2018 16:21:11 +0100
Message-ID: <20180802152109.2k45jqbfquef6u62@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180802123315.GV2476@hirez.programming.kicks-ass.net>
 <20180802124511.GN2512@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802124511.GN2512@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: skannan@codeaurora.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 02 Aug 2018 at 14:45:11 (+0200), Peter Zijlstra wrote:
> On Thu, Aug 02, 2018 at 02:33:15PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 30, 2018 at 12:35:27PM -0700, skannan@codeaurora.org wrote:
> > > On 2018-07-24 05:25, Quentin Perret wrote:
> > > If it's going to be a different aggregation from what's done for frequency
> > > guidance, I don't see the point of having this inside schedutil. Why not
> > > keep it inside the scheduler files? Also, it seems weird to use a governor's
> > > code when it might not actually be in use. What if someone is using
> > > ondemand, conservative, performance, etc?
> > 
> > EAS hard relies on schedutil -- I suppose we need a check for that
> > somewhere and maybe some infrastructure to pin the cpufreq governor.
> 
> Either that or disable EAS when another governor is selected.
> 
> > We're simply not going to support it for anything else.
> 
> To clarify, it makes absolutely no sense what so ever to attempt EAS
> when the DVFS control is not coordinated.

I tend to agree with that, but at the same time even if we create a very
strong dependency on schedutil, we will have no guarantee that the actual
frequencies used on the platform are the ones we predicted in EAS.

There are a number of reasons why a frequency request might not be served
(throttling, thermal capping, something HW-related, ...), so it's hard
to enforce the EAS model in practice.

The way I see things, EAS needs to assume that OPPs follow utilization.
Sugov does something that looks like that too, and it's also in the
scheduler, so that makes sense to try and factorize things, especially
for maintenance purpose. But I feel like the correlation between the two
could stop here.

If you use some sort HW governor that tries to always have some idle time
on the CPUs, then the assumption that OPPs follow utilization isn't _totally_
wrong. There should be a (loose) relation between what EAS 'thinks'
and the reality. And if this isn't true, then you might make slightly
sub-optimal decisions, but I'm not sure if there is anything we can do
about it :/

The scheduler works with various models which, by definition, don't
always perfectly reflect the reality. But those models are useful
because they enable us to reason about things and make decisions. EAS uses
a model where OPPs follow utilization. I think it's just another model
to the list, and we can't really enforce it strictly in practice anyway,
so we will have to live with its inaccuracies I suppose ...

I hope that makes sense :-)

Thanks,
Quentin
