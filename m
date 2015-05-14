From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Thu, 14 May 2015 15:06:54 +0200
Message-ID: <55549DEE.6010202@free.fr>
References: <55520F0F.5010906@free.fr> <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com> <555218C7.5050602@free.fr> <20150512155004.GP2067@n2100.arm.linux.org.uk> <555380F8.5050306@free.fr> <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com> <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20150514115456.GB23999@linux>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14/05/2015 13:54, Viresh Kumar wrote:

> Mason wrote:
> 
>> I'm using a 27 MHz crystal as clocksource. This is independent
>> of the CPU frequency. However, I'm using the ARM TWD as the
>> system's clockevent source, and the TWD's clock is tied to
>> the CPU clock (PERIPHCLK = CPUCLK / 2 on this SoC).
> 
> The only (very straight forward) problem is that we aren't propagating
> the freq update to clockevents core and you need to debug a bit there.

I had the same thought, which is why I added the "NEW RATE" trace.

> Also I wanted to see the source of your print message:
> [   19.650454] NEW RATE=9250000
> [   19.653644] NEW RATE=9250000
> 
> What's this rate ? Old/new ? Because you are at least printing the old
> rate here, and the function by default gets the new rate.

I added a printk inside twd_update_frequency().

http://lxr.free-electrons.com/source/arch/arm/kernel/smp_twd.c?v=3.14#L107

I inserted printk("NEW RATE=%lu\n", twd_timer_rate);
right before the call to clockevents_update_freq().

When I execute "echo 18500 > scaling_max_freq"
the system is supposed to change the CPU frequency to 18.5 MHz
(I might have a bug lurking there) and PERIPHCLK is 1/2 of that,
i.e 9.25 MHz.

twd_update_frequency() is called twice: once for each CPU.
(The timers are local to each CPU.)

>> I'm wondering if there's another standard clockevent source
>> I could try (it would be great if it supported high-resolution
>> timers).
> 
> I hope you have some platform general-purpose-timers.

Yes, I do, but I was trying to use as much generic code as
possible to limit the chances of introducing bugs.

I'll take a fresh look at the ARM GLOBAL TIMER, but last I
checked, it didn't seem to handle frequency scaling.

Regards.

