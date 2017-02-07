From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH 2/2] PM / Domains: Fix asynchronous execution of
 *noirq() callbacks
Date: Tue, 7 Feb 2017 14:23:22 +0100
Message-ID: <CAMuHMdXKLscaNzrD9r-WvVQCjh70GiS8TByXQasTv8zzw_dKYw@mail.gmail.com>
References: <1484241463-28435-1-git-send-email-ulf.hansson@linaro.org> <1484241463-28435-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35344 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbdBGNXY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 08:23:24 -0500
In-Reply-To: <1484241463-28435-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf, Rafael,

On Thu, Jan 12, 2017 at 6:17 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> As the PM core may invoke the *noirq() callbacks asynchronously, the
> current lock-less approach in genpd doesn't work. The consequence is that
> we may find concurrent operations racing to power on/off the PM domain.
>
> As of now, no immediate errors has been reported, but it's probably only a
> matter time. Therefor let's fix the problem now before this becomes a real
> issue, by deploying the locking scheme to the relevant functions.
>
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This is commit ef4f7e2c8335a56b in pm/linux-next.

> ---
>  drivers/base/power/domain.c | 62 ++++++++++++++++++++++++---------------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index fd2e3e1..6b23d82 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -729,16 +729,17 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,

> @@ -1070,13 +1070,17 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>         if (!pm_genpd_present(genpd))
>                 return;
>
> +       genpd_lock(genpd);
> +
>         if (suspend) {
>                 genpd->suspended_count++;
> -               genpd_sync_power_off(genpd);
> +               genpd_sync_power_off(genpd, 0);
>         } else {
> -               genpd_sync_power_on(genpd);
> +               genpd_sync_power_on(genpd, 0);
>                 genpd->suspended_count--;
>         }
> +
> +       genpd_unlock(genpd);
>  }

This causes the following BUG on all my Renesas arm32 boards, where the
system timer is an IRQ safe device:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:232
in_atomic(): 0, irqs_disabled(): 128, pid: 1751, name: s2ram
CPU: 0 PID: 1751 Comm: s2ram Not tainted
4.10.0-rc7-koelsch-05643-g27f4c73972a614fe #3354
Hardware name: Generic R8A7791 (Flattened Device Tree)
[<c020e9c4>] (unwind_backtrace) from [<c020a40c>] (show_stack+0x10/0x14)
[<c020a40c>] (show_stack) from [<c03f9818>] (dump_stack+0x7c/0x9c)
[<c03f9818>] (dump_stack) from [<c0240020>] (___might_sleep+0x124/0x160)
[<c0240020>] (___might_sleep) from [<c06fedfc>] (mutex_lock+0x18/0x60)
[<c06fedfc>] (mutex_lock) from [<c04de340>] (genpd_syscore_switch+0x2c/0x7c)
[<c04de340>] (genpd_syscore_switch) from [<c05ec328>]
(sh_cmt_clock_event_suspend+0x18/0x28)
[<c05ec328>] (sh_cmt_clock_event_suspend) from [<c027f9a4>]
(clockevents_suspend+0x40/0x54)
[<c027f9a4>] (clockevents_suspend) from [<c0276d48>]
(timekeeping_suspend+0x23c/0x278)
[<c0276d48>] (timekeeping_suspend) from [<c04cbb88>]
(syscore_suspend+0x88/0x138)
[<c04cbb88>] (syscore_suspend) from [<c025f618>]
(suspend_devices_and_enter+0x290/0x470)
[<c025f618>] (suspend_devices_and_enter) from [<c025fa20>]
(pm_suspend+0x228/0x280)
[<c025fa20>] (pm_suspend) from [<c025e60c>] (state_store+0xac/0xcc)
[<c025e60c>] (state_store) from [<c0340c4c>] (kernfs_fop_write+0x160/0x19c)
[<c0340c4c>] (kernfs_fop_write) from [<c02e3054>] (__vfs_write+0x20/0x108)
[<c02e3054>] (__vfs_write) from [<c02e4424>] (vfs_write+0xb8/0x144)
[<c02e4424>] (vfs_write) from [<c02e5014>] (SyS_write+0x40/0x80)
[<c02e5014>] (SyS_write) from [<c0206cc0>] (ret_fast_syscall+0x0/0x34)

Reverting the commit fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
