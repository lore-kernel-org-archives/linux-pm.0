From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: Do not use CPUIDLE_DRIVER_STATE_START in cpuidle.c
Date: Thu, 28 May 2015 02:51:50 +0200
Message-ID: <1473245.9TigmpKj4V@vostro.rjw.lan>
References: <5494512.JcUbNX5Mxs@vostro.rjw.lan> <CAJZ5v0hn__7KRqOTpBYAk8EfV28xD54G0MaetaJ6HH5uUE3wQw@mail.gmail.com> <5565EEAA.8010900@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65237 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750922AbbE1A0T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 20:26:19 -0400
In-Reply-To: <5565EEAA.8010900@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>

On Wednesday, May 27, 2015 09:49:54 PM Preeti U Murthy wrote:
> On 05/27/2015 07:27 PM, Rafael J. Wysocki wrote:
> > On Wed, May 27, 2015 at 2:25 PM, Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >> On 05/27/2015 01:31 PM, Preeti U Murthy wrote:
> >>>
> >>> On 05/27/2015 07:06 AM, Rafael J. Wysocki wrote:
> >>>>
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>
> >>>> The CPUIDLE_DRIVER_STATE_START symbol is defined as 1 only if
> >>>> CONFIG_ARCH_HAS_CPU_RELAX is set, otherwise it is defined as 0.
> >>>> However, if CONFIG_ARCH_HAS_CPU_RELAX is set, the first (index 0)
> >>>> entry in the cpuidle driver's table of states is overwritten with
> >>>> the default "poll" entry by the core.  The "state" defined by the
> >>>> "poll" entry doesn't provide ->enter_dead and ->enter_freeze
> >>>> callbacks and its exit_latency is 0.
> >>>>
> >>>> For this reason, it is not necessary to use CPUIDLE_DRIVER_STATE_START
> >>>> in cpuidle_play_dead() (->enter_dead is NULL, so the "poll state"
> >>>> will be skipped by the loop) and in find_deepest_state() (since
> >>>> exit_latency is 0, the "poll state" will become the default if the
> >>>> "s->exit_latency <= latency_req" check is replaced with
> >>>> "s->exit_latency < latency_req" which may only matter for drivers
> >>>> providing different states with the same exit_latency).
> >>>>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> ---
> >>>>   drivers/cpuidle/cpuidle.c |    8 ++++----
> >>>>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> <snip>
> >>>
> >>>>
> >>>> @@ -79,13 +79,13 @@ static int find_deepest_state(struct cpu
> >>>>                               bool freeze)
> >>>>   {
> >>>>         unsigned int latency_req = 0;
> >>>> -       int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
> >>>> +       int i, ret = -ENXIO;
> >>>>
> >>>> -       for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> >>>> +       for (i = 0; i < drv->state_count; i++) {
> >>>>                 struct cpuidle_state *s = &drv->states[i];
> >>>>                 struct cpuidle_state_usage *su = &dev->states_usage[i];
> >>>>
> >>>> -               if (s->disabled || su->disable || s->exit_latency <=
> >>>> latency_req
> >>>> +               if (s->disabled || su->disable || s->exit_latency <
> >>>> latency_req
> >>>
> >>>
> >>> Prior to this patch,
> >>>
> >>> For drivers on which CPUIDLE_DRIVER_STATE_START takes a value 0 and
> >>> whose first idle state has an exit_latency of 0, find_deepest_state()
> >>> would return -1 if it failed to find a deeper idle state.
> >>> But as an effect of this patch, find_deepest_state() returns 0 in the
> >>> above circumstance.
> >>
> >>
> >> Except I am missing something, with an exit_latency = 0, the state will be
> >> never selected, because of the "s->exit_latency < latency_req" condition
> >> (strictly greater than).
> > 
> > No, this is the condition to skip the state, so previously it wouldn't
> > be selected, but after the patch it will.
> > 
> > So yes, the patch changes behavior for systems with
> > CONFIG_ARCH_HAS_CPU_RELAX unset.
> > 
> >>> My concern is if these drivers do not intend to enter a polling state
> >>> during suspend, this will cause an issue, won't it?
> > 
> > The change in behavior happens for architectures where
> > CONFIG_ARCH_HAS_CPU_RELAX is not set.  In those cases the 0-index
> > state is supposed to be provided by the driver.  Is there a reason to
> > expect that this may not be a genuine idle state?
> 
> On PowerPC, we have the 0-index idle state, whose exit_latency is 0 and
> all that the CPU does in this state, is poll on need_resched(), except
> at a lower priority from the hardware's standpoint. Nevertheless, the
> CPU is busy polling. So, I would not consider it a genuine idle state.

OK, that's good to know.

Arguably, then, returning states with exit_latency equal to 0 from
find_deepest_state() may not be safe in general.

Well, we can make that rule, so I'll send an updated patch with that taken
into account.

> On a side note, we do not yet support suspend on Power servers, but we
> may in the future. Hence the concern.
> 
> >> Definitively poll can cause thermal issues, especially when suspending. It
> >> is a dangerous state (let's imagine you close your laptop => suspend/poll
> >> and then put it in your bag for a travel).
> > 
> > With ARCH_HAS_CPU_RELAX set the "poll state" is supposed to be thermally safe.
> > 
> >> I don't think with the code above we can reach this situation but I agree
> >> this is something we have to take care carefully.
> >>
> >> Actually, I am in favour of removing poll at all from the cpuidle driver and
> >> poll only when a cpuidle state selection fails under certain condition.
> >>
> >> So I fully agree with your statement below.
> >>
> >>> I would expect the cpus to be in a hardware
> >>> defined idle state.
> > 
> > Well, except for the degenerate case in which all of them are disabled
> > and for the "broadcast timer stopping aviodance" use case for
> > find_deepest_state().
> 
> During suspend, the CPUs can very well enter states where the timer
> stops since we stop timer interrupts anyway.

That's if you provide ->enter_freeze callbacks, otherwise it works like
runtime idle.

> So unless the idle states
> are explicitly disabled by the user/hardware for some reason, deeper
> idle states will still be available during suspend as far as I can see.

The case at hand is when ->enter_freeze callbacks are not available or
all states having them are disabled.

> > So there are two questions in my view:
> > (1) Should find_deepest_state() ever return states with exit_latency equal to 0?
> 
> I would say no, since such an idle state would mostly be polling on a
> wakeup event. Atleast, there is one such case in PowerPC.

OK

> > (2) If the answer to (1) is "yes", should the "poll state" be ever
> > returned by find_deepest_state()?
> > 
> > In any case, find_deepest_state() will only return a state with
> > exit_latency equal to 0 if there's no other choice and if it returns
> > nothing, we'll fall back to the architecture idle method.  So the
> > question really is whether or not falling back to arch idle is any
> > better than using any state we have in the table.
> 
> My suggestion is to *not* fall back to arch idle code, since that is a
> black box from the core cpuidle's perspective.

Well, we do that today in some cases.

> > The patch is based on the assumption that any state from the table
> > will be better than arch idle, including the "polling state".  If that
> > does not hold, we'll need to rethink a couple of other things in my
> > view.
> 
> We could fail suspend if a non-polling idle state is not available perhaps ?

The only thing we can do is to wake up the system immediately if there's
no "genuine" state to enter.  I can send a (separate) patch for that too.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
