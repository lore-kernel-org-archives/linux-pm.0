From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: If an OF node is found but no device probed
 yet, defer.
Date: Thu, 12 Mar 2015 09:39:45 +0100
Message-ID: <CAPDyKFrFOTUVZ6qd5D+-otwAQxXJ78G47p76Pnjmvv_TvkG0=w@mail.gmail.com>
References: <1426087648-3862-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:44038 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbCLIjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 04:39:45 -0400
Received: by qcwr17 with SMTP id r17so16660240qcw.11
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2015 01:39:45 -0700 (PDT)
In-Reply-To: <1426087648-3862-1-git-send-email-eric@anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On 11 March 2015 at 16:27, Eric Anholt <eric@anholt.net> wrote:
> If we've declared a power domain in the OF, and the OF node is found
> but the requested domain hasn't been registered on it yet, then we
> probably have just tried to probe before the power domain driver has.
> Defer our device's probe until it shows up.

As Geert also pointed out in his reply; I think the proper solution is
to move the registration of the PM domain to an earlier init level.

The main reason from my side is that I don't want us to invent yet
another "probe scenario", since we currently already have some
difficulties to handle the existing ones. Like the issue below.
http://marc4.marc.info/?t=142392781500004&r=1&w=2

Kind regards
Uffe

>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> I ran into this when turning my ad-hoc code for BCM2835 (Raspberry Pi)
> USB poweron support in the DWC2 controller to an OF-based power domain
> declaration.
>
> drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ba4abbe..2b93c98 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2064,7 +2064,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>  struct generic_pm_domain *of_genpd_get_from_provider(
>                                         struct of_phandle_args *genpdspec)
>  {
> -       struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
> +       struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
>         struct of_genpd_provider *provider;
>
>         mutex_lock(&of_genpd_mutex);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
