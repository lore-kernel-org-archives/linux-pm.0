From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Provide dummy governors if CONFIG_PM_GENERIC_DOMAINS=n
Date: Thu, 9 Feb 2017 11:40:47 +0100
Message-ID: <CAPDyKFoRFKbDSqD2XN4zXx+4T7yytU-1LPg=cLHWvKMXKH8uuA@mail.gmail.com>
References: <1486579075-21498-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:34347 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdBIKkt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 05:40:49 -0500
Received: by mail-ua0-f176.google.com with SMTP id 35so131252956uak.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2017 02:40:48 -0800 (PST)
In-Reply-To: <1486579075-21498-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 8 February 2017 at 19:37, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> This allows to compile-test drivers that refer to governors (always by
> reference) when CONFIG_PM_GENERIC_DOMAINS=n.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 81ece61075dff0e7..5339ed5bd6f9d04a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -182,6 +182,9 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
>  {
>         return -ENOTSUPP;
>  }
> +
> +#define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
> +#define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
>
>  static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
> --
> 1.9.1
>
