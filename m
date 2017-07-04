From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/8] PM / Domains: Handle safely genpd_syscore_switch()
 call on non-genpd device
Date: Tue, 4 Jul 2017 15:01:15 +0200
Message-ID: <CAMuHMdXNAT6dW6Q_=_ZTUwiRmF0CpWXGfK0wYDgETT0xbTdZTA@mail.gmail.com>
References: <20170628145623.20716-1-krzk@kernel.org> <20170628145623.20716-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170628145623.20716-3-krzk@kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof, Rafael,

On Wed, Jun 28, 2017 at 4:56 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> genpd_syscore_switch() had two problems:
> 1. It silently assumed that device, it is being called for, belongs to
>    generic power domain and used container_of() on its power domain
>    pointer.  Such assumption might not be true always.
>
> 2. It iterated over list of generic power domains without holding
>    gpd_list_lock mutex thus list could have been modified in the same
>    time.
>
> Usage of genpd_lookup_dev() solves both problems as it is safe a call
> for non-generic power domains and uses mutex when iterating.
>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

This is commit 8b55e55ee44356d6 in pm/linux-next, also part of the pull
request "[GIT PULL] Power management updates for v4.13-rc1".

> Not tested on real hardware.

This causes the following BUG during s2ram on all my Renesas arm32 boards,
where the system timer is an IRQ safe device:

PM: Syncing filesystems ... done.
PM: Preparing system for sleep (mem)
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
PM: Suspending system (mem)
PM: suspend of devices complete after 122.841 msecs
PM: suspend devices took 0.130 seconds
PM: late suspend of devices complete after 2.682 msecs
PM: noirq suspend of devices complete after 29.951 msecs
Disabling non-boot CPUs ...
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:238
in_atomic(): 0, irqs_disabled(): 128, pid: 1730, name: s2ram
CPU: 0 PID: 1730 Comm: s2ram Not tainted
4.12.0-koelsch-07061-g810fee9afeba15ef #3592
Hardware name: Generic R8A7791 (Flattened Device Tree)
[<c020e9f4>] (unwind_backtrace) from [<c020a484>] (show_stack+0x10/0x14)
[<c020a484>] (show_stack) from [<c04017e8>] (dump_stack+0x7c/0x9c)
[<c04017e8>] (dump_stack) from [<c0240284>] (___might_sleep+0x124/0x160)
[<c0240284>] (___might_sleep) from [<c0717cfc>] (mutex_lock+0x18/0x60)
[<c0717cfc>] (mutex_lock) from [<c04de11c>] (genpd_lookup_dev+0x38/0x94)
[<c04de11c>] (genpd_lookup_dev) from [<c04dfd34>]
(pm_genpd_syscore_poweroff+0x8/0x2c)
[<c04dfd34>] (pm_genpd_syscore_poweroff) from [<c05fcb70>]
(sh_cmt_clock_event_suspend+0x18/0x28)
[<c05fcb70>] (sh_cmt_clock_event_suspend) from [<c027f174>]
(clockevents_suspend+0x40/0x54)
[<c027f174>] (clockevents_suspend) from [<c02762d8>]
(timekeeping_suspend+0x23c/0x278)
[<c02762d8>] (timekeeping_suspend) from [<c04ce028>]
(syscore_suspend+0x88/0x138)
[<c04ce028>] (syscore_suspend) from [<c025d740>]
(suspend_devices_and_enter+0x308/0x4fc)
[<c025d740>] (suspend_devices_and_enter) from [<c025db5c>]
(pm_suspend+0x228/0x280)
[<c025db5c>] (pm_suspend) from [<c025c6b8>] (state_store+0xac/0xcc)
[<c025c6b8>] (state_store) from [<c0342f9c>] (kernfs_fop_write+0x170/0x1b0)
[<c0342f9c>] (kernfs_fop_write) from [<c02e47dc>] (__vfs_write+0x20/0x108)
[<c02e47dc>] (__vfs_write) from [<c02e5b80>] (vfs_write+0xb8/0x144)
[<c02e5b80>] (vfs_write) from [<c02e6804>] (SyS_write+0x40/0x80)
[<c02e6804>] (SyS_write) from [<c0206c40>] (ret_fast_syscall+0x0/0x34)

Reverting the commit fixes the issue.

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 01e31d9f6c94..d31a4434b8b3 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1098,8 +1098,8 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>  {
>         struct generic_pm_domain *genpd;
>
> -       genpd = dev_to_genpd(dev);
> -       if (!pm_genpd_present(genpd))
> +       genpd = genpd_lookup_dev(dev);
> +       if (!genpd)
>                 return;
>
>         if (suspend) {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
