From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Tue, 28 Apr 2015 12:34:30 +0200
Message-ID: <553F6236.5020300@linaro.org>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>	<18575128.8R6Lp68k0Q@vostro.rjw.lan> <CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/28/2015 12:11 PM, Linus Walleij wrote:
> On Thu, Apr 2, 2015 at 12:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Replace the clockevents_notify() call with an explicit function call=
=2E
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> For some reason this makes my Ux500 system arbitrarily hang,
> especially during boot. Bisected down to this commit.
> Since the entire changeset is removing the notifications
> altogether I can't just revert it.
>
> Disabling CONFIG_CPU_IDLE removes the problem.
>
> Tried registering a stub driver (I just #if 0 all the code in
> drivers/cpuidle/cpuidle-ux500.c) it still crashes.
>
> That makes me think something inside the cpuidle subsystem
> is locking up after this, but my other idea is that the timer
> may be involved in some way, like this is stressing the timer
> in some new yet untested way.
>
> Has anyone else seen problems with this or is it only
> ux500?
>
> I'm looking closer at it but feel a bit clueless...

If you keep the #if 0 and remove the CPUIDLE_FLAG_TIMER_STOP flag, does=
=20
it still crash ?

> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
