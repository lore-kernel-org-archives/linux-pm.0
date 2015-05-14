From: Mason <slash.tmp@free.fr>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Thu, 14 May 2015 13:22:50 +0200
Message-ID: <5554858A.9010207@free.fr>
References: <55520F0F.5010906@free.fr>	<CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>	<555218C7.5050602@free.fr>	<20150512155004.GP2067@n2100.arm.linux.org.uk>	<555380F8.5050306@free.fr> <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:22440 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbENLXB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 May 2015 07:23:01 -0400
In-Reply-To: <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On 14/05/2015 04:13, Viresh Kumar wrote:
> On Wed, May 13, 2015 at 10:21 PM, Mason <slash.tmp@free.fr> wrote:
>> $ git diff v3.14.41 HEAD >tango.patch && xz tango.patch
>>
>> I don't understand the IRQ-related part yet
>> ( arch/arm/mach-tangox/irq.c and drivers/irqchip/irq-gic.c )
>>
>> If anyone spots the problem, that would make my day.
>>
>> I tested with a loadable module whose init function is
>>
>> static int __init ts_init(void)
>> {
>>         long res;
>>         printk("ABOUT TO SLEEP\n");
>>         set_current_state(TASK_INTERRUPTIBLE);
>>         res = schedule_timeout(HZ);
>>         printk("WAKE UP res=%ld\n", res);
>>         return 0;
>> }
>>
>> Loading the module, with cpufreq divided by 9, prints:
>> [ 1738.962982] ABOUT TO SLEEP
>> [ 1747.956191] WAKE UP res=0
> 
> I hope you are also matching this time with a physical watch,
> to make sure 38->47 is really 9 seconds :)

Hello Viresh,

I didn't /literally/ take a stop-watch to verify it was EXACTLY
9 seconds, but I was staring at the prompt, and it /felt/ like
9 seconds. And the 54 second case felt like a minute.

I'm using a 27 MHz crystal as clocksource. This is independent
of the CPU frequency. However, I'm using the ARM TWD as the
system's clockevent source, and the TWD's clock is tied to
the CPU clock (PERIPHCLK = CPUCLK / 2 on this SoC).

I'm wondering if there's another standard clockevent source
I could try (it would be great if it supported high-resolution
timers).

Regards.

