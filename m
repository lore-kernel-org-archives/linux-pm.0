From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 01/10] PM / Domains: Fix removal of a subdomain
Date: Mon, 29 Feb 2016 13:13:40 +0100
Message-ID: <CAPDyKFrPrKe1FsZA1-RP57njheBL5H2t8s49-ZvOJ+Madqw7bA@mail.gmail.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
	<1456501724-28477-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456501724-28477-2-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 26 February 2016 at 16:48, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Commit 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use
> before removing") added a test to ensure that a subdomain is not is not
> a master to another subdomain or if any devices are using the subdomain
> before removing. This change incorrectly used the "slave_links" list to
> determine if the subdomain is a master to another subdomain, where it
> should have been using the "master_links" list instead. The
> "slave_links" list will never be empty for a subdomain and so a
> subdomain can never be removed. Fix this by testing if the
> "master_links" list is empty instead.
>
> Fixes: 30e7a65b3fdb ("PM / Domains: Ensure subdomain is not in use
>        before removing")
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

When you addressed the comments from Thierry, this also looks good to me.

Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e8ca290dbf9d..ea9f2aa3fc33 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1382,7 +1382,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>         mutex_lock(&subdomain->lock);
>         mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
>
> -       if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
> +       if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
>                 pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
>                         subdomain->name);
>                 ret = -EBUSY;
> --
> 2.1.4
>
