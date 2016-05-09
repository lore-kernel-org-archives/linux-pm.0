From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ARM: shmobile: pm-rmobile: Postpone call to pm_genpd_init()
Date: Mon, 9 May 2016 09:51:05 +0200
Message-ID: <CAPDyKFp=wB7aEtQ8R=p7NLQ+jbouACMazgdXLNXF7U0s+eoJQg@mail.gmail.com>
References: <1462350466-20466-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37859 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbcEIHvH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 03:51:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id a17so171203684wme.0
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 00:51:06 -0700 (PDT)
In-Reply-To: <1462350466-20466-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 4 May 2016 at 10:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> All local setup of the generic_pm_domain structure should have been
> completed before calling pm_genpd_init().
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/arm/mach-shmobile/pm-rmobile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
> index ecc92bad3500c1c1..175bd3d91ebcbcb4 100644
> --- a/arch/arm/mach-shmobile/pm-rmobile.c
> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
> @@ -131,13 +131,13 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
>         struct dev_power_governor *gov = rmobile_pd->gov;
>
>         genpd->flags = GENPD_FLAG_PM_CLK;
> -       pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>         genpd->dev_ops.active_wakeup    = rmobile_pd_active_wakeup;
>         genpd->power_off                = rmobile_pd_power_down;
>         genpd->power_on                 = rmobile_pd_power_up;
>         genpd->attach_dev               = cpg_mstp_attach_dev;
>         genpd->detach_dev               = cpg_mstp_detach_dev;
>         __rmobile_pd_power_up(rmobile_pd, false);
> +       pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>  }
>
>  static int rmobile_pd_suspend_busy(void)
> --
> 1.9.1
>
