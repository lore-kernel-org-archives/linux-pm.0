From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Wed, 12 Jul 2017 14:57:55 +0530
Message-ID: <20170712092755.GD1679@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <bac850da-6256-2a92-abfe-71d229cc99dc@arm.com>
 <20170711060106.GL2928@vireshk-i7>
 <45224055-7bf1-243b-9366-0f2d3442ef59@arm.com>
 <20170712040917.GG17115@vireshk-i7>
 <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34386 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdGLJ17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 05:27:59 -0400
Received: by mail-pf0-f174.google.com with SMTP id q85so10143585pfq.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Jul 2017 02:27:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170712083125.at7jic63ozoxoqap@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 12-07-17, 10:31, Peter Zijlstra wrote:
> So the problem with the thread is two-fold; one the one hand we like the
> scheduler to directly set frequency, but then we need to schedule a task
> to change the frequency, which will change the frequency and around we
> go.
> 
> On the other hand, there's very nasty issues with PI. This thread would
> have very high priority (otherwise the SCHED_DEADLINE stuff won't work)
> but that then means this thread needs to boost the owner of the i2c
> mutex. And that then creates a massive bandwidth accounting hole.
> 
> 
> The advantage of using an interrupt driven state machine is that all
> those issues go away.
> 
> But yes, whichever way around you turn things, its crap. But given the
> hardware its the best we can do.

Thanks for the explanation Peter.

IIUC, it will take more time to change the frequency eventually with
the interrupt-driven state machine as there may be multiple bottom
halves involved here, for supply, clk, etc, which would run at normal
priorities now. And those were boosted currently due to the high
priority sugov thread. And we are fine with that (from performance
point of view) ?

Coming back to where we started from (where should we call
arch_set_freq_scale() from ?).

I think we would still need some kind of synchronization between
cpufreq core and the cpufreq drivers to make sure we don't start
another freq change before the previous one is complete. Otherwise
the cpufreq drivers would be required to have similar support with
proper locking in place.

And if the core is going to get notified about successful freq changes
(which it should IMHO), then it may still be better to call
arch_set_freq_scale() from the core itself and not from individual
drivers.

-- 
viresh
