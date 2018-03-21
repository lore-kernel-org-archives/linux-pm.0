From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v7 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Wed, 21 Mar 2018 15:36:39 +0100
Message-ID: <CAJZ5v0j-CnEms-Wm0Op=386ceuG2GfAouVLXO48rbD_pUPJhMg@mail.gmail.com>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1635957.yuHkCe9oyz@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 20, 2018 at 4:45 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add a new pointer argument to cpuidle_select() and to the ->select
> cpuidle governor callback to allow a boolean value indicating
> whether or not the tick should be stopped before entering the
> selected state to be returned from there.
>
> Make the ladder governor ignore that pointer (to preserve its
> current behavior) and make the menu governor return 'false" through
> it if:
>  (1) the idle exit latency is constrained at 0, or
>  (2) the selected state is a polling one, or
>  (3) the expected idle period duration is within the tick period
>      range.
>
> In addition to that, the correction factor computations in the menu
> governor need to take the possibility that the tick may not be
> stopped into account to avoid artificially small correction factor
> values.  To that end, add a mechanism to record tick wakeups, as
> suggested by Peter Zijlstra, and use it to modify the menu_update()
> behavior when tick wakeup occurs.  Namely, make it add a (sufficiently
> large) constant value to the correction factor in these cases (instead
> of increasing the correction factor by a value based on the
> measured idle time).
>
> Since the value returned through the new argument pointer of
> cpuidle_select() is not used by its caller yet, this change by
> itself is not expected to alter the functionality of the code.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v5 -> v7:
>  * Rename the new cpuidle_select() arg (and some related things) from
>    "nohz" to "stop_tick" (as requested by Peter).
>  * Use TICK_USEC from the previous patch.
>  * Record tick wakeups (as suggested by Peter) and use them to take the
>    tick into account in menu_update().

[cut]

> @@ -427,31 +449,44 @@ static void menu_update(struct cpuidle_d
>          * assume the state was never reached and the exit latency is 0.
>          */
>
> -       /* measured value */
> -       measured_us = cpuidle_get_last_residency(dev);
> -
> -       /* Deduct exit latency */
> -       if (measured_us > 2 * target->exit_latency)
> -               measured_us -= target->exit_latency;
> -       else
> -               measured_us /= 2;
> -
> -       /* Make sure our coefficients do not exceed unity */
> -       if (measured_us > data->next_timer_us)
> -               measured_us = data->next_timer_us;
> -
>         /* Update our correction ratio */
>         new_factor = data->correction_factor[data->bucket];
>         new_factor -= new_factor / DECAY;
>
> -       if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
> -               new_factor += RESOLUTION * measured_us / data->next_timer_us;
> -       else
> +       if (data->tick_wakeup) {

This should check if data->next_timer_us is greater than TICK_USEC
too, but also the measured_us computation needs to go before it (or
uninitialized measured_us will be used later on if this branch is
executed).

So please disregard this one entirely and take the v7.2 replacement
instead of it: https://patchwork.kernel.org/patch/10299429/

The current versions (including the above) is in the git branch at

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 idle-loop-v7.2

>                 /*
> -                * we were idle so long that we count it as a perfect
> -                * prediction
> +                * If the CPU was woken up by the tick, it might have been idle
> +                * for a much longer time if the tick had been stopped.  That
> +                * time cannot be determined, so asssume that it would have been
> +                * long, but not as long as the original return value of
> +                * tick_nohz_get_sleep_length().  Use a number between 0.5 and
> +                * 1, something like 0.75 (which is easy enough to get), that
> +                * should work on the average.
>                  */
> -               new_factor += RESOLUTION;
> +               new_factor += RESOLUTION / 2 + RESOLUTION / 4;
> +       } else {
> +               /* measured value */
> +               measured_us = cpuidle_get_last_residency(dev);
> +
> +               /* Deduct exit latency */
> +               if (measured_us > 2 * target->exit_latency)
> +                       measured_us -= target->exit_latency;
> +               else
> +                       measured_us /= 2;
> +
> +               /* Make sure our coefficients do not exceed unity */
> +               if (measured_us > data->next_timer_us)
> +                       measured_us = data->next_timer_us;
> +
> +               if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
> +                       new_factor += RESOLUTION * measured_us / data->next_timer_us;
> +               else
> +                       /*
> +                        * we were idle so long that we count it as a perfect
> +                        * prediction
> +                        */
> +                       new_factor += RESOLUTION;
> +       }
>
>         /*
>          * We don't want 0 as factor; we always want at least
