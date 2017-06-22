From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Thu, 22 Jun 2017 09:36:43 +0530
Message-ID: <20170622040643.GB6314@vireshk-i7>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
 <20170608075513.12475-3-dietmar.eggemann@arm.com>
 <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
 <5949BE5F.4020502@codeaurora.org>
 <20170621053735.GR3942@vireshk-i7>
 <20170621165714.GB2551@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170621165714.GB2551@e105550-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 21-06-17, 17:57, Morten Rasmussen wrote:
> It is true that this patch relies on the notifiers, but I don't see how
> that prevents us from adding a non-notifier based solution for
> fast-switch enabled platforms later?

No it doesn't, but I thought it would be better to have a single
solution (if possible) for all the cases here.

> > I think this patch doesn't really need to go down the notifiers way.
> > 
> > We can do something like this in the implementation of
> > topology_get_freq_scale():
> > 
> >         return (policy->cur << SCHED_CAPACITY_SHIFT) / max;
> > 
> > Though, we would be required to take care of policy structure in this
> > case somehow.
> 
> This is exactly what this patch implements. Unfortunately we can't be
> sure that there is a valid policy data structure where we can read the
> information from.

Actually there is a way around that.

- Revert one of my patches:
  commit f9f41e3ef99a ("cpufreq: Remove policy create/remove notifiers")

- Use those notifiers in init_cpu_capacity_callback() instead of
  CPUFREQ_NOTIFY and set/reset a local policy pointer.

- And this pointer we can use safely/reliably in
  topology_get_freq_scale(). We may need to use RCU read side
  protection in topology_get_freq_scale() though, to make sure the
  local policy pointer isn't getting updated simultaneously.

- If the policy pointer isn't set, then we can use
  SCHED_CAPACITY_SCALE value instead.


> Isn't the policy protected by a lock as well?

There are locks, but you don't need any to read policy->cur.

> Another thing is that I don't think a transition notifier based solution
> or any other solution based on the cur/max ratio is really the right way
> to go for fast-switching platforms. If we can do very frequent frequency
> switching it makes less sense to use the current ratio whenever we
> update the PELT averages as the frequency might have changed multiple
> times since the last update. So it would make more sense to have an
> average ratio instead.

> If the platform has HW counters (e.g. APERF/MPERF) that can provide the
> ratio then we should of course use those, if not, one solution could be
> to let cpufreq track the average frequency for each cpu over a suitable
> time window (around one sched period I think). It should be fairly low
> overhead to maintain. In the topology driver, we would then choose
> whether the scaling factor is provided by the cpufreq average frequency
> ratio or the current transition notifier based approach based on the
> capabilities of the platform.

Hmm, maybe.

-- 
viresh
