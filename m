From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Do not print PM domain add error message if EPROBE_DEFER
Date: Wed, 30 Nov 2016 15:34:49 +0100
Message-ID: <CAPDyKFqUY_2gmR3QTdVMuOAR5BrT9DVzXvdpgburK+QDNPA6bA@mail.gmail.com>
References: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:32960 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757885AbcK3Oev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 09:34:51 -0500
Received: by mail-wj0-f172.google.com with SMTP id xy5so175513977wjc.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2016 06:34:51 -0800 (PST)
In-Reply-To: <1480508696-19294-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 30 November 2016 at 13:24, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> EPROBE_DEFER is not an error, hence printing an error message like
>
>     renesas_irqc e61c0000.interrupt-controller: failed to add to PM domain always-on: -517
>
> may confuse the user.
>
> Suppress the error message in case of EPROBE_DEFER to fix this.
>
> Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by; Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 64164aac6ae3990a..f22137b52dcb641b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2032,8 +2032,9 @@ int genpd_dev_pm_attach(struct device *dev)
>         mutex_unlock(&gpd_list_lock);
>
>         if (ret < 0) {
> -               dev_err(dev, "failed to add to PM domain %s: %d",
> -                       pd->name, ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(dev, "failed to add to PM domain %s: %d",
> +                               pd->name, ret);
>                 goto out;
>         }
>
> --
> 1.9.1
>
