From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 4/4] soc: samsung: pm_domains: Provide real name for
 all supported domains
Date: Sat, 28 Jan 2017 17:16:22 +0200
Message-ID: <20170128151622.scfqft3hxfdjh7ca@kozik-lap>
References: <1485514072-29502-5-git-send-email-m.szyprowski@samsung.com>
 <CGME20170127144908eucas1p14c50396f670a01c31a69ec95b636a0e1@eucas1p1.samsung.com>
 <1485528538-30256-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35806 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbdA1PQb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Jan 2017 10:16:31 -0500
Content-Disposition: inline
In-Reply-To: <1485528538-30256-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

On Fri, Jan 27, 2017 at 03:48:58PM +0100, Marek Szyprowski wrote:
> Device tree nodes for each power domain should use generic "power-domain"
> name, so using it as a domain name doesn't give much benefits. This patch
> adds human readable names for all supported domains, what makes debugging
> much easier.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Changelog:
> v2:
> - sorted all domains data by domain base address in the arrays
> ---
>  drivers/soc/samsung/pm_domains.c | 125 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
> index 5a0a46bcbe18..43003318b948 100644
> --- a/drivers/soc/samsung/pm_domains.c
> +++ b/drivers/soc/samsung/pm_domains.c
> @@ -30,6 +30,17 @@ struct exynos_pm_domain_config {
>  	u32 local_pwr_cfg;
>  };
>  
> +struct exynos_pm_domain_data {
> +	const char *name;
> +	u32 base;
> +};
> +
> +struct exynos_pm_domain_soc_data {
> +	const char *compatible;
> +	unsigned int nr_domains;
> +	const struct exynos_pm_domain_data *domains;
> +};
> +
>  /*
>   * Exynos specific wrapper around the generic power domain
>   */
> @@ -123,6 +134,91 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
>  	return exynos_pd_power(domain, false);
>  }
>  
> +static const struct exynos_pm_domain_data exynos4210_domains[] __initconst = {
> +	{ "LCD1",	0x10023CA0 },
> +};
> +
> +static const struct exynos_pm_domain_data exynos4412_domains[] __initconst = {
> +	{ "CAM",	0x10023C00 },
> +	{ "TV",		0x10023C20 },
> +	{ "MFC",	0x10023C40 },
> +	{ "G3D",	0x10023C60 },
> +	{ "LCD0",	0x10023C80 },
> +	{ "ISP",	0x10023CA0 },
> +	{ "GPS",	0x10023CE0 },
> +	{ "GPS alive",	0x10023D00 },

That is a kind of duplication of DT and also spreading the description
of hardware between DT and driver. I understand the purpose. Messages
like:
	"power-domain has as child subdomain: power-domain."
are useless. However I do not like putting any of these in the driver.

How about adding a property "label" and parse it? Some other
drivers/nodes are using labels already to have a meaningful name, either
for user-space or for just user.

Patches 1-3 look fine.

Best regards,
Krzysztof
