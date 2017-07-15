From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/5] tick: Add freeze timer events
Date: Sat, 15 Jul 2017 14:39:09 +0200
Message-ID: <7467728.lI8lN4PjS8@aspire.rjw.lan>
References: <20170708000303.21863-1-dbasehore@chromium.org> <CAJZ5v0horA+vgR3bAbEu+AiqEFJ7JyZ49nTv6FBPHRvmXOUFpQ@mail.gmail.com> <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41755 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751191AbdGOMq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 08:46:56 -0400
In-Reply-To: <CAGAzgsoFugSw=UQsJmep0woGg70J3nie0-EtvtQ4Ec1NG1usOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, the arch/x86 maintainers <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>

On Thursday, July 13, 2017 03:58:53 PM dbasehore . wrote:
> On Thu, Jul 13, 2017 at 8:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Jul 13, 2017 at 9:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> On Fri, Jul 07, 2017 at 05:03:00PM -0700, Derek Basehore wrote:
> >>> Adds a new feature to tick to schedule wakeups on a CPU during freeze.
> >>> This won't fully wake up the system (devices are not resumed), but
> >>> allow simple platform functionality to be run during freeze with
> >>> little power impact.
> >>>
> >>> This implementation allows an idle driver to setup a timer event with
> >>> the clock event device when entering freeze by calling
> >>> tick_set_freeze_event. Only one caller should exist for the function.
> >>>
> >>> tick_freeze_event_expired is used to check if the timer went off when
> >>> the CPU wakes.
> >>>
> >>> The event is cleared by tick_clear_freeze_event.
> >>
> >> Why? What's wrong with using the RTC stuff? RTC should be able to wake
> >> suspended systems, see RTCWAKE(8).
> >
> > The RTC interrupt is an SCI (on ACPI systems) and we don't handle it
> > at this point, so we don't know what woke us up until we re-enable
> > interrupt handlers and run the one for the SCI.
> 
> To add to that point, RTC wake ups are valid for fully waking up the
> system. The clock event wake up wasn't used for waking up the system
> before, so we know that we don't have to check if it should wake up
> the system entirely. The way rtc timers work right now, I think that
> we'd have to go all the way through resume devices to figure out if we
> should resume to user space or freeze again.

Actually, that's not exactly the case any more.

After some changes that went in for 4.13-rc1 there is an additional decision
point in the resume path, after the noirq stage, where we can decide to go back
to sleep if that's the right thing to do.

This means that in principle you might hack the CMOS RTC driver to do something
more sophisticated than just calling pm_wakeup_hard_event() in rtc_handler().

That's ACPI-specific, but I think you have ACPI on all of the systems where the
residency counders are going to be checked anyway.

Thanks,
Rafael
