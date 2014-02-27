From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Turn latency warning into debug message
Date: Thu, 27 Feb 2014 23:43:35 +0100
Message-ID: <CAPDyKFoSQQqiL7=H12z9Ag2_DZNig_DGu_u9qrpQ53YtJhwUSQ@mail.gmail.com>
References: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:51309 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaB0Wng (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 17:43:36 -0500
Received: by mail-qc0-f171.google.com with SMTP id x3so4124834qcv.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2014 14:43:35 -0800 (PST)
In-Reply-To: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 27 February 2014 19:26, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> If devices don't provide latency data, this warning can be quite noisy until
> the pm domain was enabled and disabled a few times. Turn this warning into
> a debug message.

Just curious, why is the latency not interesting for you?

>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6d47498..93ca31f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -46,7 +46,7 @@
>         struct gpd_timing_data *__td = &dev_gpd_data(dev)->td;                  \
>         if (!__retval && __elapsed > __td->field) {                             \
>                 __td->field = __elapsed;                                        \
> -               dev_warn(dev, name " latency exceeded, new value %lld ns\n",    \
> +               dev_dbg(dev, name " latency exceeded, new value %lld ns\n",     \
>                         __elapsed);                                             \
>                 genpd->max_off_time_changed = true;                             \
>                 __td->constraint_changed = true;                                \
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
