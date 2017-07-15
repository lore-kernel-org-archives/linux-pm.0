From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with "dynamic_switching"
Date: Sat, 15 Jul 2017 14:26:23 +0200
Message-ID: <3209820.qRRISZfneG@aspire.rjw.lan>
References: <cover.1499853492.git.viresh.kumar@linaro.org> <2309380.IRBF8BkiFH@aspire.rjw.lan> <20170715050828.GA9760@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49017 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751200AbdGOMeK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 08:34:10 -0400
In-Reply-To: <20170715050828.GA9760@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday, July 15, 2017 07:08:28 AM Dominik Brodowski wrote:
> On Sat, Jul 15, 2017 at 12:06:24AM +0200, Rafael J. Wysocki wrote:
> > On Friday, July 14, 2017 01:11:58 PM Rafael J. Wysocki wrote:
> > > On Fri, Jul 14, 2017 at 9:01 AM, Dominik Brodowski
> > > <linux@dominikbrodowski.net> wrote:
> > > > On Thu, Jul 13, 2017 at 06:19:53PM +0200, Rafael J. Wysocki wrote:
> > > >> On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >> > There is no limitation in the ondemand or conservative governors which
> > > >> > disallow the transition_latency to be greater than 10 ms.
> > > >> >
> > > >> > The max_transition_latency field is rather used to disallow automatic
> > > >> > dynamic frequency switching for platforms which didn't wanted these
> > > >> > governors to run.
> > > >> >
> > > >> > Replace max_transition_latency with a boolean (dynamic_switching) and
> > > >> > check for transition_latency == CPUFREQ_ETERNAL along with that. This
> > > >> > makes it pretty straight forward to read/understand now.
> > > >>
> > > >> Well, using CPUFREQ_ETERNAL for that on the driver side is still not
> > > >> particularly straightforward IMO, so maybe add a
> > > >> "no_dynamic_switching" to the driver structure and set it to "true"
> > > >> for the one driver in question?
> > > >
> > > > IIRC it's not just one driver which sets the latency to CPUFREQ_ETERNAL, and
> > > > where dynamic switching might be harmful or at least lead to undefined
> > > > behavior.
> > > 
> > > OK
> > > 
> > > Still, though, using CPUFREQ_ETERNAL to indicate the "no dynamic
> > > switching" condition is somewhat convoluted, so why don't we have a
> > > flag to *explicitly* say that instead?
> > > 
> > > Do you know which drivers they are or is it just all drivers that use
> > > CPUFREQ_ETERNAL?
> > 
> > Well, after the $subject patch it effectively is all drivers that use
> > CPUFREQ_ETERNAL anyway, so it looks like we actually can do a complete
> > switch-over.
> 
> Exactly. But lets take a quick look at the drivers ussing CPUFREQ_ETERNAL:
> 
> Using CPUFREQ_ETERNAL, as policy-setting drivers:
> 
> - intel_pstate.c - for the intel_pstate driver, which defers to the hardware
>   to do frequency selection.
> 
> - longrun.c - hardware-based frequency selection.

That may or may not be hardware-based, but if the ->setpolicy callback is
present, transition_latency doesn't matter anyway.

> => Those drivers are not interested in kernel-based dynamic frequency
> selection anyway.

Right.

> 
> Using CPUFREQ_ETERNAL as a fallback if transition_latency is unknown:
> - arm_big_little.c
> - arm_big_little_dt.c
> - cpufreq-dt.c
> - imx6q-cpufreq.c
> - spear_cpufreq.c
> 
> => As it seems to be an error case, it seems best to bail out on the
> safe side and disallow dynamic frequency scaling. Platform experts might
> know better, though.
> 

Well, Viresh should know what to do for some of them at least. :-)

> Using CPUFREQ_ETERNAL unconditionally:
> - cpufreq-nforce2.c - over a decade old driver; has a commented-out hack
>   to mdelay(10ms) after each frequency transition. This smells like it might
>   be unsafe to do dynamic switching more often than that.
> 
> - elanfreq.c - Has udelay(1ms+10ms) in transition path, so the same terms
>   and conditions seem to apply.
> 
> - gx-suspmod.c - works by a mechanism which reminds me of CPU frequency
>   throttling, but chipset- and not CPU-based.
> 
> - pmac32-cpufreq.c - for some models, it sets latency to ETERNAL. In some
>   frequency switchign code, it has mdelay(10ms) calls.
> 
> - speedsstep-smi.c - this case was discussed previously.
> 
> => For those drivers, dynamic frequency scaling should not be enabled IMO.

Agreed.

> - sa1100-cpufreq.c and
> - sa1110-cpufreq.c - If I remember correctly, those drivers were used for
>   fast user-space based frequency scaling in the past. 
> 
> => For these two drivers, enabling DFVS might be an option.
> 

OK, I'm not familiar with these.

> - sh-cpufreq.c - looks fast, but I have no clue.
> 
> - unicore2-cpufreq.c - same.
> 
> => For those drivers, I have no clue. So to be on the safe side, I'd opt for
> dynamic frequency scaling to be set to off.
> 

Agreed.

> To summarize: At first, I'd propose a *complete* switch-over from
> CPUFREQ_ETERNAL to setting the flag "no DVFS" you have proposed.

So we seem to be in agreement over this.

> Then, one might discuss with the maintainers of individual drivers/platforms on
> whether to relax this rule for a few of those drivers (sa11x0, sh-cpufreq,
> unicore2-cpufreq and the drivers using CPUFREQ_ETERNAL as a fallback).

Right.

Thanks,
Rafael
