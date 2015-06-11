From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: Re: [PATCH] PM / Domains: Try power off masters in error path of
 __pm_genpd_poweron()
Date: Thu, 11 Jun 2015 21:33:53 +0900
Message-ID: <55798031.50205@gmail.com>
References: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33330 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbFKMeC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 08:34:02 -0400
Received: by pablj1 with SMTP id lj1so1043749pab.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 05:34:01 -0700 (PDT)
In-Reply-To: <1434023511-4263-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org

W dniu 11.06.2015 o 20:51, Ulf Hansson pisze:
> While powering up a genpd, its domain masters are first being powered up.
> In the error path of __pm_genpd_poweron(), we didn't care to try power off
> these domain masters. Let's deal with that to avoid leaving unused PM
> domains powered.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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
> +	queue_work(pm_wq, &genpd->power_off_work);
> +}
> +
> +/**
>   * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
>   * @genpd: PM domain to power up.
>   *
> @@ -315,8 +327,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>  	return 0;
>  
>   err:
> -	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
> +	list_for_each_entry_continue_reverse(link,
> +					&genpd->slave_links,
> +					slave_node) {
>  		genpd_sd_counter_dec(link->master);
> +		genpd_queue_power_off_work(link->master);

It looks sensible to revert work already done however I wonder if this
is necessary for each slave. The first successful call to
pm_genpd_poweroff() will also walk through slave_links and queue the work.

Best regards,
Krzysztof


> +	}
>  
>  	return ret;
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
> -	queue_work(pm_wq, &genpd->power_off_work);
> -}
> -
> -/**
>   * pm_genpd_poweroff - Remove power from a given PM domain.
>   * @genpd: PM domain to power down.
>   *
> 

