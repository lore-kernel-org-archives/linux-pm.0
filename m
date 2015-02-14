From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 3/6] timekeeping: Make it safe to use the fast timekeeper
 while suspended
Date: Sun, 15 Feb 2015 01:30:42 +0800
Message-ID: <CALAqxLXS77Nso1iH0mUnHUwb+fxrSkcOqwkzLX1izVam2g_RFA@mail.gmail.com>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
	<2403461.IZYtJE89Ir@vostro.rjw.lan>
	<CALAqxLWviqCvcgOgJOdWuTw+qHM9RW0480Ge5dNHf5Nonv75bQ@mail.gmail.com>
	<2177558.2TEykqeHuz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2177558.2TEykqeHuz@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2015 at 10:32 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, February 13, 2015 05:03:51 PM John Stultz wrote:
>> On Fri, Feb 13, 2015 at 10:03 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Friday, February 13, 2015 08:53:38 AM John Stultz wrote:
>> >> On Wed, Feb 11, 2015 at 12:03 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> >
>> >> > Theoretically, ktime_get_mono_fast_ns() may be executed after
>> >> > timekeeping has been suspended (or before it is resumed) which
>> >> > in turn may lead to undefined behavior, for example, when the
>> >> > clocksource read from timekeeping_get_ns() called by it is
>> >> > not accessible at that time.
>> >>
>> >> And the callers of the ktime_get_mono_fast_ns() have to get back a
>> >> value?
>> >
>> > Yes, they do.
>> >
>> >> Or can we return an error on timekeeping_suspended like we do
>> >> w/ __getnstimeofday64()?
>> >
>> > No, we can't.
>> >
>> >> Also, what exactly is the case when the clocksource being read isn't
>> >> accessible? I see this is conditionalized on
>> >> CLOCK_SOURCE_SUSPEND_NONSTOP, so is the concern on resume we read the
>> >> clocksource and its been reset causing a crazy time value?
>> >
>> > The clocksource's ->suspend method may have been called (during suspend)
>> > and depending on what that did we may even crash things theoretically.
>> >
>> > During resume, before the clocksource's ->resume callback, it may just
>> > be undefined behavior (random data etc).
>> >
>> > For system suspend as we have today the window is quite narrow, but after
>> > patch [4/6] from this series suspend-to-idle may suspend timekeeping and
>> > just sit there in idle for extended time (hours even) which broadens the
>> > potential exposure quite a bit.
>> >
>> > Of course, it does that with interrupts disabled, but ktime_get_mono_fast_ns()
>> > is for NMI, so theoretically, if an NMI happens while we're in suspend-to-idle
>> > with timekeeping suspended and the clocksource is not CLOCK_SOURCE_SUSPEND_NONSTOP
>> > and the NMI calls ktime_get_mono_fast_ns(), strange and undesirable things may
>> > happen.
>>
>> Ok.. No objection to the approach then. But maybe could you wrap the
>> new logic in a halt_fast_timekeeper() function? Also is there much
>> value in not halting it for SUSPEND_NONSTOP clocksources? If not,
>> might as well halt it in all cases just to simplify the conditions we
>> have to keep track of in our heads. :)
>
> I don't see a problem with doing that unconditionally.
>
> What about the appended version of the patch, then?
>
> Rafael
>
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: timekeeping: Make it safe to use the fast timekeeper while suspended
>
> Theoretically, ktime_get_mono_fast_ns() may be executed after
> timekeeping has been suspended (or before it is resumed) which
> in turn may lead to undefined behavior, for example, when the
> clocksource read from timekeeping_get_ns() called by it is
> not accessible at that time.
>
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
>  kernel/time/timekeeping.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> Index: linux-pm/kernel/time/timekeeping.c
> ===================================================================
> --- linux-pm.orig/kernel/time/timekeeping.c
> +++ linux-pm/kernel/time/timekeeping.c
> @@ -332,6 +332,35 @@ u64 notrace ktime_get_mono_fast_ns(void)
>  }
>  EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
>
> +/* Suspend-time cycles value for halted fast timekeeper. */
> +static cycle_t cycles_at_suspend;
> +
> +static cycle_t dummy_clock_read(struct clocksource *cs)
> +{
> +       return cycles_at_suspend;
> +}
> +
> +/**
> + * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
> + * @tk: Timekeeper to snapshot.
> + *
> + * It generally is unsafe to access the clocksource after timekeeping has been
> + * suspended, so take a snapshot of the readout base of @tk and use it as the
> + * fast timekeeper's readout base while suspended.  It will return the same
> + * number of cycles every time until timekeeping is resumed at which time the
> + * proper readout base for the fast timekeeper will be restored automatically.
> + */
> +static void halt_fast_timekeeper(struct timekeeper *tk)
> +{
> +       static struct tk_read_base tkr_dummy;
> +       struct tk_read_base *tkr = &tk->tkr;
> +
> +       memcpy(&tkr_dummy, tkr, sizeof(tkr_dummy));
> +       cycles_at_suspend = tkr->read(tkr->clock);
> +       tkr_dummy.read = dummy_clock_read;
> +       update_fast_timekeeper(&tkr_dummy);
> +}
> +
>  #ifdef CONFIG_GENERIC_TIME_VSYSCALL_OLD
>
>  static inline void update_vsyscall(struct timekeeper *tk)
> @@ -1294,6 +1323,7 @@ static int timekeeping_suspend(void)
>         }
>
>         timekeeping_update(tk, TK_MIRROR);
> +       halt_fast_timekeeper(tk);
>         write_seqcount_end(&tk_core.seq);
>         raw_spin_unlock_irqrestore(&timekeeper_lock, flags);


Yep, this looks much nicer. Thanks for respinning it!

Untested, but...
Acked-by: John Stultz <john.stultz@linaro.org>
