From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Thu, 22 Jun 2017 10:59:31 +0100
Message-ID: <20170622095931.GC2551@e105550-lin.cambridge.arm.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
 <5949BE5F.4020502@codeaurora.org>
 <20170621053735.GR3942@vireshk-i7>
 <20170621165714.GB2551@e105550-lin.cambridge.arm.com>
 <20170622040643.GB6314@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdFVJ7g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Jun 2017 05:59:36 -0400
Content-Disposition: inline
In-Reply-To: <20170622040643.GB6314@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Thu, Jun 22, 2017 at 09:36:43AM +0530, Viresh Kumar wrote:
> On 21-06-17, 17:57, Morten Rasmussen wrote:
> > It is true that this patch relies on the notifiers, but I don't see how
> > that prevents us from adding a non-notifier based solution for
> > fast-switch enabled platforms later?
> 
> No it doesn't, but I thought it would be better to have a single
> solution (if possible) for all the cases here.

Right. As I mentioned further down in my reply. There is no single
solution that fits all. Smart platforms with HW counters, like x86,
would want to use those. IIUC, cpufreq has no idea what the true
delivered performance is anyway on those platforms.

> 
> > > I think this patch doesn't really need to go down the notifiers way.
> > > 
> > > We can do something like this in the implementation of
> > > topology_get_freq_scale():
> > > 
> > >         return (policy->cur << SCHED_CAPACITY_SHIFT) / max;
> > > 
> > > Though, we would be required to take care of policy structure in this
> > > case somehow.
> > 
> > This is exactly what this patch implements. Unfortunately we can't be
> > sure that there is a valid policy data structure where we can read the
> > information from.
> 
> Actually there is a way around that.
> 
> - Revert one of my patches:
>   commit f9f41e3ef99a ("cpufreq: Remove policy create/remove notifiers")
> 
> - Use those notifiers in init_cpu_capacity_callback() instead of
>   CPUFREQ_NOTIFY and set/reset a local policy pointer.
> 
> - And this pointer we can use safely/reliably in
>   topology_get_freq_scale(). We may need to use RCU read side
>   protection in topology_get_freq_scale() though, to make sure the
>   local policy pointer isn't getting updated simultaneously.
> 
> - If the policy pointer isn't set, then we can use
>   SCHED_CAPACITY_SCALE value instead.

IIUC, you are proposing to maintain an RCU protected pointer in the
topology driver to the policy data structure inside cpufreq and keep it
up to date through cpufreq notifiers. So instead of getting notified
when the frequency changes so we can recompute the scaling ratio, we
have to poll the value and recompute the ratio on each access.

If we are modifying cpufreq, why not just make cpufreq responsible for
providing the scaling factor? It seems easier, cleaner, and a lot
less fragile.

> 
> 
> > Isn't the policy protected by a lock as well?
> 
> There are locks, but you don't need any to read policy->cur.

Okay, but you need to rely on notifiers to know when it is valid.

> 
> > Another thing is that I don't think a transition notifier based solution
> > or any other solution based on the cur/max ratio is really the right way
> > to go for fast-switching platforms. If we can do very frequent frequency
> > switching it makes less sense to use the current ratio whenever we
> > update the PELT averages as the frequency might have changed multiple
> > times since the last update. So it would make more sense to have an
> > average ratio instead.
> 
> > If the platform has HW counters (e.g. APERF/MPERF) that can provide the
> > ratio then we should of course use those, if not, one solution could be
> > to let cpufreq track the average frequency for each cpu over a suitable
> > time window (around one sched period I think). It should be fairly low
> > overhead to maintain. In the topology driver, we would then choose
> > whether the scaling factor is provided by the cpufreq average frequency
> > ratio or the current transition notifier based approach based on the
> > capabilities of the platform.
> 
> Hmm, maybe.

You said you wanted a solution that works for fast-switch enabled
platforms ;-)

The cur/max ratio isn't sufficient for those. PeterZ has already
proposed to use APERF/MPERF for x86 to use the average frequency for
PELT updates. I think other fast-switch platforms would want something
similar, as it makes much more sense.

Morten
