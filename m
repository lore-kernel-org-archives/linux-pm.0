From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Tue, 19 Jun 2018 13:58:58 +0100
Message-ID: <20180619125857.GY17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 Jun 2018 at 13:34:08 (+0200), Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> > +struct em_freq_domain *em_cpu_get(int cpu)
> > +{
> > +	struct em_freq_domain *fd;
> > +	unsigned long flags;
> > +
> > +	read_lock_irqsave(&em_data_lock, flags);
> > +	fd = per_cpu(em_data, cpu);
> > +	read_unlock_irqrestore(&em_data_lock, flags);
> 
> Why can't this use RCU? This is the exact thing read_locks are terrible
> at and RCU excells at.

So the idea was that clients (the scheduler for ex) can get a reference
to a frequency domain object once, and they're guaranteed it always
exists without asking for it again.

For example, my proposal was to have the scheduler (patch 05) build its
own private list of frequency domains on which it can iterate efficiently
in the wake-up path. If we protect this per_cpu variable with RCU, then
this isn't possible any-more. The scheduler will have to re-ask
em_cpu_get() at every wake-up, and that makes iterating over frequency
domains a whole lot more complex.

Does that make any sense ?

Thanks,
Quentin
