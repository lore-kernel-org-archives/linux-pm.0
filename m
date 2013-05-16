From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: rcar: Fix typo in probe information message
Date: Thu, 16 May 2013 09:27:09 +0800
Message-ID: <1368667629.2063.25.camel@rzhang1-mobl4>
References: <1368572432-3943-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	 <5192CBD7.50200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <5192CBD7.50200@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-05-14 at 19:42 -0400, Eduardo Valentin wrote:
> Rui,
> 
> On 14-05-2013 19:00, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
applied to thermal -next.

thanks,
rui

> >  drivers/thermal/rcar_thermal.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index 28f0919..6138949 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -452,7 +452,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, common);
> >  
> > -	dev_info(dev, "%d sensor proved\n", i);
> > +	dev_info(dev, "%d sensor probed\n", i);
> >  
> >  	return 0;
> >  
> > 
> 
> 


