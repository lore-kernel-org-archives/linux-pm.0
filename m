From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with
 "dynamic_switching"
Date: Mon, 17 Jul 2017 17:28:51 +0530
Message-ID: <20170717115851.GR352@vireshk-i7>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
 <2309380.IRBF8BkiFH@aspire.rjw.lan>
 <20170715050828.GA9760@light.dominikbrodowski.net>
 <3209820.qRRISZfneG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3209820.qRRISZfneG@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15-07-17, 14:26, Rafael J. Wysocki wrote:
> On Saturday, July 15, 2017 07:08:28 AM Dominik Brodowski wrote:

> > Exactly. But lets take a quick look at the drivers ussing CPUFREQ_ETERNAL:
> > 
> > Using CPUFREQ_ETERNAL, as policy-setting drivers:
> > 
> > - intel_pstate.c - for the intel_pstate driver, which defers to the hardware
> >   to do frequency selection.
> > 
> > - longrun.c - hardware-based frequency selection.
> 
> That may or may not be hardware-based, but if the ->setpolicy callback is
> present, transition_latency doesn't matter anyway.

Right and to avoid confusion its probably better to avoid setting
transition_latency completely from them. I will try to include that in
my series.

> > => Those drivers are not interested in kernel-based dynamic frequency
> > selection anyway.
> 
> Right.
> 
> > 
> > Using CPUFREQ_ETERNAL as a fallback if transition_latency is unknown:
> > - arm_big_little.c
> > - arm_big_little_dt.c
> > - cpufreq-dt.c
> > - imx6q-cpufreq.c
> > - spear_cpufreq.c
> > 
> > => As it seems to be an error case, it seems best to bail out on the
> > safe side and disallow dynamic frequency scaling. Platform experts might
> > know better, though.
> > 
> 
> Well, Viresh should know what to do for some of them at least. :-)

Yeah, they just don't know how much time it takes to change the
frequency. We shouldn't disallow DVFS for them.

> > Using CPUFREQ_ETERNAL unconditionally:
> > - cpufreq-nforce2.c - over a decade old driver; has a commented-out hack
> >   to mdelay(10ms) after each frequency transition. This smells like it might
> >   be unsafe to do dynamic switching more often than that.
> > 
> > - elanfreq.c - Has udelay(1ms+10ms) in transition path, so the same terms
> >   and conditions seem to apply.
> > 
> > - gx-suspmod.c - works by a mechanism which reminds me of CPU frequency
> >   throttling, but chipset- and not CPU-based.
> > 
> > - pmac32-cpufreq.c - for some models, it sets latency to ETERNAL. In some
> >   frequency switchign code, it has mdelay(10ms) calls.
> > 
> > - speedsstep-smi.c - this case was discussed previously.
> > 
> > => For those drivers, dynamic frequency scaling should not be enabled IMO.
> 
> Agreed.

+1 and these are the drivers which should have this new variable set
to avoid DVFS.

Anyone who is setting CPUFREQ_ETERNAL unconditionally should be
setting the new flag.

> > To summarize: At first, I'd propose a *complete* switch-over from
> > CPUFREQ_ETERNAL to setting the flag "no DVFS" you have proposed.
> 
> So we seem to be in agreement over this.

The usage of CPUFREQ_ETERNAL had been confusing over the years, i.e.
some use it to not allow ondemand/conservative, while others use it as
they don't know their transition latencies.

A complete switch over may not be good for the later.

I would suggest we only move the platforms which set latency to
CPUFREQ_ETERNAL unconditionally to the "no DVFS" list. And everyone
else can still continue with CPUFREQ_ETERNAL. I have earlier proposed
finding their latencies dynamically and will try to include that for
them.

-- 
viresh
