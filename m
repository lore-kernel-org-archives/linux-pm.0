From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] thermal,rcar_thermal: Add dependency on HAS_IOMEM
Date: Mon, 27 Jan 2014 12:32:04 +0100
Message-ID: <2789122.Lrp2LJzQED@avalon>
References: <1390812058-9002-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48858 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaA0LbR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jan 2014 06:31:17 -0500
In-Reply-To: <1390812058-9002-1-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au

Hi Richard,

Thank you for the patch.

On Monday 27 January 2014 09:40:58 Richard Weinberger wrote:
> Commit beeb5a1e (thermal: rcar-thermal: Enable driver compilation with
> COMPILE_TEST) broke build on archs wihout io memory.
> 
> On archs like S390 or um this driver cannot build nor work.
> Make it depend on HAS_IOMEM to bypass build failures.
> 
> drivers/thermal/rcar_thermal.c:404: undefined reference to
> `devm_ioremap_resource' drivers/thermal/rcar_thermal.c:426: undefined
> reference to `devm_ioremap_resource'
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'm not the driver maintainer so I won't take this patch in my tree. Could you 
please keep an eye on it to make sure it gets picked by the maintainers ?

> ---
>  drivers/thermal/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 35c0664..88efa8f 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -136,6 +136,7 @@ config SPEAR_THERMAL
>  config RCAR_THERMAL
>  	tristate "Renesas R-Car thermal driver"
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	help
>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
>  	  thermal framework.

-- 
Regards,

Laurent Pinchart

