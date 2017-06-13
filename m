From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 6/8] PM / Domains: Fix unsafe iteration over modified
 list of domains
Date: Tue, 13 Jun 2017 12:39:14 +0200
Message-ID: <CAPDyKFqo_JscR6e16pXceCT5YqwNFozkJw+YNB5Jz60kQd0Vxw@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-7-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612151748.7380-7-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> of_genpd_remove_last() iterates over list of domains and removes
> matching element thus it has to use safe version of list iteration.
>
> Fixes: 17926551c98a ("PM / Domains: Add support for removing nested PM domains by provider")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b74b5111957a..33467beaeea4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1934,14 +1934,14 @@ EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>   */
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
> -       struct generic_pm_domain *gpd, *genpd = ERR_PTR(-ENOENT);
> +       struct generic_pm_domain *gpd, *tmp, *genpd = ERR_PTR(-ENOENT);
>         int ret;
>
>         if (IS_ERR_OR_NULL(np))
>                 return ERR_PTR(-EINVAL);
>
>         mutex_lock(&gpd_list_lock);
> -       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +       list_for_each_entry_safe(gpd, tmp, &gpd_list, gpd_list_node) {
>                 if (gpd->provider == &np->fwnode) {
>                         ret = genpd_remove(gpd);
>                         genpd = ret ? ERR_PTR(ret) : gpd;
> --
> 2.9.3
>
