From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 3/6] timekeeping: Make it safe to use the fast timekeeper
 while suspended
Date: Fri, 13 Feb 2015 17:03:51 +0800
Message-ID: <CALAqxLWviqCvcgOgJOdWuTw+qHM9RW0480Ge5dNHf5Nonv75bQ@mail.gmail.com>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
	<1521825.MkZ1sG1M8S@vostro.rjw.lan>
	<CALAqxLWEceEHf=nhrznmGK+cuGU2xs+9HNHowB=bBQpVu4jRJQ@mail.gmail.com>
	<2403461.IZYtJE89Ir@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:47350 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbbBMJDw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 04:03:52 -0500
Received: by mail-qg0-f43.google.com with SMTP id i50so12234540qgf.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2015 01:03:51 -0800 (PST)
In-Reply-To: <2403461.IZYtJE89Ir@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <len.brown@intel.com>

On Fri, Feb 13, 2015 at 10:03 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 13, 2015 08:53:38 AM John Stultz wrote:
>> On Wed, Feb 11, 2015 at 12:03 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Theoretically, ktime_get_mono_fast_ns() may be executed after
>> > timekeeping has been suspended (or before it is resumed) which
>> > in turn may lead to undefined behavior, for example, when the
>> > clocksource read from timekeeping_get_ns() called by it is
>> > not accessible at that time.
>>
>> And the callers of the ktime_get_mono_fast_ns() have to get back a
>> value?
>
> Yes, they do.
>
>> Or can we return an error on timekeeping_suspended like we do
>> w/ __getnstimeofday64()?
>
> No, we can't.
>
>> Also, what exactly is the case when the clocksource being read isn't
>> accessible? I see this is conditionalized on
>> CLOCK_SOURCE_SUSPEND_NONSTOP, so is the concern on resume we read the
>> clocksource and its been reset causing a crazy time value?
>
> The clocksource's ->suspend method may have been called (during suspend)
> and depending on what that did we may even crash things theoretically.
>
> During resume, before the clocksource's ->resume callback, it may just
> be undefined behavior (random data etc).
>
> For system suspend as we have today the window is quite narrow, but after
> patch [4/6] from this series suspend-to-idle may suspend timekeeping and
> just sit there in idle for extended time (hours even) which broadens the
> potential exposure quite a bit.
>
> Of course, it does that with interrupts disabled, but ktime_get_mono_fast_ns()
> is for NMI, so theoretically, if an NMI happens while we're in suspend-to-idle
> with timekeeping suspended and the clocksource is not CLOCK_SOURCE_SUSPEND_NONSTOP
> and the NMI calls ktime_get_mono_fast_ns(), strange and undesirable things may
> happen.

Ok.. No objection to the approach then. But maybe could you wrap the
new logic in a halt_fast_timekeeper() function? Also is there much
value in not halting it for SUSPEND_NONSTOP clocksources? If not,
might as well halt it in all cases just to simplify the conditions we
have to keep track of in our heads. :)

thanks
-john
