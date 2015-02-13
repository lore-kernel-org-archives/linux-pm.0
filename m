From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 3/6] timekeeping: Make it safe to use the fast timekeeper
 while suspended
Date: Fri, 13 Feb 2015 08:53:38 +0800
Message-ID: <CALAqxLWEceEHf=nhrznmGK+cuGU2xs+9HNHowB=bBQpVu4jRJQ@mail.gmail.com>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
	<1521825.MkZ1sG1M8S@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:50562 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbBMAxj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 19:53:39 -0500
Received: by mail-qg0-f42.google.com with SMTP id z107so11011765qgd.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2015 16:53:38 -0800 (PST)
In-Reply-To: <1521825.MkZ1sG1M8S@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <len.brown@intel.com>

On Wed, Feb 11, 2015 at 12:03 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Theoretically, ktime_get_mono_fast_ns() may be executed after
> timekeeping has been suspended (or before it is resumed) which
> in turn may lead to undefined behavior, for example, when the
> clocksource read from timekeeping_get_ns() called by it is
> not accessible at that time.

And the callers of the ktime_get_mono_fast_ns() have to get back a
value? Or can we return an error on timekeeping_suspended like we do
w/ __getnstimeofday64()?

Also, what exactly is the case when the clocksource being read isn't
accessible? I see this is conditionalized on
CLOCK_SOURCE_SUSPEND_NONSTOP, so is the concern on resume we read the
clocksource and its been reset causing a crazy time value?

> Prevent that from happening by setting up a dummy readout base for
> the fast timekeeper during timekeeping_suspend() such that it will
> always return the same number of cycles.
>
> After the last timekeeping_update() in timekeeping_suspend() the
> clocksource is read and the result is stored as cycles_at_suspend.
> The readout base from the current timekeeper is copied onto the
> dummy and the ->read pointer of the dummy is set to a routine
> unconditionally returning cycles_at_suspend.  Next, the dummy is
> passed to update_fast_timekeeper().
>
> Then, ktime_get_mono_fast_ns() will work until the subsequent
> timekeeping_resume() and the proper readout base for the fast
> timekeeper will be restored by the timekeeping_update() called
> right after clearing timekeeping_suspended.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/time/timekeeping.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> Index: linux-pm/kernel/time/timekeeping.c
> ===================================================================
> --- linux-pm.orig/kernel/time/timekeeping.c
> +++ linux-pm/kernel/time/timekeeping.c
> @@ -1249,9 +1249,23 @@ static void timekeeping_resume(void)
>         hrtimers_resume();
>  }
>
> +/*
> + * Dummy readout base and suspend-time cycles value for the fast timekeeper to
> + * work in a consistent way after timekeeping has been suspended if the core
> + * timekeeper clocksource is not suspend-nonstop.
> + */
> +static struct tk_read_base tkr_dummy;
> +static cycle_t cycles_at_suspend;
> +
> +static cycle_t dummy_clock_read(struct clocksource *cs)
> +{
> +       return cycles_at_suspend;
> +}
> +
>  static int timekeeping_suspend(void)
>  {
>         struct timekeeper *tk = &tk_core.timekeeper;
> +       struct clocksource *clock = tk->tkr.clock;
>         unsigned long flags;
>         struct timespec64               delta, delta_delta;
>         static struct timespec64        old_delta;
> @@ -1294,6 +1308,14 @@ static int timekeeping_suspend(void)
>         }
>
>         timekeeping_update(tk, TK_MIRROR);
> +
> +       if (!(clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP)) {
> +               memcpy(&tkr_dummy, &tk->tkr, sizeof(tkr_dummy));
> +               cycles_at_suspend = tk->tkr.read(clock);
> +               tkr_dummy.read = dummy_clock_read;
> +               update_fast_timekeeper(&tkr_dummy);
> +       }

Its a little ugly... though I'm not sure I have a better idea right off.

thanks
-john
