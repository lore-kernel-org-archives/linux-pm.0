From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v7 02/11] thermal: armada: Use msleep for long delays
Date: Tue, 2 Jan 2018 08:42:40 +0100
Message-ID: <20180102084240.3c43a770@xps13>
References: <20171222161413.20816-1-miquel.raynal@free-electrons.com>
        <20171222161413.20816-3-miquel.raynal@free-electrons.com>
        <20180101205537.GA29474@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101205537.GA29474-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Eduardo,

On Mon, 1 Jan 2018 12:55:39 -0800
Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Fri, Dec 22, 2017 at 05:14:04PM +0100, Miquel Raynal wrote:
> > From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > 
> > Use msleep for long (> 10ms) delays, instead of the busy waiting
> > mdelay. All delays are called from the probe routine, where
> > scheduling is allowed.
> > 
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>  
> 
> I am queueing this patch, however, ...
> 
> > ---
> >  drivers/thermal/armada_thermal.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c index 706d74798cbe..6c4af2622d4f
> > 100644 --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -113,7 +113,7 @@ static void armada370_init_sensor(struct
> > platform_device *pdev, reg &= ~PMU_TDC0_START_CAL_MASK;
> >  	writel(reg, priv->control);
> >  
> > -	mdelay(10);
> > +	msleep(10);  
> 
> I want to double check with you that msleep(10) is documented to reach
> up to 20ms, see:
> 
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see
> Documentation/timers/timers-howto.txt #43: FILE:
> drivers/thermal/armada_thermal.c:116:
> +	msleep(10);
> 
> WARNING: msleep < 20ms can sleep for up to 20ms; see
> Documentation/timers/timers-howto.txt #66: FILE:
> drivers/thermal/armada_thermal.c:146:
> +		msleep(10);
> 
> Just want to check that you are aware of this and that it won't cause
> troubles in the code flows changed in this patch. Driver is still in
> one piece, correct?

Thanks for queueing the series.

All of these delays are here to ensure that we do wait a minimum
amount of time to let the hardware be ready, IMHO waiting up to 20ms is
not an issue.

Best regards,
Miquèl

> 
> >  }
> >  
> >  static void armada375_init_sensor(struct platform_device *pdev,
> > @@ -127,11 +127,11 @@ static void armada375_init_sensor(struct
> > platform_device *pdev, reg &= ~A375_HW_RESETn;
> >  
> >  	writel(reg, priv->control + 4);
> > -	mdelay(20);
> > +	msleep(20);
> >  
> >  	reg |= A375_HW_RESETn;
> >  	writel(reg, priv->control + 4);
> > -	mdelay(50);
> > +	msleep(50);
> >  }
> >  
> >  static void armada380_init_sensor(struct platform_device *pdev,
> > @@ -143,7 +143,7 @@ static void armada380_init_sensor(struct
> > platform_device *pdev, if (!(reg & A380_HW_RESET)) {
> >  		reg |= A380_HW_RESET;
> >  		writel(reg, priv->control);
> > -		mdelay(10);
> > +		msleep(10);
> >  	}
> >  }
> >  
> > -- 
> > 2.11.0
> >   



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
