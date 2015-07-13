From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH V3 19/19] ARM: tegra: select PM_GENERIC_DOMAINS
Date: Mon, 13 Jul 2015 16:50:47 +0300
Message-ID: <20150713135047.GR6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8001 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbGMNux (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 09:50:53 -0400
Content-Disposition: inline
In-Reply-To: <1436791197-32358-20-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Mon, Jul 13, 2015 at 01:39:57PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> We have added generic power domain support for Tegra SoCs. So now the
> option M_GENERIC_DOMAINS must be enabled by default to have proper power

Missing P :)

> sequence.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
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
