From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/10] staging: board: Remove calls to of_genpd_get_from_provider()
Date: Thu, 8 Sep 2016 13:35:29 +0200
Message-ID: <CAPDyKFqRf4fU9E+tQ6ET+FUntORKbk1gH2QdKGwSeiFpAw-hrQ@mail.gmail.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com> <1471340976-5379-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471340976-5379-4-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Update the staging/board PM domain code to use the
> of_genpd_add_subdomain() and remove any calls to
> of_genpd_get_from_provider().
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe

> ---
>  drivers/staging/board/board.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index 45807d8287d1..86dc41101610 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -140,7 +140,6 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
>                                         const char *domain)
>  {
>         struct of_phandle_args pd_args;
> -       struct generic_pm_domain *pd;
>         struct device_node *np;
>
>         np = of_find_node_by_path(domain);
> @@ -151,14 +150,8 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
>
>         pd_args.np = np;
>         pd_args.args_count = 0;
> -       pd = of_genpd_get_from_provider(&pd_args);
> -       if (IS_ERR(pd)) {
> -               pr_err("Cannot find genpd %s (%ld)\n", domain, PTR_ERR(pd));
> -               return PTR_ERR(pd);
> -       }
> -       pr_debug("Found genpd %s for device %s\n", pd->name, pdev->name);
>
> -       return pm_genpd_add_device(pd, &pdev->dev);
> +       return of_genpd_add_device(&pd_args, &pdev->dev);
>  }
>  #else
>  static inline int board_staging_add_dev_domain(struct platform_device *pdev,
> --
> 2.1.4
>
