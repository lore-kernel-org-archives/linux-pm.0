From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Mon, 10 Jul 2017 15:12:09 +0530
Message-ID: <20170710094209.GJ2928@vireshk-i7>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com>
 <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
 <12829054.TWIodSo4bb@aspire.rjw.lan>
 <20170710093051.axnd7drdnsxgiu6f@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34960 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdGJJmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 05:42:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id c73so47291841pfk.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2017 02:42:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170710093051.axnd7drdnsxgiu6f@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 10-07-17, 11:30, Peter Zijlstra wrote:
> On Sat, Jul 08, 2017 at 02:09:37PM +0200, Rafael J. Wysocki wrote:
> > Anyway, if everyone agrees that doing it in the core is the way to go (Peter?),
> > why don't you introduce a __weak function for setting policy->cur and
> > override it from your arch so as to call arch_set_freq_scale() from there?
> > 
> 
> So I'm terminally backlogged and my recent break didn't help any with
> that.
> 
> I'm at a total loss as to what is proposed here and why we need it. I
> tried reading both the Changelog and patch but came up empty.

Dietmar is proposing the implementation of arch_set_freq_scale() for ARM (32/64)
platforms here with following equation in drivers/base/arch_topology.c:

scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq

The only variable part here is "cur_freq" and he is looking for sane ways to get
that value in the arch_topology.c file, so he can use that in the above
equation. He tried to use cpufreq transition notifiers earlier but they block us
from using fast switching.

What he is proposing now is a function:

void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
                         unsigned long max_freq);

which has to be called by someone after the frequency of the CPU is changed.

Dietmar proposed that this be called by cpufreq core and Rafael was wondering if
the cpufreq drivers should call it. Dietmar's argument is that it will be used
for the entire ARM architecture this way and wouldn't lead to redundant core
across drivers.

Hope I didn't confuse you more with this :)

-- 
viresh
