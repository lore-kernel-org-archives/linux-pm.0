From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 6 Jul 2018 14:40:03 +0100
Message-ID: <20180706134003.GB17577@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706113208.GS2458@hirez.programming.kicks-ass.net>
 <20180706132056.GA17577@e108498-lin.cambridge.arm.com>
 <20180706132428.GY2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706132428.GY2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 06 Jul 2018 at 15:24:28 (+0200), Peter Zijlstra wrote:
> On Fri, Jul 06, 2018 at 02:20:57PM +0100, Quentin Perret wrote:
> > So, what we try to do here is to _not_ set the overutilized flag based
> > on the utilization of a new task, because its utilization is 'wrong'.
> > That should help avoiding spurious transitions above the overutilized
> > threshold.
> 
> That most certainly deserves a comment,

Ok, will do.

> also didn't util_est fix some of that wrong-ness?

When a new task is enqueued, we don't have util_est samples yet, so the
task's util_est is equal to its util_avg. So util_est won't help here,
unfortunately.

But it does help in the wake-up path to predict what OPP will be
selected (see cpu_util_next() in patch 09/12).

Thanks,
Quentin
