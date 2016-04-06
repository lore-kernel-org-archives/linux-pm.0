From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v7] thermal: add temperature sensor support for tango SoC
Date: Wed, 6 Apr 2016 08:48:25 -0700
Message-ID: <20160406154823.GA326@localhost.localdomain>
References: <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
 <56FD8582.80002@free.fr>
 <20160401015240.GB19409@localhost.localdomain>
 <570254D8.3090406@free.fr>
 <5703D28E.4040805@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32795 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcDFPs3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 11:48:29 -0400
Received: by mail-pf0-f177.google.com with SMTP id 184so36296851pff.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 08:48:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5703D28E.4040805@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Frias <sf84@laposte.net>

Hello Mason,

On Tue, Apr 05, 2016 at 04:58:22PM +0200, Mason wrote:
> On 04/04/2016 13:49, Mason wrote:
> 
> > +static bool temp_above_thresh(void __iomem *base, int thresh_idx)
> > +{
> > +	writel(CMD_READ | thresh_idx << 8, base + TEMPSI_CMD);
> > +	usleep_range(10, 20);
> > +	return readl(base + TEMPSI_RES);
> > +}
> 
> A colleague suggested a tweak for temp_above_thresh() which does not
> require messing with TEMPSI_CFG => v8 required.

OK.

> 
> > +static int tango_thermal_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res;
> > +	struct tango_thermal_priv *priv;
> > +
> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> > +
> > +	writel(CMD_ON, priv->base + TEMPSI_CMD);
> > +	writel(CYCLE_COUNT, priv->base + TEMPSI_CFG);
> > +
> > +	priv->zone = thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
> > +	if (IS_ERR(priv->zone))
> > +		return PTR_ERR(priv->zone);
> > +
> > +	priv->thresh_idx = IDX_MIN;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> 
> It seems tango_get_temp() is called (at least once) before the end of tango_thermal_probe()
> 
> Does that mean that the device must be fully initialized *BEFORE*
> thermal_zone_of_sensor_register() is called?
> (I assume it's that function that triggers the call to get_temp)
> 
> In that case, I need to move priv->thresh_idx = IDX_MIN; earlier.
> 


This is correct understanding. The driver is expected to be ready to
answer any of the .ops calls during the registration. Specially if you
have cooling devices that may be bound to the thermal zone, then you
would have more than one calls.

With that said, I would suggest to move the line
+	priv->thresh_idx = IDX_MIN;

up, yes.

> 
> Also, can get_temp() be called concurrently?
> For example, from user-space reading /sys/class/thermal/thermal_zone0/temp
> and from the kernel thread polling the sensor?
> Is locking taken care of in higher levels?


Yes, .get_temp() is called under tz->lock, in both cases, sysfs and
thread polling.  Of course, if you have extra data used in other context
that thermal core cannot see, than you would need extra locking. But if
you are only using your data in .get_temp(), which seams the case for
you, I would not see a need for an extra lock.

> 
> 
> For the record, I test the driver with the following script.
> Is it good enough?
> 
> TEMP="/sys/class/thermal/thermal_zone0/temp"
> 
> echo RUN IDLE
> for ((I=0; I<30; ++I)); do cat $TEMP; sleep 2; done
> 
> echo RUN HEAVY LOAD
> cpuburn-a9 &
> cpuburn-a9 &
> for ((I=0; I<60; ++I)); do cat $TEMP; sleep 2; done
> 
> echo KILL HEAVY LOAD
> kill $(jobs -p)
> for ((I=0; I<30; ++I)); do cat $TEMP; sleep 2; done

Well, for temperature testing, that should be enough to see if driver is
returning temperature. 

As for the temperature value validation, you would
probably need to instrument your setup with either thermal couples or ir
sensing to make sure your driver is reporting correct values.

Apart from temperature testing, do you have any cooling device registered in your system?

Do you see cooling taking action?

> 
> 
> Regards.
> 
