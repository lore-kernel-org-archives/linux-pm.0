From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 12/15] thermal: rcar-thermal: Enable driver compilation
 with COMPILE_TEST
Date: Thu, 02 Jan 2014 10:55:46 +0800
Message-ID: <1388631346.3739.74.camel@rzhang1-mobl4>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	 <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	 <5903007.OehDdPcG2U@avalon> <52A9C1C8.2030907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29476 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaABCzv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jan 2014 21:55:51 -0500
In-Reply-To: <52A9C1C8.2030907@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Thu, 2013-12-12 at 10:01 -0400, Eduardo Valentin wrote:
> On 11-12-2013 08:50, Laurent Pinchart wrote:
> > Hi Zhang and Eduardo,
> > 
> > Could you please pick this patch up for v3.14 ?
> 
> Yes Laurent, I can pick it.
> 
> > 
> > On Wednesday 27 November 2013 02:18:34 Laurent Pinchart wrote:
> >> This helps increasing build testing coverage.
> >>
> >> Cc: Zhang Rui <rui.zhang@intel.com>
> >> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> >> Cc: linux-pm@vger.kernel.org
> >> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >> Acked-by: Simon Horman <horms@verge.net.au>
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

applied.

thanks,
rui
> 
> >> ---
> >>  drivers/thermal/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index f35a1f7..661cafc 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -121,7 +121,7 @@ config SPEAR_THERMAL
> >>
> >>  config RCAR_THERMAL
> >>  	tristate "Renesas R-Car thermal driver"
> >> -	depends on ARCH_SHMOBILE
> >> +	depends on ARCH_SHMOBILE || COMPILE_TEST
> >>  	help
> >>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
> >>  	  thermal framework.
> 
> 


