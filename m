From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 05/12] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Thu, 5 Jul 2018 18:50:22 +0100
Message-ID: <20180705175022.GB21903@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-6-quentin.perret@arm.com>
 <20180705173321.GR2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705173321.GR2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 05 Jul 2018 at 19:33:21 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:36PM +0100, Quentin Perret wrote:
> > +			if (cpumask_equal(doms_new[i], doms_cur[j])
> > +			    && cpu_rq(cpumask_first(doms_cur[j]))->rd->fd)
> 
> Please put the operator at the end of the previous line, not the begin
> of the next line when splitting.

I did that to be consistent with the to similar loops above, but n/p,
I'll change it :-)

Thanks,
Quentin
