From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control function
Date: Tue, 28 Apr 2015 14:19:11 +0200
Message-ID: <CAJZ5v0j+9gzpfZMyj1Pjnfr8VCoiFirD_U77-wRTn0vpM+Tz8g@mail.gmail.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
	<18575128.8R6Lp68k0Q@vostro.rjw.lan>
	<CACRpkdZYK1AMx1j0TV2tj9_ipG5NpXFhB+RpzN9Cy8L72hMPKg@mail.gmail.com>
	<553F6236.5020300@linaro.org>
	<553F6424.1090704@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34532 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388AbbD1MTM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 08:19:12 -0400
In-Reply-To: <553F6424.1090704@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Apr 28, 2015 at 12:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 28/04/15 11:34, Daniel Lezcano wrote:
>>
>> On 04/28/2015 12:11 PM, Linus Walleij wrote:
>>>
>>> On Thu, Apr 2, 2015 at 12:22 AM, Rafael J. Wysocki
>>> <rjw@rjwysocki.net> wrote:
>>>
>>>> From: Thomas Gleixner <tglx@linutronix.de>
>>>>
>>>> Replace the clockevents_notify() call with an explicit function
>>>> call.
>>>>
>>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>>
>>> For some reason this makes my Ux500 system arbitrarily hang,
>>> especially during boot. Bisected down to this commit. Since the
>>> entire changeset is removing the notifications altogether I can't
>>> just revert it.
>>>
>>> Disabling CONFIG_CPU_IDLE removes the problem.
>>>
>>> Tried registering a stub driver (I just #if 0 all the code in
>>> drivers/cpuidle/cpuidle-ux500.c) it still crashes.
>>>
>>> That makes me think something inside the cpuidle subsystem is
>>> locking up after this, but my other idea is that the timer may be
>>> involved in some way, like this is stressing the timer in some new
>>> yet untested way.
>>>
>>> Has anyone else seen problems with this or is it only ux500?
>>>
>>> I'm looking closer at it but feel a bit clueless...
>>
>>
>> If you keep the #if 0 and remove the CPUIDLE_FLAG_TIMER_STOP flag,
>> does it still crash ?
>>
>
> At-least I observed issue only when I am using hardware broadcast timer.
> It doesn't hang when I am using hrtimer as broadcast timer in which case
> one of the cpu will be not enter deeper idle states that lose timer.
> I will rerun on v4.1-rc1 and post the complete log.

So the bug here is that cpuidle_enter() enables interrupts, so the
assumption about them being not enabled made by
tick_broadcast_oneshot_control() is actually not valid.

It looks like we need to acquire the clockevents_lock at least in this
particular case.  Let me see where to put it and I'll send a patch for
testing.

Rafael
