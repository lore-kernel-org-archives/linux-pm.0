From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 5/5] intel_idle: Add S0ix validation
Date: Tue, 11 Jul 2017 16:57:16 +0200
Message-ID: <2519579.h5lvWVZraV@aspire.rjw.lan>
References: <20170708000303.21863-1-dbasehore@chromium.org> <4255011.FH94tfVCB1@aspire.rjw.lan> <CAGAzgsq-4VZRGgeS7XSzP+QHMpUx9jRGa-ANk3=UxD9BxwKuRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50085 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755868AbdGKPE6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 11:04:58 -0400
In-Reply-To: <CAGAzgsq-4VZRGgeS7XSzP+QHMpUx9jRGa-ANk3=UxD9BxwKuRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, Platform Driver <platform-driver-x86@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Monday, July 10, 2017 03:24:14 PM dbasehore . wrote:
> On Mon, Jul 10, 2017 at 3:09 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Monday, July 10, 2017 02:57:48 PM dbasehore . wrote:
> >> On Mon, Jul 10, 2017 at 6:33 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Friday, July 07, 2017 05:03:03 PM Derek Basehore wrote:
> >> >> This adds validation of S0ix entry and enables it on Skylake. Using
> >> >> the new tick_set_freeze_event function, we program the CPU to wake up
> >> >> X seconds after entering freeze. After X seconds, it will wake the CPU
> >> >> to check the S0ix residency counters and make sure we entered the
> >> >> lowest power state for suspend-to-idle.
> >> >>
> >> >> It exits freeze and reports an error to userspace when the SoC does
> >> >> not enter S0ix on suspend-to-idle.
> >> >>
> >> >
> >> > Honestly, I'm totally unsure about this ATM, as it seems to assume that it
> >> > doesn't make senes to stay suspended if SLP_S0 residency is not there, but
> >> > that totally may not be the case.
> >> >
> >> > First of all, there are systems in which SLP_S0 is related to about 10%-20% of
> >> > the total power draw reduction whereas the remaining 80%-90% comes from PC10
> >> > alone.  So, if you can get to PC10, being unable to get SLP_S0 residency on top
> >> > of that may not be a big deal after all.  Of course, you may argue that 10%-20%
> >> > of battery life while suspended is "a lot", but that really depends on the
> >> > possible alternatives.
> >> >
> >>
> >> We'd have to track actual PC10 residency instead of checking if it's
> >> the requested state since the SoC can enter a higher power package
> >> cstate even if PC10 is requested.
> >
> > That's correct, but it should be sufficient to check the PC10 residency
> > (there's some code to do that in turbostat, for example).
> >
> >> I think this can be done by reading
> >> an msr register, though. Is there an example of how PC10 can be
> >> entered without SLP_S0 getting asserted by the way?
> >
> > Yes, there is.
> >
> > PC10 is a power state of the north complex and it can be entered regardless
> > of the SLP_S0 status which is related to the south complex.
> >
> >> Also, this feature is disabled by default, so it doesn't prevent these
> >> use cases.
> >>
> >> > Second, as far as the alternatives go, it may not be rosy, because there are
> >> > systems that don't support S3 (or any other ACPI sleep states at all for that
> >> > matter) and suspend-to-idle is the only suspend mechanism available there.
> >> > On those systems it still may make sense to use it even though it may not
> >> > reduce the power draw that much.  And from some experiments, suspend-to-idle
> >> > still extends battery life by 100% over runtime idle even if the system is not
> >> > able to get to PC10 most of the time.
> >>
> >> This is off by default.
> >
> > Fair enough, but even so it may not be very useful in general as is.
> >
> >> >
> >> > While I understand the use case, I don't think it is a binary "yes"-"no" thing
> >> > and the focus on just SLP_S0 may be misguided.
> >>
> >> Do you have a preference such as being able to set the level that you
> >> want to validate to? For instance, there could be an option to check
> >> that SLP_So is asserted, but there could also be an option to check
> >> for PC9 or PC10 residency. For instance, there could be a module
> >> parameters for setting the validated state:
> >>
> >> available_suspend_to_idle_states:
> >> "none pc6 pc9 pc10 slp_s0"
> >>
> >> max_suspend_to_idle_state:
> >> "none"
> >>
> >> Where the default validated state is none, but it can be set to any of
> >> the states in available_suspend_to_idle_states
> >
> > In the suspend-to-idle path the driver will always request the deepest state
> > available (C10 for Skylake) and I would validate the associated package state
> > by default plus optionally SLP_S0.
> 
> Should package state validation be enabled by default and should the
> user be able to disable it?

IMO the whole vaildation should depend on a command line option (in case
this is a system without S3 and the user has no choice really), but it should
check the package state residency in the first place.

I guess this means I would make it a "bail out if you can't go as deep as X"
with X possibly equal to "the deepest package state" or "SLP_S0".

Thanks,
Rafael
