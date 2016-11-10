From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [patch] PM / Domains: Fix a warning message
Date: Thu, 10 Nov 2016 20:25:36 +0100
Message-ID: <CAPDyKFouTue7DbDg0n136L_XO4UGX4_DiRh8Hr6zXy4a8_c5EA@mail.gmail.com>
References: <20161110125215.GA18664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33971 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934945AbcKJTZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 14:25:39 -0500
Received: by mail-wm0-f52.google.com with SMTP id u144so55079273wmu.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Nov 2016 11:25:38 -0800 (PST)
In-Reply-To: <20161110125215.GA18664@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lina Iyer <lina.iyer@linaro.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 10 November 2016 at 13:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The first argument of WARN() is the condition, followed by the message.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 661737c..7b4d41f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1297,7 +1297,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>          * powered on/off in that context.
>          */
>         if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
> -               WARN("Parent %s of subdomain %s must be IRQ safe\n",
> +               WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
>                                 genpd->name, subdomain->name);
>                 return -EINVAL;
>         }
