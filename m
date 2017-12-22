From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states after some time
Date: Fri, 22 Dec 2017 20:37:27 +0100
Message-ID: <2564620.HWZxrpkEQa@aspire.rjw.lan>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de> <CAJZ5v0iJqcOJZjbkbgCnzdZX9eNe7Hkusqv_D+insvrsYZf-rw@mail.gmail.com> <ea114868-3e54-92a9-d052-c1720622723e@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:57704 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756167AbdLVTiU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 14:38:20 -0500
In-Reply-To: <ea114868-3e54-92a9-d052-c1720622723e@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>, Marcus =?ISO-8859-1?Q?H=E4hnel?= <mhaehnel@os.inf.tu-dresden.de>, Daniel Hackenberg <daniel.hackenberg@tu-dresden.de>, Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>

On Thursday, December 21, 2017 10:43:20 AM CET Thomas Ilsche wrote:
>  This is a cryptographically signed message in MIME format.
> 
> --------------ms090505030709050404040303
> Content-Type: text/plain; charset=utf-8; format=flowed
> Content-Language: en-US
> Content-Transfer-Encoding: quoted-printable
> 
> Hi Rafael,
> 
> you mentioned upcoming tick-related changes. Could you please give me a q=
> uick pointer or summary to the discussion?

There is another problem with stopping the tick during idle entry before
invoking the governor, which happens if the governor predicts short idle
duration and it is right (note that the problem you are considering happens
when the governor predicts short idle duration and it is wrong).  In that
case, stopping the tick and possibly reprogramming the timer adds overhead
that is completely unnecessary (and people have been complaining about that
for a long time AFAICS).

Aubrey has been working on this for quite some time, but his last proposal
still wasn't what we wanted.  Basically, however, it is about invoking the
governor before the tick is stopped to avoid issues.

> > Regardless, this is the long-term way to go IMO not just to address
> > this issue, but also to avoid unneeded overhead of stopping the tick.
> >=20
> > The tick should only be stopped when we know for a fact that it is
> > worth the overhead which is only when we know that the target
> > residency of the idle state we want to enter is longer than the time
> > to the next tick.  Note that this doesn't depend on the idle governor
> > in use at all.
> 
> The residency is a bad condition. For example the deepest sleep state on =
> SKL-SP
> has a target residency of 600 us. That is typically less than a schedulin=
> g tick.
> Your suggestion you would keep the tick timer enabled most of the time,
> effectively disabling dyntick-idle.
> 
> One could consider keeping the enabled sched-tick for sleep states that a=
> re not
> the deepest as per QOS requirements.

Quite obviously, the tick should still be stopped if the selected state is the
deepest one that can be used (either overall or because of QoS restrictions)
unless it is a "polling" state.

> Note that currently the QOS-check ha=
> ppens
> in the governor.

But since both the existing governors check it in the same way, this isn't
a limitation.

> This would be sub-optimal if the deepest sleep state can=
>  hardly
> be reached, e.g. on systems with very high residencies. Overall residency=
>  is not
> a good criteria, as it's just the minimum time for the C-state to be effe=
> ctive -
> sleeping for longer often improves energy efficiency a lot.

Unless there is a deeper state you can use, that is.

The logic there can be tweaked, but anyway adding an extra timer *after*
stopping the tick is not an option, because it adds more overhead to the
other case mentioned above in which there is too much overhead already.

> We looked at the possible combination of upcoming events (selected C-stat=
> e
> residency, next scheduling timer, next non-scheduling timer, heuristicall=
> y
> predicted wakeup time). It is more complicated than I originally thought,=
>  but we
> think that the following decision would be desired:
> 
> if next_timer_is_sched {
>      if heuristically_predicted_time < next_timer * alpha [0.9] {
>           ** Simple case **
>           // This is a potential case where the selected sleep state is
>           // suboptimal due to poor heuristic - we use the sched tick as =
> fallback
>           // to wakeup
>           // If the prediction is correct, there is no need to disable th=
> e
>           // scheduling tick, but it if is incorrect, we can use the sche=
> duling
>           // tick as a fallback wakeup
>           // Alpha is used such that if the heuristic predicts the sched =
> time
>           // we can still disable the timer.
>           keep_sched_timer_enabled();
>      } else {
>           // ** Complicated case **
>           // Usually we must cancel the sched tick here, because it would=
>  shorten
>           // our sleep time.
>           disable_sched_timer();
>           // Check if this is a potential case of a mispredicting heurist=
> ic
>           // causing a long residency in a suboptimal sleep state
>           // (a.k.a. a Powernightmare)
>           // Unfortunately this is not easy to check and requires a trade=
> -off
>           // between false positives (unnecessary timer overhead)
>           // and false negatives (certain amount of time spent in bad idl=
> e state)
>           if (heuristically_predicted_time < next_non_sched_timer * beta =
> [0.1])
>               && (next_non_sched_timer > threshold)
>               && (selected idle state < deepest_state_qos)
>               enable_fallback_timer();
>           }
>      }
> } else {
>      // We don't need to bother stopping the sched tick, another timer wi=
> ll wake
>      // the CPU before anyway
>      keep_sched_timer_enabled();
> }
> 
> The residency of the selected sleep state doesn't play a role in the deci=
> sion.

At least in principle it should, because idle duration may still be mispredicted
at least occasionally (it is fundamentally nondeterministic after all) and there
should be some kind of safety net for that (which is missing today).

> I would consider to set "threshold" (the maximum duration of a tolerated st=
> ay in a
> bad sleep state) to the residency of the next higher sleep state with a f=
> actor.
> 
> It also seems that the next non-sched timer seems to be difficult to dete=
> rmine.
> Reading it via tick_nohz_get_sleep_length would force the code to disable=
>  the
> sched timer before being able to make the actual decision which state to =
> go to.
> 
> Unfortunately in the complicated case, the sched timer is not optimal as =
> a
> fallback as it will be before the heuristically predicted wakeup and poss=
> ibly
> even before the residency time of the selected sleep state. On the one ha=
> nd it
> may be required set a timer to prevent a long suboptimal sleep state, on =
> the
> other hand the scheduling tick will decrease sleep time if the heuristic =
> is
> correct, and can even cause the selection of worse sleep states. Therefor=
> e in
> this case a custom callback using a time between the heuristic and the ac=
> tual
> next timer set further in the future would prevent issues.
> 
> For a system where the deepest sleep state has a residency << 1/HZ, the s=
> imple
> case is more likely than the complicated one. However, this is not true o=
> n all
> systems.
> 
> Unfortunately this doesn't yet address the question how to implement the
> decision among idle loop / governor.

I've been looking at this for some time and I have some ideas, but I still need
to do some verification, so I'm not yet ready to discuss them in detail ATM.

Thanks,
Rafael
