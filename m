From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/9] pm: domains: quieten down generic pm domains
Date: Fri, 13 Mar 2015 09:46:50 +0100
Message-ID: <CAPDyKFoBF-yu+_ST7V4b_wd640WKD88JbvamrSmYxWkxm8=OUw@mail.gmail.com>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
	<E1YW7sl-0003m2-4Z@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:47039 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbCMIqv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 04:46:51 -0400
Received: by qgfh3 with SMTP id h3so24193112qgf.13
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2015 01:46:50 -0700 (PDT)
In-Reply-To: <E1YW7sl-0003m2-4Z@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 March 2015 at 19:30, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> PM domains are rather noisy; scheduling behaviour can cause callbacks
> to take longer, which causes them to spit out a warning-level message
> each time a callback takes a little longer than the previous time.
> There really isn't a need for this, except when debugging.
>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0d8780c04a5e..b3fbc21da2dc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -173,8 +173,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
>         genpd->power_on_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
>         genpd_recalc_cpu_exit_latency(genpd);
> -       pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
> -               genpd->name, "on", elapsed_ns);
> +       pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> +                genpd->name, "on", elapsed_ns);
>
>         return ret;
>  }
> @@ -199,8 +199,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
>
>         genpd->power_off_latency_ns = elapsed_ns;
>         genpd->max_off_time_changed = true;
> -       pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
> -               genpd->name, "off", elapsed_ns);
> +       pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
> +                genpd->name, "off", elapsed_ns);
>
>         return ret;
>  }
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
