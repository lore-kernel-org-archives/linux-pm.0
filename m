From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
Date: Wed, 15 Jul 2015 11:17:04 +0300
Message-ID: <20150715081704.GA6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
 <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com>
 <55A3C53F.8090003@nvidia.com>
 <55A4F9B6.1070904@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A4F9B6.1070904-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 14, 2015 at 12:59:50PM +0100, Jon Hunter wrote:
> 
> 
> On 13/07/15 15:03, Jon Hunter wrote:
> > 
> > 
> > On 13/07/15 14:50, Peter De Schrijver wrote:
> >> On Mon, Jul 13, 2015 at 01:39:57PM +0100, Jon Hunter wrote:
> >>> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>>
> >>> We have added generic power domain support for Tegra SoCs. So now the
> >>> option M_GENERIC_DOMAINS must be enabled by default to have proper power
> >>
> >> Missing P :)
> > 
> > Ooops. I think introduced that error. Will fix.
> 
> Updated version ...
> 

Acked-By: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> From f7b951cd05973d74fc25e33a1aaec5a6e77bfdc0 Mon Sep 17 00:00:00 2001
> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Wed, 11 Mar 2015 13:40:46 +0800
> Subject: [PATCH 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
> 
> We have added generic power domain support for Tegra SoCs. So now the
> option PM_GENERIC_DOMAINS must be enabled by default to have proper power
> sequence.
> 
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/mach-tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 0fa4c5f8b1be..fdf86cae3b32 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -9,6 +9,7 @@ menuconfig ARCH_TEGRA
>  	select HAVE_ARM_TWD if SMP
>  	select PINCTRL
>  	select PM_OPP
> +	select PM_GENERIC_DOMAINS if PM
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select RESET_CONTROLLER
>  	select SOC_BUS
> -- 
> 2.1.4
> 
