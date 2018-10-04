From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 4 Oct 2018 12:58:41 +0100
Message-ID: <20181004115839.c5g2fsehszbvwoqq@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-14-quentin.perret@arm.com>
 <20181004105023.GE19252@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004105023.GE19252@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 04 Oct 2018 at 12:50:23 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:13:08AM +0100, Quentin Perret wrote:
> > Energy Aware Scheduling (EAS) is designed with the assumption that
> > frequencies of CPUs follow their utilization value. When using a CPUFreq
> > governor other than schedutil, the chances of this assumption being true
> > are small, if any. When schedutil is being used, EAS' predictions are at
> > least consistent with the frequency requests. Although those requests
> > have no guarantees to be honored by the hardware, they should at least
> > guide DVFS in the right direction and provide some hope in regards to the
> > EAS model being accurate.
> > 
> > To make sure EAS is only used in a sane configuration, create a strong
> > dependency on schedutil being used. Since having sugov compiled-in does
> > not provide that guarantee, make CPUFreq call a scheduler function on
> > on governor changes hence letting it rebuild the scheduling domains,
> > check the governors of the online CPUs, and enable/disable EAS
> > accordingly.
> 
> So this patch disables EAS when we change cpufreq gov. How about we
> force select schedutil and disallow changing it when EAS is enabled?
> 
> Instead of silently disabling EAS when we frob the governor?

By doing it this way I think we have a better integration with things
like that exclusive cpusets. In the end, EAS is enabled in a
per-root_domain basis. So, say you have two root domains, A and B. EAS
is enabled on A and disabled on B (because it doesn't have
SD_ASYM_CPUCAPACITY or something). Should you be forced to use sugov on
the CPUs of B to run EAS on A ? If there is a cpufreq policy covering
only the CPUs of B, I'd say probably no.

Now I get the argument that this is happening silently as-is, so we can
do better. How about we put a message in dmesg we EAS gets disabled in
case of governor changes ?

Also, I'm currently working on a doc patch for EAS ATM (to be posted
soon), so I can (and will) make it very clear there that you _must_
use sugov to use EAS.

Would that work ?

Thanks,
Quentin
