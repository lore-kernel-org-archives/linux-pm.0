From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant load-tracking support
Date: Sat, 08 Jul 2017 14:09:37 +0200
Message-ID: <12829054.TWIodSo4bb@aspire.rjw.lan>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com> <CAJZ5v0gBPNDBYWbuHVaB7deNHSZKziaAeybSw3mg+S8V_roO-Q@mail.gmail.com> <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41038 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752797AbdGHMRX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jul 2017 08:17:23 -0400
In-Reply-To: <22f004af-0158-8265-2da5-34743f294bfb@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Friday, July 07, 2017 06:06:30 PM Dietmar Eggemann wrote:
> On 07/07/17 17:18, Rafael J. Wysocki wrote:
> > On Fri, Jul 7, 2017 at 6:01 PM, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >> On 06/07/17 11:40, Viresh Kumar wrote:
> >>> On 06-07-17, 10:49, Dietmar Eggemann wrote:
> 
> [...]
> 
> >> So what about I call arch_set_freq_scale() in __cpufreq_notify_transition() in the
> >> CPUFREQ_POSTCHANGE case for slow-switching and in cpufreq_driver_fast_switch() for
> >> fast-switching?
> > 
> > Why don't you do this in drivers instead of in the core?
> > 
> > Ultimately, the driver knows what frequency it has requested, so why
> > can't it call arch_set_freq_scale()?
> 
> That's correct but for arm/arm64 we have a lot of different cpufreq
> drivers to deal with. And doing this call to arch_set_freq_scale() once
> in the cpufreq core will cover them all.
> 
> [...]

I'm sort of wondering how many is "a lot" really.  For instance, do you really
want all of the existing ARM platforms to use the new stuff even though
it may regress things there in principle?

Anyway, if everyone agrees that doing it in the core is the way to go (Peter?),
why don't you introduce a __weak function for setting policy->cur and
override it from your arch so as to call arch_set_freq_scale() from there?

Thanks,
Rafael
