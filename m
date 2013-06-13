From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Date: Thu, 13 Jun 2013 10:56:07 +0800
Message-ID: <1371092167.2135.21.camel@rzhang1-mobl4>
References: <1370311753-6463-1-git-send-email-horms+renesas@verge.net.au>
	 <51ADE343.1000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19511 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758246Ab3FMC42 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Jun 2013 22:56:28 -0400
In-Reply-To: <51ADE343.1000505@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht@gmail.com>

On Tue, 2013-06-04 at 08:53 -0400, Eduardo Valentin wrote:
> Simon, Ulrich,
> 
> On 03-06-2013 22:09, Simon Horman wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> > 
> > It is used by the interrupt handler. Fixes crash when booting via kexec
> > on APE6 board.
> > 
> > This problem was introduced by e0a5172e9eec7f0d3c476e013c51dab62f3fc666
> > ("thermal: rcar: add interrupt support") which was introduced in v3.8-rc3.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > [horms+renesas@verge.net.au: enhanced changelog to include commit
> >   that cuases the problem ]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> > ---
> >  drivers/thermal/rcar_thermal.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > Hi Zhang,
> > 
> > could you consider this fix for v3.10?
> > 
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index 8d7edd4..7641dcc 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -395,13 +395,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >  			return -ENODEV;
> >  		}
> >  
> > -		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> > -				       dev_name(dev), common);
> > -		if (ret) {
> > -			dev_err(dev, "irq request failed\n ");
> > -			return ret;
> > -		}
> > -
> 
> 
> Should this IRQ be disabled while this driver gets initialized? Reset
> state is enabled?
> 
the same question here.

even with this patch, I'm not sure what the irq handler can do as the
common->head for priv list is empty at this time.

thanks,
rui

> >  		/*
> >  		 * rcar_has_irq_support() will be enabled
> >  		 */
> > @@ -409,6 +402,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >  		if (IS_ERR(common->base))
> >  			return PTR_ERR(common->base);
> >  
> > +		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
> > +				       dev_name(dev), common);
> > +		if (ret) {
> > +			dev_err(dev, "irq request failed\n ");
> > +			return ret;
> > +		}
> > +
> >  		/* enable temperature comparation */
> >  		rcar_thermal_common_write(common, ENR, 0x00030303);
> >  
> > 
> 
> 


