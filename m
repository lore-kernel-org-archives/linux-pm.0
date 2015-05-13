From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter() failures
Date: Wed, 13 May 2015 15:59:55 -0700
Message-ID: <7h7fsc2idw.fsf@deeprootsystems.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
	<2602092.6h7ufczYGd@vostro.rjw.lan> <5551BCBF.2000806@linaro.org>
	<2919083.VPTOth98op@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34333 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934504AbbEMW76 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 18:59:58 -0400
Received: by pacyx8 with SMTP id yx8so64290816pac.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 15:59:58 -0700 (PDT)
In-Reply-To: <2919083.VPTOth98op@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Tue, 12 May 2015 15:23:25 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, peterz@infradead.org, tglx@linutronix.de, rafael.j.wysocki@intel.com, rlippert@google.com, linux-pm@vger.kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

[...]

> Second, quite honestly, I don't see a connection to genpd here.

The connection with genpd is because the *reason* the timer was
shutdown/stopped is because it shares power with the CPU, which is why
the timer stops when the CPU hits ceratin low power states.  IOW, it's
in the same power domain as the CPU.

> What you seem to be saying is "maybe we can eliminate the need to check the
> return value of tick_broadcast_enter() in the idle loop if we proactively
> disable the TIMER_STOP idle states of a CPU when we start to use that CPU's
> timer as a broadcast one".
>
> So this seems to be about the timekeeping rather than power domains, because
> that's where the broadcast thing is done.  So the code setting up the CPU's
> timer for broadcast would pretty much need to pause cpuidle, go through the
> CPU's idle states and disable the TIMER_STOP ones.  And do the reverse when the
> timer is not going the be used for broadcast any more.  

Or..., modify the timer subystem to use runtime PM on the timer devices,
create a genpd that includes the timer device, and use
pm_genpd_attach_cpuidle() to attach that genpd so that whenever that
timer is runtime PM active, the deeper C-states cannot be hit.

> So question is whether or not this is actually really more
> straightforward than checking the return value of
> tick_broadcast_enter() in the idle loop after all.

Unfortunetly this problem doesn't only affect timers.

Daniel's broader point is that $SUBJECT series only handles this for the
timer, but there's actually a more general problem to solve for *any*
device that shares a power domain with a CPU (e.g. CPU-local
timers, interrupt controllers, performance monitoring units, floating
point units, etc. etc.)

If we keep adding checks to the idle loop for all those devices, we're
heading for a mess.  (In fact, this is exactly what CPUidle drivers in
lots of vendor trees are doing, and it is indeed quite messy, and very
vendor specific.)

Also, solving this more general problem was the primary motivation for
adding the gnpd _attach_cpuidle() feature in the first place, so why not
use that?

Longer term, IMO, these dependencies between CPUs and all these "extras"
logic that share a power domain should be modeled by a genpd.  If all
those devices are using runtime PM, including the CPUs, and they are
grouped into a genpd, then we we can very easily know at the genpd level
whether or not the CPU could be powered down, and to what level.  This
longer-term solution is what I want to discuss at LPC this year in my
"Unifiy idle management of CPUs and IO devices" topic[1].  ( Also FYI,
using a genpd to model a CPU and connected logic is part of the
motivation behind the recent proposals to add support for multiple
states to genpd by Axel Haslam. )

Anyways I digress...

In the short term, while your patches look fine to me, the objection I
have is that it's only a band-aid fix that handles timers, but none of
the other "extras" that might share a power rail with the CPU.  So,
until we have the long-term stuff sorted out, the better
short-term solution IMO is the _attach_cpuidle() one above.

Kevin

[1] http://wiki.linuxplumbersconf.org/2015:energy-aware_scheduling
