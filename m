From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
Date: Tue, 1 Sep 2015 15:28:27 +0200
Message-ID: <CAPDyKFoJvdw8t15FFxWuh07E9aM=xB6rexwGvtR=KYf7jfOVsw@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36116 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbbIAN23 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Sep 2015 09:28:29 -0400
Received: by wibz8 with SMTP id z8so32428570wib.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2015 06:28:27 -0700 (PDT)
In-Reply-To: <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On 5 August 2015 at 01:35, Lina Iyer <lina.iyer@linaro.org> wrote:
> Remove check for driver of a device, for runtime PM. Device may be
> suspended without an explicit driver. This check seems to be vestigial
> and incorrect in the current context.
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

I think this makes perfect sense!

Moreover in *theory*, I have considered both cases for how a device
currently gets attached/detached to its genpd and I can't find any
issues with $subject patch. With *both* cases I mean attaching the
device using *pm_genpd_[name]add_device() API or via the ->probe()
sequence using the dev_pm_domain_attach() API.

Now, of course that statement also relies on that drivers behaves
properly from a runtime PM point of view, for example make sure to do
pm_runtime_disable() at ->remove().

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5fd1306..ef8d19f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -394,8 +394,7 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
>                 if (stat > PM_QOS_FLAGS_NONE)
>                         return -EBUSY;
>
> -               if (pdd->dev->driver && (!pm_runtime_suspended(pdd->dev)
> -                   || pdd->dev->power.irq_safe))
> +               if (!pm_runtime_suspended(pdd->dev) || pdd->dev->power.irq_safe)
>                         not_suspended++;
>         }
>
> --
> 2.1.4
>
