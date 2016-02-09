From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC v11 3/3] PM / Domains: remove old power on/off latencies.
Date: Tue, 9 Feb 2016 16:41:39 +0100
Message-ID: <CAPDyKFqP8CdQRJVGgpT5WEL9OqYWMcfvgniR0vVWEmofggRCaw@mail.gmail.com>
References: <1455023751-32521-1-git-send-email-ahaslam@baylibre.com>
	<1455023751-32521-4-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36193 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbcBIPlt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 10:41:49 -0500
Received: by mail-yk0-f176.google.com with SMTP id z7so101360380yka.3
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 07:41:49 -0800 (PST)
In-Reply-To: <1455023751-32521-4-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Titinger <mtitinger@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Axel Haslam <ahaslam+renesas@baylibre.com>

On 9 February 2016 at 14:15,  <ahaslam@baylibre.com> wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> Now that all known users have been converted to use state latencies,
> we can remove the latency field in the generic_pm_domain structure.
>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 6 ------
>  include/linux/pm_domain.h   | 2 --
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7099eb3..c4b3e36 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1230,12 +1230,6 @@ static int genpd_alloc_default_state(struct generic_pm_domain *genpd)
>                 goto err;
>         }
>
> -       genpd->states[0].power_on_latency_ns =
> -                               genpd->power_on_latency_ns;
> -
> -       genpd->states[0].power_off_latency_ns =
> -                               genpd->power_off_latency_ns;
> -
>         genpd->state_count = 1;
>         genpd->state_idx = 0;
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a5c3b68..2cc75d8 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -59,9 +59,7 @@ struct generic_pm_domain {
>         unsigned int prepared_count;    /* Suspend counter of prepared devices */
>         bool suspend_power_off; /* Power status before system suspend */
>         int (*power_off)(struct generic_pm_domain *domain);
> -       s64 power_off_latency_ns;
>         int (*power_on)(struct generic_pm_domain *domain);
> -       s64 power_on_latency_ns;
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         bool max_off_time_changed;
> --
> 2.6.3
>
