From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Tue, 28 Apr 2015 11:17:51 +0100
Message-ID: <553F5E4F.9040300@arm.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>	<18575128.8R6Lp68k0Q@vostro.rjw.lan> <CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 28/04/15 11:11, Linus Walleij wrote:
> On Thu, Apr 2, 2015 at 12:22 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Replace the clockevents_notify() call with an explicit function call.
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
>

Yes I am too in similar situation with my Vexpress platform.
I did report with the lockdep logs[1] before v4.1-rc1.
I still see the issue with v4.1-rc1.

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/4/23/329
