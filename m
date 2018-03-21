From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v7.1 5/8] cpuidle: Return nohz hint from cpuidle_select()
Date: Wed, 21 Mar 2018 12:52:21 +0100
Message-ID: <CAJZ5v0i7AE=HEp1guNdpSV7=a-GS=e00+K1kG7Q6SYnK2g6cZA@mail.gmail.com>
References: <2390019.oHdSGtR3EE@aspire.rjw.lan> <1635957.yuHkCe9oyz@aspire.rjw.lan>
 <2111949.c172CzMuf8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2111949.c172CzMuf8@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 21, 2018 at 7:48 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
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
> suggested by Peter Zijlstra, and use it to modify the menu_reflect()
> behavior when tick wakeup occurs.  Namely, if the CPU is woken up by
> the tick, the predicted idle duration is likely too short, so make
> menu_reflect() try to compensate by bumping up the correction factor
> with a (sufficiently large) constant value.
>
> Since the value returned through the new argument pointer of
> cpuidle_select() is not used by its caller yet, this change by
> itself is not expected to alter the functionality of the code.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Another variant of patch [5/8] to test.
>
> This one doesn't run menu_update() at all on tick wakeups, but simply
> bumps up the correction factor alone then.

I have overlooked one thing in this patch and in the original v7 of it.

Namely, tick wakeups occurring when the return value of
tick_nohz_get_sleep_length() is within the tick boundary should be
treated as normal wakeups, because the nohz code itself doesn't stop
the tick then even without this patch series.

I'll rework this patch for that and will send an update shortly.

Thanks!
