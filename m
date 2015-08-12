From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH 1/9] PM / Domains: Allocate memory outside domain locks
Date: Wed, 12 Aug 2015 12:47:37 -0700
Message-ID: <7hoaicnvae.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34614 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbHLTrk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 15:47:40 -0400
Received: by pawu10 with SMTP id u10so20955198paw.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2015 12:47:40 -0700 (PDT)
In-Reply-To: <1438731339-58317-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 4 Aug 2015 17:35:31 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org

Lina Iyer <lina.iyer@linaro.org> writes:

> In preparation for supporting IRQ-safe domains, allocate domain data
> outside the domain locks. These functions are not called in an atomic
> context, so we can always allocate memory using GFP_KERNEL. By
> allocating memory before the locks, we can safely lock the domain usi=
ng
> spinlocks instead of mutexes.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Krzysztof Koz=C5=82owski <k.kozlowski@samsung.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Reviewed-by: Kevin Hilman <khilman@linaro.org>

> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.=
c
> index 7666a1c..5fd1306 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1382,13 +1382,17 @@ int pm_genpd_remove_device(struct generic_pm_=
domain *genpd,
>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>  			   struct generic_pm_domain *subdomain)
>  {
> -	struct gpd_link *link;
> +	struct gpd_link *link, *itr;
>  	int ret =3D 0;
> =20
>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
>  	    || genpd =3D=3D subdomain)
>  		return -EINVAL;
> =20
> +	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
>  	mutex_lock(&genpd->lock);
>  	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
> =20
> @@ -1398,18 +1402,13 @@ int pm_genpd_add_subdomain(struct generic_pm_=
domain *genpd,
>  		goto out;
>  	}
> =20
> -	list_for_each_entry(link, &genpd->master_links, master_node) {
> -		if (link->slave =3D=3D subdomain && link->master =3D=3D genpd) {
> +	list_for_each_entry(itr, &genpd->master_links, master_node) {
> +		if (itr->slave =3D=3D subdomain && itr->master =3D=3D genpd) {
>  			ret =3D -EINVAL;
>  			goto out;
>  		}
>  	}
> =20
> -	link =3D kzalloc(sizeof(*link), GFP_KERNEL);
> -	if (!link) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
>  	link->master =3D genpd;
>  	list_add_tail(&link->master_node, &genpd->master_links);
>  	link->slave =3D subdomain;
> @@ -1420,7 +1419,8 @@ int pm_genpd_add_subdomain(struct generic_pm_do=
main *genpd,
>   out:
>  	mutex_unlock(&subdomain->lock);
>  	mutex_unlock(&genpd->lock);
> -
> +	if (ret)
> +		kfree(link);
>  	return ret;
>  }
> =20
> @@ -1511,17 +1511,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm=
_domain *genpd, int state)
>  	if (IS_ERR_OR_NULL(genpd) || state < 0)
>  		return -EINVAL;
> =20
> +	cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
> +	if (!cpuidle_data)
> +		return -ENOMEM;
> +
>  	mutex_lock(&genpd->lock);
> =20
>  	if (genpd->cpuidle_data) {
>  		ret =3D -EEXIST;
> -		goto out;
> -	}
> -	cpuidle_data =3D kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
> -	if (!cpuidle_data) {
> -		ret =3D -ENOMEM;
> -		goto out;
> +		goto err_drv;
>  	}
> +
>  	cpuidle_drv =3D cpuidle_driver_ref();
>  	if (!cpuidle_drv) {
>  		ret =3D -ENODEV;
