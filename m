From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 13/14] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 4 Oct 2018 12:50:23 +0200
Message-ID: <20181004105023.GE19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-14-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-14-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:08AM +0100, Quentin Perret wrote:
> Energy Aware Scheduling (EAS) is designed with the assumption that
> frequencies of CPUs follow their utilization value. When using a CPUFreq
> governor other than schedutil, the chances of this assumption being true
> are small, if any. When schedutil is being used, EAS' predictions are at
> least consistent with the frequency requests. Although those requests
> have no guarantees to be honored by the hardware, they should at least
> guide DVFS in the right direction and provide some hope in regards to the
> EAS model being accurate.
> 
> To make sure EAS is only used in a sane configuration, create a strong
> dependency on schedutil being used. Since having sugov compiled-in does
> not provide that guarantee, make CPUFreq call a scheduler function on
> on governor changes hence letting it rebuild the scheduling domains,
> check the governors of the online CPUs, and enable/disable EAS
> accordingly.

So this patch disables EAS when we change cpufreq gov. How about we
force select schedutil and disallow changing it when EAS is enabled?

Instead of silently disabling EAS when we frob the governor?
