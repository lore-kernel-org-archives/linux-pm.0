From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] PM / Domains: Ensure subdomain is not in use before removing
Date: Thu, 27 Aug 2015 13:37:14 +0200
Message-ID: <CAMuHMdUtnb1_e9v3U_iUT2qxTdacaVHY7tzbR_1kgykC+1MUyw@mail.gmail.com>
References: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33247 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbbH0LhP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 07:37:15 -0400
Received: by oigm66 with SMTP id m66so4020657oig.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2015 04:37:15 -0700 (PDT)
In-Reply-To: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Jon,

On Thu, Aug 27, 2015 at 11:21 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> The function pm_genpd_remove_subdomain() removes a subdomain from a
> generic PM domain, however, it does not check if the subdomain has any
> slave domains or device attached before doing so. Therefore, add a test
> to verify that the subdomain does not have any slave domains associated
> or any device attached before removing.

So far no-one ran into this, as there are no callers of
pm_genpd_remove_subdomain() in mainline or -next.

Do you plan to add a caller?

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/base/power/domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 27888a90ca98..a3ed71d8129a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1469,6 +1469,11 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>
>         mutex_lock(&genpd->lock);
>
> +       if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
>         list_for_each_entry(link, &genpd->master_links, master_node) {
>                 if (link->slave != subdomain)
>                         continue;
> @@ -1487,6 +1492,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                 break;
>         }
>
> +out:
>         mutex_unlock(&genpd->lock);
>
>         return ret;
> --
> 2.1.4

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
