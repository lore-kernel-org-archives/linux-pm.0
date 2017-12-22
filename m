From: Miquel RAYNAL <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 11/11] thermal: armada: Give meaningful names to the
 thermal zones
Date: Fri, 22 Dec 2017 16:51:01 +0100
Message-ID: <20171222165101.483a3a16@xps13>
References: <20171222093226.23456-1-miquel.raynal@free-electrons.com>
        <20171222093226.23456-12-miquel.raynal@free-electrons.com>
        <873742epwb.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <873742epwb.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, David Sniatkiwicz <davidsn-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Gregory,

On Fri, 22 Dec 2017 16:36:04 +0100
Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi Miquel,
>  
>  On ven., déc. 22 2017, Miquel Raynal
> <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > After registration to the thermal core, sysfs will make one entry
> > per instance of the driver in /sys/class/thermal_zoneX and
> > /sys/class/hwmon/hwmonX, X being the index of the instance, all of
> > them having the type/name "armada_thermal".
> >
> > Until now there was only one thermal zone per SoC but SoCs like
> > Armada A7K and Armada A8K have respectively two and three thermal
> > zones (one per AP and one per CP) and this number is subject to
> > grow in the future.
> >
> > Use dev_name() instead of the "armada_thermal" string to get a
> > meaningful name and be able to identify the thermal zones from
> > userspace.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > Reviewed-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>  
> 
> And here I also tested that when all the series was applied there was
> no regression on an Armada XP based board: PlatHome OpenBlocks AX3-4,
> and on an Armada 388 one: SolidRun Clearfog A1. hera again for both
> of them it was OK:

Thank you for testing, on my side I checked the last version (minor
changes) with both an Armada-385-AP and an Armada-8040-DB.

I will resend the series very soon.

Thanks,
Miquèl

> 
> Tested-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> 
> Gregory
> 
> > ---
> >  drivers/thermal/armada_thermal.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c index ea958e651312..454137f78eb3
> > 100644 --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -406,8 +406,8 @@ static int armada_thermal_probe(struct
> > platform_device *pdev) 
> >  	priv->data->init_sensor(pdev, priv);
> >  
> > -	thermal = thermal_zone_device_register("armada_thermal",
> > 0, 0,
> > -					       priv, &ops, NULL,
> > 0, 0);
> > +	thermal =
> > thermal_zone_device_register(dev_name(&pdev->dev), 0, 0, priv,
> > +					       &ops, NULL, 0, 0);
> >  	if (IS_ERR(thermal)) {
> >  		dev_err(&pdev->dev,
> >  			"Failed to register thermal zone
> > device\n"); -- 
> > 2.11.0
> >  
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
