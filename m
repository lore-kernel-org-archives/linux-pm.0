From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] PM / Domains: Try power off masters in error path of __pm_genpd_poweron()
Date: Thu, 03 Sep 2015 03:25:21 +0200
Message-ID: <2746179.D23d5TJhto@vostro.rjw.lan>
References: <1441181773-21733-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57259 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751541AbbICA5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 20:57:38 -0400
In-Reply-To: <1441181773-21733-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Wednesday, September 02, 2015 10:16:13 AM Ulf Hansson wrote:
> While powering up a genpd, its domain masters are first being powered up.
> In the error path of __pm_genpd_poweron(), we didn't care to try power off
> these domain masters. Let's deal with that to avoid leaving unused PM
> domains powered.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I'm queuing this up for the next PM pull request, thanks!


> ---
> 
> Changes in v2:
> 	Added Krzysztof's reviewed by tag.
> 
> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4167201..62f7572 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -213,6 +213,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
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
> @@ -259,8 +271,12 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>  	return 0;
>  
>   err:
> -	list_for_each_entry_continue_reverse(link, &genpd->slave_links, slave_node)
> +	list_for_each_entry_continue_reverse(link,
> +					&genpd->slave_links,
> +					slave_node) {
>  		genpd_sd_counter_dec(link->master);
> +		genpd_queue_power_off_work(link->master);
> +	}
>  
>  	return ret;
>  }
> @@ -349,18 +365,6 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
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

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
