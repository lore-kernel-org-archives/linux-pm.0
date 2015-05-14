From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Thu, 14 May 2015 07:43:28 +0530
Message-ID: <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
References: <55520F0F.5010906@free.fr>
	<CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
	<555218C7.5050602@free.fr>
	<20150512155004.GP2067@n2100.arm.linux.org.uk>
	<555380F8.5050306@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <555380F8.5050306@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 13, 2015 at 10:21 PM, Mason <slash.tmp@free.fr> wrote:
> $ git diff v3.14.41 HEAD >tango.patch && xz tango.patch
>
> I don't understand the IRQ-related part yet
> ( arch/arm/mach-tangox/irq.c and drivers/irqchip/irq-gic.c )
>
> If anyone spots the problem, that would make my day.
>
> I tested with a loadable module whose init function is
>
> static int __init ts_init(void)
> {
>         long res;
>         printk("ABOUT TO SLEEP\n");
>         set_current_state(TASK_INTERRUPTIBLE);
>         res = schedule_timeout(HZ);
>         printk("WAKE UP res=%ld\n", res);
>         return 0;
> }
>
> Loading the module, with cpufreq divided by 9, prints:
> [ 1738.962982] ABOUT TO SLEEP
> [ 1747.956191] WAKE UP res=0

I hope you are also matching this time with a physical watch,
to make sure 38->47 is really 9 seconds :)
