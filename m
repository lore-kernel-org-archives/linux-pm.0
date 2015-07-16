From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Try power off masters in error path of __pm_genpd_poweron()
Date: Thu, 16 Jul 2015 10:51:58 +0200
Message-ID: <CAPDyKFo=v2AGKq0vvoxfDPH-BSdtOBbCvmdnF4B0ehxkoTReXw@mail.gmail.com>
References: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36514 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066AbbGPIwA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 04:52:00 -0400
Received: by qgy5 with SMTP id 5so29618678qgy.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2015 01:51:59 -0700 (PDT)
In-Reply-To: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 11 June 2015 at 13:51, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> While powering up a genpd, its domain masters are first being powered up.
> In the error path of __pm_genpd_poweron(), we didn't care to try power off
> these domain masters. Let's deal with that to avoid leaving unused PM
> domains powered.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Rafael, just to let you know, this one still applies nicely for me on
top of the latest genpd changes.

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2327613..32dcb80 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -235,6 +235,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
>  }
>
>  /**
> + * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
> + * @genpd: PM domait to power off.
> + *
> + * Queue up the execution of pm_genpd_poweroff() unless it's already been done
> + * before.
> + */
> +static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
> +{
> +       queue_work(pm_wq, &genpd->power_off_work);
> +}
> +
> +/**
>   * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
>   * @genpd: PM domain to power up.
>   *
> @@ -315,8 +327,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>         return 0;
>
>   err:
> -       list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
> +       list_for_each_entry_continue_reverse(link,
> +                                       &genpd->slave_links,
> +                                       slave_node) {
>                 genpd_sd_counter_dec(link->master);
> +               genpd_queue_power_off_work(link->master);
> +       }
>
>         return ret;
>  }
> @@ -490,18 +506,6 @@ static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
>  }
>
>  /**
> - * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
> - * @genpd: PM domait to power off.
> - *
> - * Queue up the execution of pm_genpd_poweroff() unless it's already been done
> - * before.
> - */
> -static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
> -{
> -       queue_work(pm_wq, &genpd->power_off_work);
> -}
> -
> -/**
>   * pm_genpd_poweroff - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
>   *
> --
> 1.9.1
>
