From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 9 Jan 2018 19:46:29 +0100
Message-ID: <CAJZ5v0jVon9PjiDti106kT4s87GW6tuLKY=ZNfkE=eMqOwdDVA@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <303007688.lvsDLFNCpe@aspire.rjw.lan>
 <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42306 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756910AbeAISqa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jan 2018 13:46:30 -0500
In-Reply-To: <CAMuHMdX=rc4M9oO0dFQ9b2TtRgUXRG_37sw+MVJ3REeAa-0ogw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lukas Wunner <lukas@wunner.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 9, 2018 at 2:37 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Rafael,
>
> On Wed, Jan 3, 2018 at 12:06 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> One of the limitations of pm_runtime_force_suspend/resume() is that
>> if a parent driver wants to use these functions, all of its child
>> drivers have to do that too because of the parent usage counter
>> manipulations necessary to get the correct state of the parent during
>> system-wide transitions to the working state (system resume).
>> However, that limitation turns out to be artificial, so remove it.
>>
>> Namely, pm_runtime_force_suspend() only needs to update the children
>> counter of its parent (if there's is a parent) when the device can
>> stay in suspend after the subsequent system resume transition, as
>> that counter is correct already otherwise.  Now, if the parent's
>> children counter is not updated, it is not necessary to increment
>> the parent's usage counter in that case any more, as long as the
>> children counters of devices are checked along with their usage
>> counters in order to decide whether or not the devices may be left
>> in suspend after the subsequent system resume transition.
>>
>> Accordingly, modify pm_runtime_force_suspend() to only call
>> pm_runtime_set_suspended() for devices whose usage and children
>> counters are at the "no references" level (the runtime PM status
>> of the device needs to be updated to "suspended" anyway in case
>> this function is called once again for the same device during the
>> transition under way), drop the parent usage counter incrementation
>> from it and update pm_runtime_force_resume() to compensate for these
>> changes.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This patch causes a regression during system resume on Renesas Salvator-XS
> with R-Car H3 ES2.0:
>
>     SError Interrupt on CPU3, code 0xbf000002 -- SError
>     SError Interrupt on CPU2, code 0xbf000002 -- SError
>     CPU: 3 PID: 1769 Comm: kworker/u16:13 Not tainted
> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>     CPU: 2 PID: 1774 Comm: kworker/u16:18 Not tainted
> 4.15.0-rc7-arm64-renesas-05338-gf14cf570a813c9ca-dirty #97
>     Hardware name: Renesas Salvator-X 2nd version board based on
> r8a7795 ES2.0+ (DT)
>     Hardware name: Renesas Salvator-X 2nd version board based on
> r8a7795 ES2.0+ (DT)
>     Workqueue: events_unbound async_run_entry_fn
>     Workqueue: events_unbound async_run_entry_fn
>     pstate: 60000005 (nZCv daif -PAN -UAO)
>     pstate: 60000005 (nZCv daif -PAN -UAO)
>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>     pc : rcar_gen3_phy_usb2_init+0x34/0xf8
>     lr : phy_init+0x64/0xcc
>     lr : phy_init+0x64/0xcc
>     ...
>     Kernel panic - not syncing: Asynchronous SError Interrupt
>
> Note that before, it printed a warning instead:
>
>     Enabling runtime PM for inactive device (ee0a0200.usb-phy) with
> active children
>     WARNING: CPU: 0 PID: 1741 at drivers/base/power/runtime.c:1300
> pm_runtime_enable+0x94/0xd8
>
> Reverting commit 0408584d580d4a2c ("PM / runtime: Rework
> pm_runtime_force_suspend/resume()") fixes the crash.

It looks like what happens without the Ulf's patch is as follows.

usb-phy has children with runtime PM enabled that are not in the
domain, so without the $subject patch the pm_runtime_force_suspend()
in genpd_finish_suspend() checks the usage counter of usb-phy and
since it is 1, the parent's usage counter is not incremented and
genpd_runtime_suspend() is run for usb-phy.  On resume, the
pm_runtime_force_resume() in genpd_resume_noirq() finds that the usage
counter of usb-phy is 1, so the parent's usage counter is not
decremented (correctly) and the function returns (arguably incorrectly
if the runtime PM status of the children is "active", because it is
necessary to resume the children in that case, but the children have
no PM callbacks and even if they had had them, they would have been
run later anyway).  The parent of usb-phy is skipped by the
pm_runtime_force_resume() too, because its usage counter is 1 when it
is checked by this function.

With the $subject patch pm_runtime_force_suspend() in
genpd_finish_suspend() calls pm_runtime_need_not_resume() and that
returns "false" for usb-phy if the runtime PM status or at least one
of its children is "active" (which it is for the "phy" devices).  That
is correct, but for this reason the parent's children counter is not
decremented and both usb-phy and its parent will be resumed by the
subsequent pm_runtime_force_resume().

The pm_runtime_force_resume() in genpd_resume(_noirq) now finds that
pm_runtime_need_not_resume() returns "false" for both usb-phy and its
parent and attempts to resume them both via genpd_runtime_resume()
which is too early, because stuff they depend on hasn't been resumed
yet.  That triggers the crash (so
https://patchwork.kernel.org/patch/10152767/ will cause the crash to
happen too).

In conclusion, without the $subject patch it all works pretty much by
accident, basically because the pm_runtime_force_resume()
inadvertently decides to skip the resume of some devices which avoids
the premature execution of genpd_runtime_resume() for them.

> Note that applying Ulf's "[PATCH v2 0/3] phy: core: Re-work runtime PM
> deployment and fix an issue"
> (https://www.spinics.net/lists/linux-renesas-soc/msg21719.html) instead
> does not fix the crash.

I'm not sure why the crash is still there in this case, but quite
likely it is related (again) to something with a child outside of the
domain that causes its parent to be treated as a device that must be
resumed and that triggers a premature execution of
genpd_runtime_resume() in genpd_resume_noirq() for the parent (because
something the parents depends on quite likely is outside of the domain
and will be resumed later).

Granted, the (indirect) invocation of genpd_runtime_suspend() in
genpd_finish_suspend() is too late for drivers that are not expecting
it to be called then (but also harmless if the drivers check the
status of the devices) and the (indirect) invocation of
genpd_runtime_resume() from genpd_resume_noirq() is too early,
especially if there are dependencies on devices outside the domains
handled by genpd.

So something like https://patchwork.kernel.org/patch/10152873/ is needed IMO.

Thanks,
Rafael
