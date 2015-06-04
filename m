From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Skip timings during syscore suspend/resume
Date: Thu, 4 Jun 2015 14:17:03 +0200
Message-ID: <CAPDyKFpbtOgCMjCnuODvmf6cHG7qD4_bSEGUwjrf3xmbHa77Tw@mail.gmail.com>
References: <1432913063-26691-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36583 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbbFDMRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 08:17:04 -0400
Received: by qkx62 with SMTP id 62so22491202qkx.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 05:17:03 -0700 (PDT)
In-Reply-To: <1432913063-26691-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On 29 May 2015 at 17:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> The PM Domain code uses ktime_get() to perform various latency
> measurements.  However, if ktime_get() is called while timekeeping is
> suspended, the following warning is printed:
>
>     WARNING: CPU: 0 PID: 1340 at kernel/time/timekeeping.c:576 ktime_get+0x3
>
> This happens when resuming the PM Domain that contains the clock events
> source, which calls pm_genpd_syscore_poweron(). Chain of operations is:
>
>     timekeeping_resume()
>     {
>         clockevents_resume()
>             sh_cmt_clock_event_resume()
>                 pm_genpd_syscore_poweron()
>                     pm_genpd_sync_poweron()
>                         genpd_syscore_switch()
>                             genpd_power_on()
>                                 ktime_get(), but timekeeping_suspended == 1
>         ...
>         timekeeping_suspended = 0;
>     }
>
> Fix this by adding a "timed" parameter to genpd_power_{on,off}() and
> pm_genpd_sync_power{off,on}(), to indicate whether latency measurements
> are allowed.  This parameter is passed as false in
> genpd_syscore_switch() (i.e. during syscore suspend/resume), and true in
> all other cases.

Hmm...

Will it ever make sense to do these time measurement once a system PM
suspend sequence has started? Especially since those measurements
might not be represent a typical case.

Could we turn of time measurement once system PM has started and turn
it on again once resumed?

Just and idea...

