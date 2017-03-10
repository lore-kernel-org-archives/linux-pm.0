From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: update timer frequencies
Date: Fri, 10 Mar 2017 11:28:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1703101113370.3681@nanos>
References: <1489137441.2333.46.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489137441.2333.46.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vlad Zakharov <Vladislav.Zakharov@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "john.stultz@linaro.org" <john.stultz@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

Vlad,

On Fri, 10 Mar 2017, Vlad Zakharov wrote:
> 
> I am trying to implement a cpufreq driver for ARC CPUs.  The point is
> that ARC timers (including those are used for timekeeping) are driven by
> the same clock as ARC CPU core(s).

To be honest: That's broken by design and you really should go and tell
your hardware folks to fix that. Proper timekeeping is essential for any
Operating System (not only Linux).

It's well known for more than TWO decades that changing the frequency of
the timekeeper clocksource is a complete disaster, but obviously every
hardware vendor has to learn that the hard way instead of simply learning
from history.

> So if cpufreq driver changes CPU frequency timers frequency also
> updates. I added notification handler to ARC timer driver were I
> attempted to update clocksource frequency with
> "__clocksource_update_freq_hz()" but I found that actually the frequency
> didn't update.
> 
> During my further investigation I mentioned that timekeeping framework
> doesn't allow frequency changes for more than 11%. This is quiet
> frustratingly: ARC cores supports such adjustments themselves but current
> framework API doesn't give us a chance to use this functionality and in
> fact it even forbids CPU frequency changes in runtime at all.

It does not forbid CPU frequency changes. It forbids timekeeper clocksource
frequency jumps.

For a very good reason. Having frequency jumps disturbs timekeeping in
several ways (monotonic behaviour, accuracy).

> Maybe I am mistaken and there is some way to get this going? Or maybe we
> can add some minor changes to timekeeping framework to resolve this issue
> (special flag that allows such changes or something like this?).

No, we won't add a special flag because the availability will just
proliferate completely braindead hardware designs.

We had a gazillion of horrible hacks which tried to make this work in the
past, but none of them ever worked reliably under all circumstances. We
won't bring them back.

Your hardware design is broken by making the clocksource clock depend on
the CPU frequency. Tell your hardware people to fix that or just use a
seperate independent clocksource.

Thanks,

	tglx
