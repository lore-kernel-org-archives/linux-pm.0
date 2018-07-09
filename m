From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Mon, 9 Jul 2018 17:07:52 +0100
Message-ID: <20180709160752.GB17598@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
 <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
 <20180709152825.GA17598@e108498-lin.cambridge.arm.com>
 <20180709154226.GZ2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709154226.GZ2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 09 Jul 2018 at 17:42:26 (+0200), Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 04:28:26PM +0100, Quentin Perret wrote:
> > What about moving schedutil_freq_util() to sched.h and give it a more
> > generic name (total_cpu_util() ?) with no dependencies on
> > CONFIG_CPU_FREQ_GOV_SCHEDUTIL ? Also, 'energy_util' would have to be
> > renamed I guess (busy_time_util ?).
> 
> Bit big for an inline,

True, but that will be used in the wake-up path ...

> and I don't think there's much point using all
> this without schedutil.

For that total_cpu_util() function I was suggesting, the main point
would be to avoid code duplication with scale_rt_capacity(). Not sure
if that matters ?

Thanks,
Quentin
