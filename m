From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Wed, 21 Jun 2017 17:57:15 +0100
Message-ID: <20170621165714.GB2551@e105550-lin.cambridge.arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
 <5949BE5F.4020502@codeaurora.org>
 <20170621053735.GR3942@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdFUQ5U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Jun 2017 12:57:20 -0400
Content-Disposition: inline
In-Reply-To: <20170621053735.GR3942@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, Jun 21, 2017 at 11:07:35AM +0530, Viresh Kumar wrote:
> On 20-06-17, 17:31, Saravana Kannan wrote:
> > On 06/19/2017 11:17 PM, Viresh Kumar wrote:
> > >On Thu, Jun 8, 2017 at 1:25 PM, Dietmar Eggemann
> > ><dietmar.eggemann@arm.com> wrote:
> > >
> > >>diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > >
> > >>  static int __init register_cpufreq_notifier(void)
> > >>  {
> > >>+       int ret;
> > >>+
> > >>         /*
> > >>          * on ACPI-based systems we need to use the default cpu capacity
> > >>          * until we have the necessary code to parse the cpu capacity, so
> > >>@@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
> > >>
> > >>         cpumask_copy(cpus_to_visit, cpu_possible_mask);
> > >>
> > >>-       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> > >>-                                        CPUFREQ_POLICY_NOTIFIER);
> > >>+       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> > >>+                                       CPUFREQ_POLICY_NOTIFIER);
> > >
> > >Wanted to make sure that we all understand the constraints this is going to add
> > >for the ARM64 platforms.
> > >
> > >With the introduction of this transition notifier, we would not be able to use
> > >the fast-switch path in the schedutil governor. I am not sure if there are any
> > >ARM platforms that can actually use the fast-switch path in future or not
> > >though. The requirement of fast-switch path is that the freq can be changed
> > >without sleeping in the hot-path.
> > >
> > >So, will we ever want fast-switching for ARM platforms ?

I hope that one day we will have such platforms.

> > >
> > 
> > I don't think we should go down a path that'll prevent ARM platform from
> > switching over to fast-switching in the future.
> 
> Yeah, that's why brought attention to this stuff.

It is true that this patch relies on the notifiers, but I don't see how
that prevents us from adding a non-notifier based solution for
fast-switch enabled platforms later?

> 
> I think this patch doesn't really need to go down the notifiers way.
> 
> We can do something like this in the implementation of
> topology_get_freq_scale():
> 
>         return (policy->cur << SCHED_CAPACITY_SHIFT) / max;
> 
> Though, we would be required to take care of policy structure in this
> case somehow.

This is exactly what this patch implements. Unfortunately we can't be
sure that there is a valid policy data structure where we can read the
information from. Isn't the policy protected by a lock as well?

I don't quite see how you would solve that problem without having some
cached version of the scaling factor that is safe to read without
locking and is always available, even before cpufreq has come up.

Another thing is that I don't think a transition notifier based solution
or any other solution based on the cur/max ratio is really the right way
to go for fast-switching platforms. If we can do very frequent frequency
switching it makes less sense to use the current ratio whenever we
update the PELT averages as the frequency might have changed multiple
times since the last update. So it would make more sense to have an
average ratio instead.

If the platform has HW counters (e.g. APERF/MPERF) that can provide the
ratio then we should of course use those, if not, one solution could be
to let cpufreq track the average frequency for each cpu over a suitable
time window (around one sched period I think). It should be fairly low
overhead to maintain. In the topology driver, we would then choose
whether the scaling factor is provided by the cpufreq average frequency
ratio or the current transition notifier based approach based on the
capabilities of the platform.

Morten
