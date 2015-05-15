From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Fri, 15 May 2015 09:46:32 +0530
Message-ID: <20150515041632.GG6348@linux>
References: <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr>
 <20150512155004.GP2067@n2100.arm.linux.org.uk>
 <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr>
 <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <5554B5C1.2070402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5554B5C1.2070402@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14-05-15, 16:48, Mason wrote:
> I don't know. Is it not obvious (to someone who knows what to
> look for) from reading the smp_twd.c source?
> 
> How do I run the TWD in one-shot mode?

I haven't refreshed my memory for the earlier reply, but I have tried
to go through the code again.

The logic is this:
- Oneshot mode is only useful if we are going to support NO_HZ mode.
  i.e. we can disable the clkevt device during CPU idle ..
- For that to work, or in other words for the CPU to wake up from the
  idle state, we need a broadcast timer. Which will wake up the idle
  cpu and its clkevt device.

  You don't have this 'broadcast' timer in your case and so we aren't
  able to switch to oneshot mode.

  Even if you do that, you will be stuck in LOW resolution mode. And
  so you probably leave this timer as is and use a out-of-CPU-domain
  timer for this work, which can support high resolution mode.

> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407g/CIHGECHJ.html

What core does your platform has? Cortex A9? Doesn't that uses this
timer instead: drivers/clocksource/arm_arch_timer.c ?

> "The global timer is clocked by PERIPHCLK."
> 
> PERIPHCLK = CPUCLK/2
> 
> Change the CPUCLK, change the PERIPHCLK.

I am not sure if GPT on SPEAr was an ARM provided timer. But it
definitely doesn't depend on cpu-clk and so no cpufreq support in
that.

> > The same timer is probably used for SPEAr (the platform
> > I used to work on):
> > 
> > http://lxr.free-electrons.com/source/arch/arm/mach-spear/time.c?v=3.14
> 
> Did that platform use cpufreq DFS?

Yes, but the clock to that timer was independent of CPU's clock.

-- 
viresh
