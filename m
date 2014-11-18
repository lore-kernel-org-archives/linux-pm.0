From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Move struct pm_domain_data to pm_domain.h
Date: Wed, 19 Nov 2014 00:14:16 +0100
Message-ID: <2046094.7iVdopz3eL@vostro.rjw.lan>
References: <1415950892-4213-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51053 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932244AbaKRWxN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 17:53:13 -0500
In-Reply-To: <1415950892-4213-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Friday, November 14, 2014 08:41:32 AM Ulf Hansson wrote:
> The definition of the struct pm_domain_data better belongs in the
> header for the PM domains, let's move it there.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Queued up for 3.19, thanks!

> ---
>  include/linux/pm.h        | 6 +-----
>  include/linux/pm_domain.h | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 383fd68..45e3e78 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -538,11 +538,7 @@ enum rpm_request {
>  };
>  
>  struct wakeup_source;
> -
> -struct pm_domain_data {
> -	struct list_head list_node;
> -	struct device *dev;
> -};
> +struct pm_domain_data;
>  
>  struct pm_subsys_data {
>  	spinlock_t lock;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2e0e06d..9d254e2 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -100,6 +100,11 @@ struct gpd_timing_data {
>  	bool cached_stop_ok;
>  };
>  
> +struct pm_domain_data {
> +	struct list_head list_node;
> +	struct device *dev;
> +};
> +
>  struct generic_pm_domain_data {
>  	struct pm_domain_data base;
>  	struct gpd_timing_data td;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
