From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update 2x] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Mon, 9 Feb 2015 16:20:11 +0100
Message-ID: <20150209152011.GU5029@twins.programming.kicks-ass.net>
References: <54866625.8010406@linux.intel.com>
 <16564156.c5NBzjJuA3@vostro.rjw.lan>
 <2439333.L8nfGI3YZp@vostro.rjw.lan>
 <8924978.aOrU4231JI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8924978.aOrU4231JI@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 09, 2015 at 03:54:22AM +0100, Rafael J. Wysocki wrote:
> > > > The only remaining issue might be a NMI calling into
> > > > ktime_get_mono_fast_ns() before timekeeping is resumed. Its probably a
> > > > non issue on x86/tsc, but it might be a problem on other platforms
> > > > which turn off devices, clocks, It's not rocket science to prevent
> > > > that.

> I'm not sure if this is what you meant, but here it goes.
> 
> The idea is to set up a dummy readout base for the fast timekeeper during
> timekeeping_suspend() such that it will always return the same number of cycles.
> After the last timekeeping_update() in timekeeping_suspend() we read the
> clocksource and store the result as cycles_at_suspend.  The readout base
> from the current timekeeper is copied onto the dummy and the ->read pointer
> of the dummy is set to a routine unconditionally returning cycles_at_suspend.
> Next, the dummy is passed to update_fast_timekeeper() (which has been modified
> slightly to accept the readout base instead of a whole timekeeper).
> 
> Then, if I'm not mistaken, ktime_get_mono_fast_ns() should work until the
> subsequent timekeeping_resume() and then the proper readout base for the
> fast timekeeper will be restored by the timekeeping_update() called right
> after we've cleared timekeeping_suspended.


> Index: linux-pm/kernel/time/timekeeping.c
> ===================================================================
> --- linux-pm.orig/kernel/time/timekeeping.c
> +++ linux-pm/kernel/time/timekeeping.c
> @@ -230,9 +230,7 @@ static inline s64 timekeeping_get_ns_raw
>  
>  /**
>   * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
> - * @tk:		The timekeeper from which we take the update
> - * @tkf:	The fast timekeeper to update
> - * @tbase:	The time base for the fast timekeeper (mono/raw)
> + * @tkr: Timekeeping readout base from which we take the update
>   *
>   * We want to use this from any context including NMI and tracing /
>   * instrumenting the timekeeping code itself.
> @@ -244,11 +242,11 @@ static inline s64 timekeeping_get_ns_raw
>   * smp_wmb();	<- Ensure that the last base[1] update is visible
>   * tkf->seq++;
>   * smp_wmb();	<- Ensure that the seqcount update is visible
> - * update(tkf->base[0], tk);
> + * update(tkf->base[0], tkr);
>   * smp_wmb();	<- Ensure that the base[0] update is visible
>   * tkf->seq++;
>   * smp_wmb();	<- Ensure that the seqcount update is visible
> - * update(tkf->base[1], tk);
> + * update(tkf->base[1], tkr);
>   *
>   * The reader side does:
>   *
> @@ -269,7 +267,7 @@ static inline s64 timekeeping_get_ns_raw
>   * slightly wrong timestamp (a few nanoseconds). See
>   * @ktime_get_mono_fast_ns.
>   */
> -static void update_fast_timekeeper(struct timekeeper *tk)
> +static void update_fast_timekeeper(struct tk_read_base *tkr)
>  {
>  	struct tk_read_base *base = tk_fast_mono.base;
>  
> @@ -277,7 +275,7 @@ static void update_fast_timekeeper(struc
>  	raw_write_seqcount_latch(&tk_fast_mono.seq);
>  
>  	/* Update base[0] */
> -	memcpy(base, &tk->tkr, sizeof(*base));
> +	memcpy(base, tkr, sizeof(*base));
>  
>  	/* Force readers back to base[0] */
>  	raw_write_seqcount_latch(&tk_fast_mono.seq);
> @@ -462,7 +460,7 @@ static void timekeeping_update(struct ti
>  		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
>  		       sizeof(tk_core.timekeeper));
>  
> -	update_fast_timekeeper(tk);
> +	update_fast_timekeeper(&tk->tkr);
>  }
>  
>  /**

> @@ -1251,9 +1249,18 @@ static void timekeeping_resume(void)
>  	hrtimers_resume();
>  }
>  
> -static int timekeeping_suspend(void)
> +static struct tk_read_base tkr_dummy;
> +static cycle_t cycles_at_suspend;
> +
> +static cycle_t dummy_clock_read(struct clocksource *cs)
> +{
> +	return cycles_at_suspend;
> +}
> +
> +int timekeeping_suspend(void)
>  {
>  	struct timekeeper *tk = &tk_core.timekeeper;
> +	struct clocksource *clock = tk->tkr.clock;
>  	unsigned long flags;
>  	struct timespec64		delta, delta_delta;
>  	static struct timespec64	old_delta;
> @@ -1296,6 +1303,14 @@ static int timekeeping_suspend(void)
>  	}
>  
>  	timekeeping_update(tk, TK_MIRROR);
> +
> +	if (!(clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP)) {
> +		memcpy(&tkr_dummy, &tk->tkr, sizeof(tkr_dummy));
> +		cycles_at_suspend = tk->tkr.read(clock);
> +		tkr_dummy.read = dummy_clock_read;
> +		update_fast_timekeeper(&tkr_dummy);
> +	}
> +
>  	write_seqcount_end(&tk_core.seq);
>  	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);

Yeah, I think that that should work. John any objections?
