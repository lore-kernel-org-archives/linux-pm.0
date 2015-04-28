From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control function
Date: Tue, 28 Apr 2015 14:37:10 +0200
Message-ID: <CACRpkdZ2kueU5-kZx2-eTBg9B=nUpU1Anx8u+M3XckRUYWWwnQ@mail.gmail.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
	<18575128.8R6Lp68k0Q@vostro.rjw.lan>
	<CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
	<553F6236.5020300@linaro.org>
	<553F6424.1090704@arm.com>
	<CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 28, 2015 at 2:19 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Sudeep:
>> At-least I observed issue only when I am using hardware broadcast timer.
>> It doesn't hang when I am using hrtimer as broadcast timer in which case
>> one of the cpu will be not enter deeper idle states that lose timer.
>> I will rerun on v4.1-rc1 and post the complete log.
>
> So the bug here is that cpuidle_enter() enables interrupts, so the
> assumption about them being not enabled made by
> tick_broadcast_oneshot_control() is actually not valid.
>
> It looks like we need to acquire the clockevents_lock at least in this
> particular case.  Let me see where to put it and I'll send a patch for
> testing.

Aha that looks very much like it. Put me on the patch and I'll
take it for a spin.

Yours,
Linus Walleij
