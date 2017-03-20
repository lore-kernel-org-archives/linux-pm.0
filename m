From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Respect errors from genpd's
 ->power_off() callback
Date: Mon, 20 Mar 2017 16:41:55 +0530
Message-ID: <20170320111155.GJ25659@vireshk-i7>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34950 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754099AbdCTLiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:38:03 -0400
Received: by mail-pg0-f41.google.com with SMTP id t143so10213405pgb.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:37:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 20-03-17, 11:19, Ulf Hansson wrote:
> The current code in genpd_sync_power_off(), doesn't care about potential
> errors being returned from genpd's ->power_off() callback.
> 
> Obviously this behaviour could lead to problems, such as incorrectly
> setting the genpd's status to GPD_STATE_POWER_OFF, but also to incorrectly
> decrease the subdomain count for the masters, which potentially allows them
> to be powered off in the next recursive call to genpd_sync_power_off().
> 
> Let's fix this behaviour by bailing out when the ->power_off() callback
> returns an error code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e63712d..8a2bfc8 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -767,7 +767,8 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  
>  	/* Choose the deepest state when suspending */
>  	genpd->state_idx = genpd->state_count - 1;
> -	_genpd_power_off(genpd, false);
> +	if (_genpd_power_off(genpd, false))
> +		return;
>  
>  	genpd->status = GPD_STATE_POWER_OFF;

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
