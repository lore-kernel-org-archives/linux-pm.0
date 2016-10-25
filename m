From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Don't allow to suspend a device with an
 active child
Date: Tue, 25 Oct 2016 15:59:52 +0200
Message-ID: <CAMuHMdX4Si0pfZ0cnZU=KC+kHK0bJiLcArqLLaU1Rw7-zZ0bsA@mail.gmail.com>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org> <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32888 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758918AbcJYN7y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2016 09:59:54 -0400
In-Reply-To: <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

On Mon, Oct 17, 2016 at 8:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When resuming a device in __pm_runtime_set_status(), the prerequisite is
> that its parent must already be active, else an error code is returned and
> the device's status remains suspended.
>
> When suspending a device there is no similar constraints being validated.
> Let's change this to make the behaviour consistent, by not allowing to
> suspend a device with an active child, unless it has been explicitly set to
> ignore its children.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This is now commit 8b1107b85efd78c in pm/linux-next.

This breaks resume from s2ram on r8a73a4/ape6evm and sh73a0/kzm9g, where the
smsc911x Ethernet is connected to an external bus, whose clock is controlled
through Runtime PM and the simple-pm-bus driver.

Reverting this commit fixes the issue.

> ---
>  drivers/base/power/runtime.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index f47a345..6f946a3 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1028,7 +1028,17 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
>                 goto out_set;
>
>         if (status == RPM_SUSPENDED) {
> -               /* It always is possible to set the status to 'suspended'. */
> +               /*
> +                * It is invalid to suspend a device with an active child,
> +                * unless it has been set to ignore its children.
> +                */
> +               if (!dev->power.ignore_children &&
> +                       atomic_read(&dev->power.child_count)) {
> +                       dev_err(dev, "runtime PM trying to suspend device but active child\n");
> +                       error = -EBUSY;
> +                       goto out;
> +               }
> +
>                 if (parent) {
>                         atomic_add_unless(&parent->power.child_count, -1, 0);
>                         notify_parent = !parent->power.ignore_children;

Kernel output difference, with some additional debug info:

| --- GOOD 2016-10-25 15:46:19.669597124 +0200
| +++ BAD  2016-10-25 15:48:15.201596869 +0200
| @@ -5,24 +5,71 @@ Freezing remaining freezable tasks ... (
|  PM: Suspending system (mem)
|  cpg_div6_clock_disable: sdhi1ck
|  cpg_div6_clock_disable: sdhi0ck
| -PM: suspend of devices complete after 22.777 msecs
| -PM: late suspend of devices complete after 7.302 msecs
| +PM: suspend of devices complete after 22.932 msecs
| +PM: late suspend of devices complete after 7.311 msecs
|  cpg_div6_clock_disable: mmc0
|  cpg_div6_clock_disable: zb

pm_clk disables the clock of fec10000.bus.

| +simple-pm-bus fec10000.bus: runtime PM trying to suspend device but
active child

Suspend is aborted with -EBUSY, but zb stays disabled.

|  rmobile_pd_power_down: a3sp
| -PM: noirq suspend of devices complete after 18.424 msecs
| +PM: noirq suspend of devices complete after 26.937 msecs
|  Disabling non-boot CPUs ...
| -Suspended for 7.196 seconds
| +Suspended for 2.579 seconds
|  rmobile_pd_power_up: a3sp
| -cpg_div6_clock_enable: zb

pm_clk doesn't enable the clock of fec10000.bus.
(since it thinks it's still suspended?)

|  cpg_div6_clock_enable: sdhi0ck
|  cpg_div6_clock_enable: sdhi1ck
|  cpg_div6_clock_enable: mmc0
| -PM: noirq resume of devices complete after 134.580 msecs
| -PM: early resume of devices complete after 6.084 msecs
| -PM: resume of devices complete after 21.846 msecs
| -PM: Finishing wakeup.
| -Restarting tasks ... cpg_div6_clock_disable: mmc0
| -done.
| +PM: noirq resume of devices complete after 128.014 msecs
| +PM: early resume of devices complete after 6.121 msecs
| +Unhandled fault: imprecise external abort (0x1406) at 0x00000000
| +pgd = ee748000
| +[00000000] *pgd=7fc42835
| +Internal error: : 1406 [#1] SMP ARM
| +CPU: 0 PID: 1087 Comm: s2ram Not tainted
4.9.0-rc2-ape6evm-01959-g90550a414a6a6cd3-dirty #505
| +Hardware name: Generic R8A73A4 (Flattened Device Tree)
| +task: ee47a340 task.stack: ee686000
| +PC is at smsc911x_resume+0x6c/0xbc
| +LR is at smsc911x_resume+0x6c/0xbc

smsc911x_resume() tries to access the smsc911x while the bus clock zb is
not enabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
