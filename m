From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Mon, 17 Jul 2017 17:30:04 -0700
Message-ID: <CAGAzgsq1c3HdMJ9801uqB+7USK9mqt9xtZTbH=EYv0KDLe+8=A@mail.gmail.com>
References: <20170708000303.21863-1-dbasehore@chromium.org>
 <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com>
 <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com> <7467728.lI8lN4PjS8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33240 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdGRAaG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 20:30:06 -0400
Received: by mail-wr0-f171.google.com with SMTP id a10so6092868wrd.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Jul 2017 17:30:06 -0700 (PDT)
In-Reply-To: <7467728.lI8lN4PjS8@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Sat, Jul 15, 2017 at 5:39 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, July 13, 2017 03:58:53 PM dbasehore . wrote:
>> On Thu, Jul 13, 2017 at 8:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> > On Thu, Jul 13, 2017 at 9:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> >> On Fri, Jul 07, 2017 at 05:03:00PM -0700, Derek Basehore wrote:
>> >>> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
>> >>> This won't fully wake up the system (devices are not resumed), but
>> >>> allow simple platform functionality to be run during freeze with
>> >>> little power impact.
>> >>>
>> >>> This implementation allows an idle driver to setup a timer event with
>> >>> the clock event device when entering freeze by calling
>> >>> tick_set_freeze_event. Only one caller should exist for the function.
>> >>>
>> >>> tick_freeze_event_expired is used to check if the timer went off when
>> >>> the CPU wakes.
>> >>>
>> >>> The event is cleared by tick_clear_freeze_event.
>> >>
>> >> Why? What's wrong with using the RTC stuff? RTC should be able to wake
>> >> suspended systems, see RTCWAKE(8).
>> >
>> > The RTC interrupt is an SCI (on ACPI systems) and we don't handle it
>> > at this point, so we don't know what woke us up until we re-enable
>> > interrupt handlers and run the one for the SCI.
>>
>> To add to that point, RTC wake ups are valid for fully waking up the
>> system. The clock event wake up wasn't used for waking up the system
>> before, so we know that we don't have to check if it should wake up
>> the system entirely. The way rtc timers work right now, I think that
>> we'd have to go all the way through resume devices to figure out if we
>> should resume to user space or freeze again.
>
> Actually, that's not exactly the case any more.
>
> After some changes that went in for 4.13-rc1 there is an additional decision
> point in the resume path, after the noirq stage, where we can decide to go back
> to sleep if that's the right thing to do.
>
> This means that in principle you might hack the CMOS RTC driver to do something
> more sophisticated than just calling pm_wakeup_hard_event() in rtc_handler().
>
> That's ACPI-specific, but I think you have ACPI on all of the systems where the
> residency counders are going to be checked anyway.

This will take more power than the current implementation I have.
While I'm fine with that since the power draw would probably be within
100uW to 1mW, it's worth noting. This is because of the added overhead
of noirq suspend and resume which take a combined time of about 50 to
100 ms depending on the platform. The implementation that used the
APIC uses about 3uW.

Rather than make the change in rtc_handler for the CMOS RTC driver,
the change might be better in the drivers/rtc/interface.c code to
better handle multiple RTC alarms. For example, there might be 2
alarms set for the same time (one that won't wake the system and one
that will) or 2 alarms 1 second apart. In the later case, it's
possible that 1 second will pass before the second alarm is scheduled.
We need to make sure that the RTC irq runs before calling
dpm_suspend_noirq too.

If I remember correctly, I proposed using the RTC to wakeup for this
check to you, but you recommended using the APIC instead. This was of
course before the additional decision point was added to freeze.

>
> Thanks,
> Rafael
>
