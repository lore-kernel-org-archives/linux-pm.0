From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Allow menu governor to enter deeper sleep states
 after some time
Date: Fri, 15 Dec 2017 15:23:05 +0100
Message-ID: <CAJZ5v0iJqcOJZjbkbgCnzdZX9eNe7Hkusqv_D+insvrsYZf-rw@mail.gmail.com>
References: <a181bf42-9462-476c-6dcd-39fc7151957f@tu-dresden.de>
 <000101d34938$da740870$8f5c1950$@net> <000801d34a78$cdd27890$697769b0$@net>
 <002c01d35d0f$8b0416f0$a10c44d0$@net> <000a01d3654a$c4996990$4dcc3cb0$@net>
 <17b7bd4f-6b4d-2561-8895-f1dd32f9a171@tu-dresden.de> <25c78d66-9c2a-012c-6574-a687519d4820@tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:45415 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755834AbdLOOXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 09:23:07 -0500
Received: by mail-oi0-f41.google.com with SMTP id x20so6241167oix.12
        for <linux-pm@vger.kernel.org>; Fri, 15 Dec 2017 06:23:06 -0800 (PST)
In-Reply-To: <25c78d66-9c2a-012c-6574-a687519d4820@tu-dresden.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Ilsche <thomas.ilsche@tu-dresden.de>
Cc: Doug Smythies <dsmythies@telus.net>, Len Brown <lenb@kernel.org>, Yu Chen <yu.c.chen@intel.com>, =?UTF-8?Q?Marcus_H=C3=A4hnel?= <mhaehnel@os.inf.tu-dresden.de>, Daniel Hackenberg <daniel.hackenberg@tu-dresden.de>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, mario.bielert@tu-dresden.de, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Dec 15, 2017 at 11:44 AM, Thomas Ilsche
<thomas.ilsche@tu-dresden.de> wrote:
> Len, Doug,
>
> we just saw very bad Powernightmares on a freshly installed dual socket 36
> core

Can you please refrain from using marketing language for describing
technical issues?

> Skylake system. There is a particular steep increase in AC system power from
> 69 W to 120 W just from having a single core not in the deepest state.
> Together with high occurrence and persistence, this raises average idle
> power
> from 69 W to 92 W. You can see a typical example power chart at [1] measured
> externally right after the installation. This is a default installation of
> Ubuntu 16.04, but upgrading to a 4.15.0-rc3 kernel provides no help.
>
> This issue is probably wasting a couple Megawatts globally, and it's getting
> worse with newer Intel processor generations. I like to reinforce the offer
> to help develop and test a patch, but the points below need to be addressed
> by an experienced kernel developer / maintainer.
>
> We acknowledge your suggestion to keep the scheduling ticks running instead
> of using an additional fallback timer. Still, we need a solution with
> manageable code changes without tightly coupling different software layers.
> Unfortunately, the tick-timer is disabled early in the outer idle-loop in
> do_idle(), but the C-state decision is taken in the governor.
>
> In your opinion, what is the best solution?
> (a) re-enable the tick-timer? (not a very clean solution)
> (b) moving the tick-timer disabling?

Yes.

> (could be very intrusive in terms of LOC,
> we have no overview on which assumptions would break if we do this)

Regardless, this is the long-term way to go IMO not just to address
this issue, but also to avoid unneeded overhead of stopping the tick.

The tick should only be stopped when we know for a fact that it is
worth the overhead which is only when we know that the target
residency of the idle state we want to enter is longer than the time
to the next tick.  Note that this doesn't depend on the idle governor
in use at all.

And since this is the long-term way to go anyway, why don't we just do
it right away?

> (c) use the fallback timer (not elegant, since there are already ticks)
>
> Regarding the C0/poll_idle problem, what is suitable as abort criterion:
> (a) interrupt counts
> (b) tick_nohz_get_sleep_length
> (c) tick_sched->idle_expires

Can you please remind me what that problem is exactly?

Thanks,
Rafael
