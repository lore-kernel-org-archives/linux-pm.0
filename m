From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 06/11] ARM: shmobile: r8a7740: Add A3SG pm domain
 support
Date: Mon, 27 Oct 2014 13:00:35 +0900
Message-ID: <20141027040034.GF31487@verge.net.au>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-7-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55933 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbaJ0EAj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Oct 2014 00:00:39 -0400
Content-Disposition: inline
In-Reply-To: <1414063141-8856-7-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 01:18:56PM +0200, Geert Uytterhoeven wrote:
> Add support for the A3SG power domain, and hook it up as a subdomain of
> A4S.
> This domain contains the SGX540 hardware block, which is currently not
> used by any driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
> v3:
>   - No changes,
> v2:
>   - No changes.
> ---
>  arch/arm/mach-shmobile/pm-r8a7740.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
> index 1d916038660d4b8a..932c2a621e81ac26 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -51,6 +51,9 @@ static struct rmobile_pm_domain r8a7740_pm_domains[] = {
>  		.gov		= &pm_domain_always_on_gov,
>  		.no_debug	= true,
>  		.suspend	= r8a7740_pd_a3sp_suspend,
> +	}, {
> +		.genpd.name	= "A3SG",
> +		.bit_shift	= 13,
>  	},
>  };
>  
> @@ -58,6 +61,7 @@ void __init r8a7740_init_pm_domains(void)
>  {
>  	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
>  	pm_genpd_add_subdomain_names("A4S", "A3SP");
> +	pm_genpd_add_subdomain_names("A4S", "A3SG");
>  }
>  #endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
>  
> -- 
> 1.9.1
> 
