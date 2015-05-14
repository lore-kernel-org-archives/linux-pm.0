From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Thu, 14 May 2015 20:08:03 +0530
Message-ID: <CAKohpomfSUFGmNgpUWAoNeDOgisw5kRYk+t5uDOOdShH=hvHGg@mail.gmail.com>
References: <55520F0F.5010906@free.fr>
	<CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
	<555218C7.5050602@free.fr>
	<20150512155004.GP2067@n2100.arm.linux.org.uk>
	<555380F8.5050306@free.fr>
	<CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
	<5554858A.9010207@free.fr>
	<20150514115456.GB23999@linux>
	<55549DEE.6010202@free.fr>
	<CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mans Rullgard <mans@mansr.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 14 May 2015 at 19:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14 May 2015 at 18:36, Mason <slash.tmp@free.fr> wrote:
>> When I execute "echo 18500 > scaling_max_freq"
>> the system is supposed to change the CPU frequency to 18.5 MHz
>> (I might have a bug lurking there) and PERIPHCLK is 1/2 of that,
>> i.e 9.25 MHz.
>
> So at least we are on the right path. But it looks to me that this
> call is not getting propagated well.
>
> From the attachment you gave initially, the event handler for
> twd-timers is: tick_handle_periodic(). i.e. you are running in
> periodic mode and not onshot...
>
> why ?
>
>> Yes, I do, but I was trying to use as much generic code as
>> possible to limit the chances of introducing bugs.
>
> Hmm..
>
>> I'll take a fresh look at the ARM GLOBAL TIMER, but last I
>> checked, it didn't seem to handle frequency scaling.
>
> why is that required? Why will you change its freq ?
> The same timer is probably used for SPEAr (the platform
> I used to work on):
>
> http://lxr.free-electrons.com/source/arch/arm/mach-spear/time.c?v=3.14

And this might be the problem you are facing:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-May/098564.html
