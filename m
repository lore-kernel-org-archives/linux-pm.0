From: Mason <mpeg.blue@free.fr>
Subject: Re: Delays, clocks, timers, hrtimers, etc
Date: Fri, 06 Feb 2015 18:21:37 -0800
Message-ID: <54D576B1.4000001@free.fr>
References: <54C8E125.3070905@free.fr> <e028a4eb604a491f4438557f4a1373ef@agner.ch> <54D52F84.9050600@free.fr> <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <266c7b1ff2d1a8ba0ae4866f4fb4eca5@agner.ch>
Sender: cpufreq-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, cpufreq <cpufreq@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Stefan Agner wrote:

> On 2015-02-06 22:17, Mason wrote:
>
>> Do you also use the ARM local timers in your port?
>> Is there generic code to handle them?
>
> It seems that there has been support for local timers once, but has been
> removed. But I'm not aware of the details:
> https://lkml.org/lkml/2013/2/22/49

The equivalent gmane link would be:
http://thread.gmane.org/gmane.linux.kernel/1445799

The description used to say:

-config LOCAL_TIMERS
-	bool "Use local timer interrupts"
-	depends on SMP
-	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
-	help
-	  Enable support for local timers on SMP platforms, rather then the
-	  legacy IPI broadcast method.  Local timers allows the system
-	  accounting to be spread across the timer interval, preventing a
-	  "thundering herd" at every timer tick.

which seems to have been replaced with HAVE_ARM_TWD

TWD stands for "Timer Watch Dog".
https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/twd.txt

"ARM 11MP, Cortex-A5 and Cortex-A9 are often associated with a per-core
Timer-Watchdog (aka TWD), which provides both a per-cpu local timer
and watchdog.

The TWD is usually attached to a GIC to deliver its two per-processor
interrupts."


config HAVE_ARM_TWD
   bool
   depends on SMP
   select CLKSRC_OF if OF
   help
     This options enables support for the ARM timer and watchdog unit

One problem I see is that HAVE_ARM_TWD depends on SMP...

One of the systems I want to support is UP (single-core Cortex A9).
Does that mean I should use an SMP kernel even for that system?
Or is there a different subsystem for UP systems?

Also, reading arch/arm/kernel/smp_twd.c, I see that frequency changes
due to cpufreq are properly accounted for. (Although I imagine they do
introduce a small error in time-keeping because moving from freq_A to
freq_B is not instantaneous, so the exact time elapsed in-between is
impossible to determine.)

Regards.

