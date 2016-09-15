From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] PM / Domains: Allow holes in genpd_data.domains array
Date: Thu, 15 Sep 2016 16:16:25 +0200
Message-ID: <CAPDyKFqA8Fevi3LivsypeXjmF979=eFBEE9Gd82iL06FzMACvg@mail.gmail.com>
References: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com> <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33774 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757389AbcIOOQ2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 10:16:28 -0400
Received: by mail-lf0-f50.google.com with SMTP id h127so39120708lfh.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2016 07:16:27 -0700 (PDT)
In-Reply-To: <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 15 September 2016 at 14:05, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> In platforms such as Rockchip's, the array of domains isn't always
> filled without holes, as which domains are present depend on the
> particular SoC revision.
>
> By allowing holes to be in the array, such SoCs can still use a single
> set of constants to index the array of power domains.
>
> Fixes: 0159ec670763 ("PM / Domains: Verify the PM domain is present when adding a provider")
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

>
> ---
>
> v2: Also skip holes in the error path.
> ---
>  drivers/base/power/domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b0cf46dcae73..83ae3d7d3fdd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1581,6 +1581,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>         mutex_lock(&gpd_list_lock);
>
>         for (i = 0; i < data->num_domains; i++) {
> +               if (!data->domains[i])
> +                       continue;
>                 if (!pm_genpd_present(data->domains[i]))
>                         goto error;
>
> @@ -1598,6 +1600,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>
>  error:
>         while (i--) {
> +               if (!data->domains[i])
> +                       continue;
>                 data->domains[i]->provider = NULL;
>                 data->domains[i]->has_provider = false;
>         }
> --
> 2.7.4
>
