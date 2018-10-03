From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 05/14] sched: Introduce a sched_feat for Energy Aware
 Scheduling
Date: Wed, 3 Oct 2018 18:24:35 +0200
Message-ID: <20181003162435.GA19252@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-6-quentin.perret@arm.com>
 <20181002123416.GA3439@hirez.programming.kicks-ass.net>
 <20181002130818.fciw7cmlwggymxrz@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002130818.fciw7cmlwggymxrz@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 02:08:21PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 14:34:16 (+0200), Peter Zijlstra wrote:

> > So these are debug knobs.. I would expect there to be a regular
> > static_key that is controlled by the presence of EM data.
> 
> Right, the issue I'm trying to solve with this is basically that _some_
> users will want to have an EM for the thermal stuff, but they will want
> EAS disabled. Some people (not very many that's true, but still) use
> big.little and don't care much about energy ...
> 
> So, there is a need for an EAS knob on the scheduler side. I don't mind
> it being something else than a sched_feat, but I couldn't see a better
> option. Another Kconfig (CONFIG_SCHED_ENERGY) ? A sysctl ?

Yeah, sysctl, see for example: sysctl.kernel.numa_balancing and the
sched_numa_balancing static_key that goes with it.

I would default enable EAS if the EM is there and valid, but allow
people to disable it.
