From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Tue, 28 Jun 2016 18:26:36 +0200
Message-ID: <CAMuHMdVM66516s_+Ups7fng5xpasdiUnW=3Ybz+vGHbgN+5mpQ@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org> <1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35545 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbcF1Q0i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 12:26:38 -0400
In-Reply-To: <1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf, Rafael,

On Tue, May 17, 2016 at 1:41 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>
> To make sure these helpers worked for all combinations and without
> introducing too much of complexity, the device was always resumed in
> pm_runtime_force_resume().
>
> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> unset, we needed to resume the device as the subsystem/driver couldn't
> rely on using runtime PM to do it.
>
> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> CONFIG_PM_RUNTIME.
>
> For this reason we can now rely on the subsystem/driver to use runtime PM
> to resume the device, instead of forcing that to be done in all cases. In
> other words, let's defer this to a later point when it's actually needed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/runtime.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 09e4eb1..1db7b46 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1509,6 +1509,17 @@ int pm_runtime_force_resume(struct device *dev)
>         if (!pm_runtime_status_suspended(dev))
>                 goto out;
>
> +       /*
> +        * The PM core increases the runtime PM usage count in the system PM
> +        * prepare phase. If the count is greather than 1 at this point, someone
> +        * else has also increased it. In that case, invoke the runtime resume
> +        * callback for the device as that is likely what is expected. In other
> +        * case we trust the subsystem/driver to runtime resume the device when
> +        * it's actually needed.
> +        */
> +       if (atomic_read(&dev->power.usage_count) < 2)
> +               goto out;
> +
>         ret = pm_runtime_set_active(dev);
>         if (ret)
>                 goto out;

This patch (commit eb13a0a1b6d5d5c2 in pm/linux-next) breaks resume on
sh73a0/kzm9g and r8a73a4/ape6evm. On these boards, the Ethernet controller is a
child of a local bus (bsc), whose clock (zb) is controlled through pm_clk and
simple-pm-bus, cfr.

    arch/arm/boot/dts/r8a73a4-ape6evm.dts
    arch/arm/boot/dts/r8a73a4.dtsi
    arch/arm/boot/dts/sh73a0-kzm9g.dts
    arch/arm/boot/dts/sh73a0.dtsi

During resume, the bus clock is not enabled, causing an imprecise abort
when accessing the Ethernet controller's registers. With some debug code
added:

    PM: Syncing filesystems ... done.
    PM: Preparing system for sleep (mem)
    Freezing user space processes ... (elapsed 0.001 seconds) done.
    Double checking all user space processes after OOM killer
disable... (elapsed 0.000 seconds)
    Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
    PM: Suspending system (mem)
    smsc911x: smsc911x_suspend
    simple-pm-bus fec10000.bus: simple_pm_bus_suspend
    PM: suspend of devices complete after 21.484 msecs
    PM: suspend devices took 0.030 seconds
    PM: late suspend of devices complete after 0.488 msecs
    cpg_div6_clock_disable: zb
    rmobile_pd_power_down: a3sp
    PM: noirq suspend of devices complete after 8.300 msecs
    Disabling non-boot CPUs ...
    CPU1: shutdown

    PM: early resume of devices complete after 0.488 msecs
    simple-pm-bus fec10000.bus: simple_pm_bus_resume
    smsc911x: smsc911x_resume
    Unhandled fault: imprecise external abort (0x1406) at 0xb6f40068
    pgd = deedc000
    [b6f40068] *pgd=5f774831, *pte=4087659f, *ppte=40876e7e
    Internal error: : 1406 [#1] SMP ARM
    Modules linked in:
    CPU: 0 PID: 1062 Comm: s2ram Not tainted
4.7.0-rc5-kzm9g-00391-g87777f5105e9303a-dirty #765
    Hardware name: Generic SH73A0 (Flattened Device Tree)
    task: dedc0840 ti: deee6000 task.ti: deee6000
    PC is at __smsc911x_reg_read+0x1c/0x60
    LR is at smsc911x_resume+0x78/0xd0

After reverting this patch, resume succeeds again, as the zb clock is enabled
first:

    PM: Syncing filesystems ... done.
    PM: Preparing system for sleep (mem)
    Freezing user space processes ... (elapsed 0.001 seconds) done.
    Double checking all user space processes after OOM killer
disable... (elapsed 0.000 seconds)
    Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
    PM: Suspending system (mem)
    smsc911x: smsc911x_suspend
    simple-pm-bus fec10000.bus: simple_pm_bus_suspend
    PM: suspend of devices complete after 22.460 msecs
    PM: suspend devices took 0.030 seconds
    PM: late suspend of devices complete after 0.488 msecs
    cpg_div6_clock_disable: zb
    rmobile_pd_power_down: a3sp
    PM: noirq suspend of devices complete after 8.300 msecs
    Disabling non-boot CPUs ...
    CPU1: shutdown

    Enabling non-boot CPUs ...
    CPU1 is up
    rmobile_pd_power_up: a3sp
    rmobile_pd_power_up: a4mp
    a4mp: Power on, 0x00000100 -> PSTR = 0x007b3133
    cpg_div6_clock_enable: zb
    PM: noirq resume of devices complete after 92.773 msecs
    PM: early resume of devices complete after 0.488 msecs
    simple-pm-bus fec10000.bus: simple_pm_bus_resume
    smsc911x: smsc911x_resume
    PM: resume of devices complete after 28.564 msecs
    PM: resume devices took 0.040 seconds
    PM: Finishing wakeup.
    Restarting tasks ...
    rmobile_pd_power_down: a4mp
    a4mp: Power off, 0x00000100 -> PSTR = 0x007b3033
    done.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
