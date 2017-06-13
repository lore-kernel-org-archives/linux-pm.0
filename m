From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/8] PM / Domains: Fix unsafe iteration over modified
 list of device links
Date: Tue, 13 Jun 2017 12:38:42 +0200
Message-ID: <CAPDyKFq6W9=uZKwfM6QkDQCRMqkHkYO4pMRk0cs0yL_nbUBy2A@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-5-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151748.7380-5-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> pm_genpd_remove_subdomain() iterates over domain's master_links list and
> removes matching element thus it has to use safe version of list
> iteration.
>
> Fixes: f721889ff65a ("PM / Domains: Support for generic I/O PM domains (v8)")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9d3d3c2a5979..d1e438024e46 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1400,7 +1400,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_add_subdomain);
>  int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                               struct generic_pm_domain *subdomain)
>  {
> -       struct gpd_link *link;
> +       struct gpd_link *l, *link;
>         int ret = -EINVAL;
>
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
> @@ -1416,7 +1416,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>                 goto out;
>         }
>
> -       list_for_each_entry(link, &genpd->master_links, master_node) {
> +       list_for_each_entry_safe(link, l, &genpd->master_links, master_node) {
>                 if (link->slave != subdomain)
>                         continue;
>
> --
> 2.9.3
>