Kind regards
Uffe

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen on r8a7791/koelsch with CPG Clock Domain, _and_
> genpd->power_{off,on}() populated for debugging purposes.
>
> This is v2 of "PM / Domains: Skip latency measurements if timekeeping is
> suspended".
>
> Changes:
>   v2:
>     - Add a "timed" parameter instead of checking the
>       timekeeping_suspended flag, which is supposed to be private to the
>       time subsystem.
> ---
>  drivers/base/power/domain.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2327613d453929db..cdd547bd67df8218 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -181,7 +181,7 @@ static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>         genpd->cpuidle_data->idle_state->exit_latency = usecs64;
>  }
>
> -static int genpd_power_on(struct generic_pm_domain *genpd)
> +static int genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         ktime_t time_start;
>         s64 elapsed_ns;
> @@ -190,6 +190,9 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
>         if (!genpd->power_on)
>                 return 0;
>
> +       if (!timed)
> +               return genpd->power_on(genpd);
> +
>         time_start = ktime_get();
>         ret = genpd->power_on(genpd);
>         if (ret)
> @@ -208,7 +211,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
>         return ret;
>  }
>
> -static int genpd_power_off(struct generic_pm_domain *genpd)
> +static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>  {
>         ktime_t time_start;
>         s64 elapsed_ns;
> @@ -217,6 +220,9 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
>         if (!genpd->power_off)
>                 return 0;
>
> +       if (!timed)
> +               return genpd->power_off(genpd);
> +
>         time_start = ktime_get();
>         ret = genpd->power_off(genpd);
>         if (ret == -EBUSY)
> @@ -305,7 +311,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>                 }
>         }
>
> -       ret = genpd_power_on(genpd);
> +       ret = genpd_power_on(genpd, true);
>         if (ret)
>                 goto err;
>
> @@ -615,7 +621,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>                  * the pm_genpd_poweron() restore power for us (this shouldn't
>                  * happen very often).
>                  */
> -               ret = genpd_power_off(genpd);
> +               ret = genpd_power_off(genpd, true);
>                 if (ret == -EBUSY) {
>                         genpd_set_active(genpd);
>                         goto out;
> @@ -827,6 +833,7 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
>  /**
>   * pm_genpd_sync_poweroff - Synchronously power off a PM domain and its masters.
>   * @genpd: PM domain to power off, if possible.
> + * @timed: True if latency measurements are allowed.
>   *
>   * Check if the given PM domain can be powered off (during system suspend or
>   * hibernation) and do that if so.  Also, in that case propagate to its masters.
> @@ -836,7 +843,8 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
>   * executed sequentially, so it is guaranteed that it will never run twice in
>   * parallel).
>   */
> -static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd)
> +static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd,
> +                                  bool timed)
>  {
>         struct gpd_link *link;
>
> @@ -847,26 +855,28 @@ static void pm_genpd_sync_poweroff(struct generic_pm_domain *genpd)
>             || atomic_read(&genpd->sd_count) > 0)
>                 return;
>
> -       genpd_power_off(genpd);
> +       genpd_power_off(genpd, timed);
>
>         genpd->status = GPD_STATE_POWER_OFF;
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
>                 genpd_sd_counter_dec(link->master);
> -               pm_genpd_sync_poweroff(link->master);
> +               pm_genpd_sync_poweroff(link->master, timed);
>         }
>  }
>
>  /**
>   * pm_genpd_sync_poweron - Synchronously power on a PM domain and its masters.
>   * @genpd: PM domain to power on.
> + * @timed: True if latency measurements are allowed.
>   *
>   * This function is only called in "noirq" and "syscore" stages of system power
>   * transitions, so it need not acquire locks (all of the "noirq" callbacks are
>   * executed sequentially, so it is guaranteed that it will never run twice in
>   * parallel).
>   */
> -static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
> +static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd,
> +                                 bool timed)
>  {
>         struct gpd_link *link;
>
> @@ -874,11 +884,11 @@ static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
>                 return;
>
>         list_for_each_entry(link, &genpd->slave_links, slave_node) {
> -               pm_genpd_sync_poweron(link->master);
> +               pm_genpd_sync_poweron(link->master, timed);
>                 genpd_sd_counter_inc(link->master);
>         }
>
> -       genpd_power_on(genpd);
> +       genpd_power_on(genpd, timed);
>
>         genpd->status = GPD_STATE_ACTIVE;
>  }
> @@ -1056,7 +1066,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
>          * the same PM domain, so it is not necessary to use locking here.
>          */
>         genpd->suspended_count++;
> -       pm_genpd_sync_poweroff(genpd);
> +       pm_genpd_sync_poweroff(genpd, true);
>
>         return 0;
>  }
> @@ -1086,7 +1096,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
>          * guaranteed that this function will never run twice in parallel for
>          * the same PM domain, so it is not necessary to use locking here.
>          */
> -       pm_genpd_sync_poweron(genpd);
> +       pm_genpd_sync_poweron(genpd, true);
>         genpd->suspended_count--;
>
>         return genpd_start_dev(genpd, dev);
> @@ -1300,7 +1310,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
>                          * If the domain was off before the hibernation, make
>                          * sure it will be off going forward.
>                          */
> -                       genpd_power_off(genpd);
> +                       genpd_power_off(genpd, true);
>
>                         return 0;
>                 }
> @@ -1309,7 +1319,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
>         if (genpd->suspend_power_off)
>                 return 0;
>
> -       pm_genpd_sync_poweron(genpd);
> +       pm_genpd_sync_poweron(genpd, true);
>
>         return genpd_start_dev(genpd, dev);
>  }
> @@ -1367,9 +1377,9 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>
>         if (suspend) {
>                 genpd->suspended_count++;
> -               pm_genpd_sync_poweroff(genpd);
> +               pm_genpd_sync_poweroff(genpd, false);
>         } else {
> -               pm_genpd_sync_poweron(genpd);
> +               pm_genpd_sync_poweron(genpd, false);
>                 genpd->suspended_count--;
>         }
>  }
> --
> 1.9.1
>
