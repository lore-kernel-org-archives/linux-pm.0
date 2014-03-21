From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] sh_eth: pm_runtime should not need null operations
Date: Fri, 21 Mar 2014 14:24:51 +0100
Message-ID: <CAMuHMdVhUwX0DO2+TBhG31HB2sx3_XRW3xPfZ+wH2d8b=RywLQ@mail.gmail.com>
References: <1395396913-24354-1-git-send-email-ben.dooks@codethink.co.uk>
	<CAMuHMdWO-kNdWT_AxzAmCTrx3NerWpTG+auFNZTcL5hsbN+++A@mail.gmail.com>
	<532C1B13.7000805@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38054 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965138AbaCUNYw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 09:24:52 -0400
In-Reply-To: <532C1B13.7000805@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Linux-sh list <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ben,

(dropping netdev and davem, adding Felipe, Kevin, linux-pm, and
linux-arm-kernel)

On Fri, Mar 21, 2014 at 11:57 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 21/03/14 11:30, Geert Uytterhoeven wrote:
>> On Fri, Mar 21, 2014 at 11:15 AM, Ben Dooks <ben.dooks@codethink.co.uk>
>> wrote:
>>> The driver has a no-op for the pm_runtime callbacks but
>>> the pm_runtime core should correctly ignore drivers without
>>> any pm_rumtime callback ops.
>>
>> The pm_runtime core doesn't ignore non-existing runtime_{suspend,resume}
>> callbacks, it turns them into a failure withv -ENOSYS.
>> Only non-existing runtime_idle callbacks are ignored.
>
> I've added Rafael Wysocki as he may be able to add better
> feedback to this issue.
>
> [snip rpm_susend code block]
>
> I got very confused here. The clock_ops sets dev->pm_domain
> which over-rides the use of the dev->driver->pm entry as the
> primary pm for the device. The code above the bit you snipped
> does a ladder looking for the pm_runtime entry it calls and
> would stop at finding dev->pm_domain as so:
>
> from drivers/base/power/runtime.c:
>     495         if (dev->pm_domain)
>     496                 callback = dev->pm_domain->ops.runtime_suspend;
>  ...
>     502                 callback = dev->bus->pm->runtime_suspend;
>     503         else
>     504                 callback = NULL;
>
>
> So for drivers on shmobile with drivers/sh/pm_runtime.c enabled
> we would never call the drivers' entry as the ops that this code
> introduces just calls the pm_clk calls and does not send the
> events on.

Yes, that's also my understanding.

Commit 4d27e9dcff00a6425d779b065ec8892e4f391661 ("PM: Make
power domain callbacks take precedence over subsystem ones") explains
the rationale behind this.

Now, this doesn't prevent your power domain from delegating to other
callbacks...

> If we send the events on, then we would use pm_generic_runtime_suspend()
> to send it. This call treats the lack of runtime_pm driver entry as a
> do nothing and return 0 which means in this case the code in sh_eth
> is not necessary to have any pm_runtime functions.

If the power domain just calls pm_generic_runtime_suspend(), it will only
consider the driver-specific callback, bypassing type, class, and
bus-specific callbacks.

So should the power domain delegate it further using a similar ladder
strategy like RPM_GET_CALLBACK() at the core pm level, i.e.
try type/class/bus/driver?
And type should delegate to class/bus/driver, class to bus/driver, bus to
driver?

> This means depending on if we have a pm_domain in the path we get
> different treatment of NULL runtime pm ops pointer. I am not sure
> how to handle this, as IIRC a number of other drivers for Renesas
> currently assume that the NULL case is going to be fine for them.
>
> Changing pm_generic_runtime_suspend() to return ENOSYS would end
> up breaking davinci and probably a number of other platforms.
>
> So questions:
>
> - Should rpm_suspend() ignore the lack of pm_runtime operations?
> - Do we need to add a generic `ignore pm runtime callback`
> - Are any other shmobile drivers similarly affected?

The code indeed looks a bit like a mix of:
  - Lack of callback means it's safe to suspend,
  - Lack of callback means it's not safe to suspend.

BTW, I also looked a bit into history, and added asterisks in front of the
most interesting parts:

 1. drivers/sh/pm_runtime.c
    Initial version by Magnus, reworked by Rafael

 2. This approach was applied to omap1, "to allow code sharing with shmobile",
    in commit 600b776eb39a13a28b090ba9efceb0c69d4508aa
    ("OMAP1 / PM: Use generic clock manipulation routines for runtime PM")
    by Rafael, acked-by Kevin Hilman.
*   This one is interesting, as it moves omap1 away from the
*   fck/ick-centric approach Felipe proposed to generalize in
*   https://lkml.org/lkml/2014/1/31/290

 3. Kevin converted omap2 in commit
    commit 638080c37ae08fd0c44cec13d7948ca5385ae851 ("OMAP2+ / PM: move
    runtime PM implementation to use device power domains")
*   and fixed it for power domain callbacks taking precedence in commit
*   345f79b3de7f6d651e4dba794af7c7303bdfd649 ("OMAP: PM: omap_device: fix
*   device power domain callbacks").
*   This is what Ben is proposing to add to drivers/sh/pm_runtime.c.

 4. Kevin converted davinci in commit
    ce9dcb8784611c50974d1c6b600c71f5c0a29308 ("ARM: davinci: add runtime PM
    support for clock management").

 5. which got copied by Santosh Shilimkar for keystone in commit
    fc20ffe1213beb09bb7fb6687b404fe48183a55e ("ARM: keystone: add PM domain
    support for clock management").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
