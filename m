From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] PM / Domains: Fix potential NULL pointer dereference
Date: Fri, 4 Mar 2016 12:07:23 +0100
Message-ID: <CAPDyKFpha7TQbvZ2B9aDuoRuOFEHzD5ZwOCADvs6=0pwCNSgQg@mail.gmail.com>
References: <1457088915-17284-1-git-send-email-jonathanh@nvidia.com>
	<1457088915-17284-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457088915-17284-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 4 March 2016 at 11:55, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> In the function of_genpd_get_from_provider(), we never check to see if
> the argument 'genpdspec' is NULL before dereferencing it. Add error
> checking to handle any NULL pointers.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ea9f2aa3fc33..5bdb42bf40f4 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1686,6 +1686,9 @@ struct generic_pm_domain *of_genpd_get_from_provider(
>         struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
>         struct of_genpd_provider *provider;
>
> +       if (!genpdspec)
> +               return ERR_PTR(-EINVAL);
> +
>         mutex_lock(&of_genpd_mutex);
>
>         /* Check if we have such a provider in our array */
> --
> 2.1.4
>
