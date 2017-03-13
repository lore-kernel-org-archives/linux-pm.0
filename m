From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 2/5] PM / Domains: Do not check if simple providers
 have phandle cells
Date: Mon, 13 Mar 2017 09:20:43 +0100
Message-ID: <CAPDyKFoEeErp7heeKK1UgcH=XU-LYyJUsRqH60cJzb5YyTY6gw@mail.gmail.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com> <1488882154-21485-3-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34937 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdCMIU4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 04:20:56 -0400
Received: by mail-ua0-f172.google.com with SMTP id q7so131980230uaf.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 01:20:44 -0700 (PDT)
In-Reply-To: <1488882154-21485-3-git-send-email-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>

On 7 March 2017 at 11:22, Dave Gerlach <d-gerlach@ti.com> wrote:
> There is no reason that a platform genpd driver registered using
> of_genpd_add_provider_simple needs to be constrained to having no cells
> in the "power-domains" phandle. Currently the genpd framework will fail
> if any arguments are passed with for a simple provider but the framework
> does not actually care, so remove the check for phandle argument count.
>
> This will allow greater flexibility for genpd providers to use their own
> arguments that are passed in the phandle and interpret them however they
> see fit.
>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> v3->v4:
>  Drop ti,sci-id device property and instead describe using phandle cell
>  for id.
>
>  drivers/base/power/domain.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e697dec9d25b..8e0550c27394 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1622,8 +1622,6 @@ static struct generic_pm_domain *genpd_xlate_simple(
>                                         struct of_phandle_args *genpdspec,
>                                         void *data)
>  {
> -       if (genpdspec->args_count != 0)
> -               return ERR_PTR(-EINVAL);
>         return data;
>  }
>
> --
> 2.11.0
>
