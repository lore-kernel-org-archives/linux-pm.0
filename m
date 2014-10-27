From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 07/11] ARM: shmobile: r8a7740/armadillo legacy: Add
 A4MP pm domain support
Date: Mon, 27 Oct 2014 13:03:06 +0900
Message-ID: <20141027040305.GG31487@verge.net.au>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-8-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414063141-8856-8-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23, 2014 at 01:18:57PM +0200, Geert Uytterhoeven wrote:
> Add support for the A4MP power domain, and hook up the HDMI-Link and FSI
> hardware blocks.
> This domain also contains the SPU2, FMSI, and BBIF2 hardware blocks,
> but these are currently not used by any driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Is it possible to split this into two patches.

A board patch (that touches board-armadillo800eva.c)
and an SoC patch (the rest). Likewise for any remaining
patches in this series that touch both board and SoC code.

The reason for this is that it would make the patches fit
the branch scheme that arm-soc people like. In particular splitting
patches between soc and boards branches.

Please note that I have queued up four of the SoC earlier patches in the 
series. You don't need to repost them.

> ---
> v3:
>   - No changes,
> v2:
>   - Also hook up HDMI-Link, which was not documented in the datasheet as
>     belonging to A4MP,
>   - Really add A4MP and drop the FIXME, as a fix for the interrupt storm
>     is available.
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 2 ++
>  arch/arm/mach-shmobile/pm-r8a7740.c            | 3 +++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 735036038951868d..c37d7b697a35322d 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1234,6 +1234,8 @@ static void __init eva_init(void)
>  	static struct pm_domain_device domain_devices[] __initdata = {
>  		{ "A4LC", &lcdc0_device },
>  		{ "A4LC", &hdmi_lcdc_device },
> +		{ "A4MP", &hdmi_device },
> +		{ "A4MP", &fsi_device },
>  		{ "A4S",  &sh_eth_device },
>  		{ "A3SP", &pwm_device },
>  		{ "A3SP", &sdhi0_device },
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
> index 932c2a621e81ac26..081a4f9726a0c909 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -37,6 +37,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
>  		.genpd.name	= "A4LC",
>  		.bit_shift	= 1,
>  	}, {
> +		.genpd.name	= "A4MP",
> +		.bit_shift	= 2,
> +	}, {
>  		.genpd.name	= "A3RV",
>  		.bit_shift	= 6,
>  	}, {
> -- 
> 1.9.1
> 
